<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idProjeto = request.getParameter("idProjeto");
             
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

                sql = "update projeto set nome='"+nNome+"', observacoes='"+nObs+"' where id="+idProjeto;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Projeto alterado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar o projeto. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet projeto = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM projeto WHERE id = "+idProjeto;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					projeto = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
             projeto.next();              
%>

<form method="post" id="cadastro" action="index.jsp?url=projetoAlt">
    <fieldset>
        <legend>Projeto</legend>
      <p> <input id="idProjeto" name="idProjeto" type="hidden" value="<% out.print(idProjeto); %>" />
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(projeto.getString("nome")); %>" size="50" maxlength="255"/>
      </p>
      <p>        
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000"><%out.print(projeto.getString("observacoes"));%></textarea>
      </p>
    <% out.println(mensagem);%>
    <p>
    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>
    </fieldset>
</form>
