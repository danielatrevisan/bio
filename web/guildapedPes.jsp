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
        
    ResultSet guildaped = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from guildaped where upper(nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		guildaped = stmt.executeQuery(); 
		  while(guildaped.next()) {
                    mensagem = mensagem + "<p>"+guildaped.getString("nome")+" - "+guildaped.getString("observacoes")+" "+"<a href='index.jsp?url=guildapedAlt&idGuildaped="+guildaped.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=guildapedDel&idGuildaped="+guildaped.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar GUILDAPED. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=guildapedPes">
    <fieldset>
       <legend>Pesquisa - Guilda Trófica de Alimentação</legend>

      <p>
        <label for="cNome">GUILDAPED: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
