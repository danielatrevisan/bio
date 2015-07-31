<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idCtrof = request.getParameter("idCtrof");
             
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
        
    if(acao.equals("Salvar")) {
        try {
               connection = PosFactory.getConnection();	

                sql = "update ctrof set nome='"+nNome+"', observacoes='"+nObs+"' where id="+idCtrof;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Categoria Trófica alterada com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar o Categoria Trófica. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet ctrof = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM ctrof WHERE id = "+idCtrof;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					ctrof = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
             ctrof.next(); 
%>

<form method="post" id="cadastro" action="index.jsp?url=categoria_troficaAlt">
    <fieldset>
        <legend>Categoria Trófica</legend>
        
      <p> <input id="idCtrof" name="idCtrof" type="hidden" value="<% out.print(idCtrof); %>" />
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(ctrof.getString("nome")); %>" size="50" maxlength="255"/>        
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" cols="50" maxlength="1000"><%out.print(ctrof.getString("observacoes"));%></textarea>        
      </p>
      
    <% out.println(mensagem);%>
    <p>
    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>  
    </fieldset>
</form>