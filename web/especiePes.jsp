<%
	//Inicializa VariÃ¡veis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
     
    String cNome = request.getParameter("tNome");
    
    String botao = request.getParameter("botao");
	
	//Trata a AÃ§Ã£o do BotÃ£o
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    ResultSet especie = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from especie where upper(nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		especie = stmt.executeQuery(); 
		  while(especie.next()) {
                    mensagem = mensagem + "<p>"+especie.getString("nome")+" - "+especie.getString("observacoes")+" "+"<a href='index.jsp?url=especieAlt&idEspecie="+especie.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=especieDel&idEspecie="+especie.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar espécie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=especiePes">
    <fieldset>
      <legend>Espécie</legend>       
      <p>
        <legend>Pesquisa - Espécie</legend>       
      <p>
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
            
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>      
    
    <% out.println(mensagem);%>  
    </fieldset>
</form>