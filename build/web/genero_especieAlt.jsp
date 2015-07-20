<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idGenero_especie = request.getParameter("idGenero_especie");
             
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

                sql = "update genero_especie set nome='"+nNome+"', observacoes='"+nObs+"' where id="+idGenero_especie;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Gênero/Espécie alterado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar o gênero/espécie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet genero_especie = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM genero_especie WHERE id = "+idGenero_especie;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					genero_especie = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
             genero_especie.next();              
%>

<form method="post" id="cadastro" action="index.jsp?url=genero_especieAlt">
    <fieldset>
        <legend>Gênero / Espécie</legend>        
        
      <p> <input id="idGenero_especie" name="idGenero_especie" type="hidden" value="<% out.print(idGenero_especie); %>" />
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(genero_especie.getString("nome")); %>" size="50" maxlength="255"/>
      </p>
      <p>        
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000"><%out.print(genero_especie.getString("observacoes"));%></textarea>
      </p>
      
      <% out.println(mensagem);%>
      <p>
      <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
      </p>  
    </fieldset>
</form>