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
        
    ResultSet estadio_maturacao = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from estadio_maturacao where upper(nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		estadio_maturacao = stmt.executeQuery(); 
		  while(estadio_maturacao.next()) {
                    mensagem = mensagem + "<p>"+estadio_maturacao.getString("nome")+" - "+estadio_maturacao.getString("observacoes")+" "+"<a href='index.jsp?url=estadio_maturacaoAlt&idEstadio_maturacao="+estadio_maturacao.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=estadio_maturacaoDel&idEstadio_maturacao="+estadio_maturacao.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar estádio de maturação. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>
<form method="post" id="cadastro" action="index.jsp?url=estadio_maturacaoPes">
    <fieldset>
       <legend>Pesquisa - Estádio de maturação</legend>

      <p>
        <label for="cNome">Estádio de maturação: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
