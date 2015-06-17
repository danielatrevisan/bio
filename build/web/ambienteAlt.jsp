<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
        
    String idAmbiente = request.getParameter("idAmbiente");
             
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "update ambiente set nome='"+nNome+"', observacoes='"+nObs+"' where id="+idAmbiente;

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Ambiente alterado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar o ambiente. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

        <%
			ResultSet abiotico = null;
			try {
					Connection connection = PosFactory.getConnection();
		
					sql = "SELECT * FROM abiotico WHERE id = "+idAbiotico;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					abiotico = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();          
			}
		%>
            <% while(abiotico.next()) { %>
            
<form method="post" id="cadastro" action="ambienteCad.jsp">
    <fieldset>
        <legend>Ambiente da Coleta</legend>
       
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="cObs">Observa��es: </label><textarea id="cObs" name="tObs"  rows="10" columns="50" maxlength="1000"> </textarea>
      </p>
      
      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
      </p>
    </fieldset>
</form>