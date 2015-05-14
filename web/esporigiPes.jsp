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
        
    ResultSet esporigi = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from esporigi where upper(nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		esporigi = stmt.executeQuery(); 
		  while(esporigi.next()) {
                    mensagem = mensagem + "<p>"+esporigi.getString("nome")+" - "+esporigi.getString("observacoes")+" "+"<a href='index.jsp?url=esporigiAlt&idEsporigi="+esporigi.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=esporigiDel&idEsporigi="+esporigi.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar esporigi. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=esporigiPes">
    <fieldset>       
      <legend>Pesquisa - Esporigi</legend>       
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
            
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>      
    
    <% out.println(mensagem);%>  
    </fieldset>
</form>
