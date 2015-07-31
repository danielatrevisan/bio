<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idAmbiente = request.getParameter("idAmbiente");
             
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

                sql = "update ambiente set nome='"+nNome+"', observacoes='"+nObs+"' where id="+idAmbiente;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Ambiente alterado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar o ambiente. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet ambiente = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM ambiente WHERE id = "+idAmbiente;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					ambiente = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
             ambiente.next(); 
%>
            
<form method="post" id="cadastro" action="index.jsp?url=ambienteAlt">
    <fieldset>
        <legend>Ambiente da Coleta</legend>
        
        <p><input id="idAmbiente" name="idAmbiente" type="hidden" value="<% out.print(idAmbiente); %>" />
          <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(ambiente.getString("nome")); %>" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000"><%out.print(ambiente.getString("observacoes"));%></textarea>
      </p>
      
      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
      </p>
    </fieldset>
</form>