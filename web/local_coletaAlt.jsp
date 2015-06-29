<%
	//Inicializa VariÃ¡veis
       
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idLocal = request.getParameter("idLocal");
             
    String nSigla= request.getParameter("nSigla");
    String nMunicipio= request.getParameter("nMunicipio");
    String nNome = request.getParameter("nNome");
    String nObs = request.getParameter("nObs");
    
    String botao = request.getParameter("botao");
    Connection connection = null;
    

    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
               connection = PosFactory.getConnection();	

                sql = "update local_coleta set nome='"+nNome+"', sigla = '"+nSigla+"', municipio = '"+nMunicipio+"', observacoes='"+nObs+"' where id="+idLocal;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Local alterado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar local. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet local = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM local_coleta WHERE id = "+idLocal;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					local = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();          
			}
	
             local.next(); 

%>

<form method="post" id="cadastro" action="index.jsp?url=local_coletaAlt">
    <fieldset>
        <legend>Local da Coleta</legend>
      <p>
        <label for="cNome">Local: </label><input id="cNome" name="nNome" type="text" value="<%out.print(local.getString("nome")); %>" size="30" maxlength="255"/>
      </p>
      <p>
        <label for="cSigla">Sigla: </label><input id="cSigla" name="nSigla" type="text" value="<%out.print(local.getString("sigla")); %>" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="cMun">Muncípio: </label><input id="cMunicipio" name="nMun" type="text" value="<%out.print(local.getString("municipio")); %>" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" cols="50" maxlength="1000"><%out.print(local.getString("observacoes")); %></textarea>
      </p>
      
    <% out.println(mensagem);%>
    <p>
    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>
    </fieldset>
</form>
