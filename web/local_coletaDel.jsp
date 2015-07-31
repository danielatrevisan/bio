<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idLocal = request.getParameter("idLocal");
             
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    
    String botao = request.getParameter("botao");
    Connection connection;
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Excluir")) {
        try {
               connection = PosFactory.getConnection();	

                sql = "delete from local_coleta where id="+idLocal;
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Local coleta excluído com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=local_coletaPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=local_coletaPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir local coleta. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
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

<form method="post" id="cadastro" action="index.jsp?url=local_coletaDel">
    <fieldset>
        <legend>Local da Coleta</legend>
      <p> <input id="idLocal" name="idLocal" type="hidden" value="<% out.print(idLocal); %>" />
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
    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
    </p>
    </fieldset>
</form>
