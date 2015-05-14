<%
	//Inicializa Variáveis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do Formulário
     
    String cNome = request.getParameter("tNome");
        
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    ResultSet estadio = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from estadio where upper(nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		estadio = stmt.executeQuery(); 
		  while(estadio.next()) {
                    mensagem = mensagem + "<p>"+estadio.getString("nome")+" - "+estadio.getString("observacoes")+" "+"<a href='index.jsp?url=estadioAlt&idEstadio="+estadio.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=estadioDel&idEstadio="+estadio.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar est�dio. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=estadioPes">
    <fieldset>
       <legend>Pesquisa - Est�dio</legend>

      <p>
        <label for="cNome">Est�dio: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
