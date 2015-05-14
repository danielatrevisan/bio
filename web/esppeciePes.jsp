
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
        
    ResultSet esppecie = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from esppecie where upper(nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		esppecie = stmt.executeQuery(); 
		  while(esppecie.next()) {
                    mensagem = mensagem + "<p>"+esppecie.getString("nome")+" - "+esppecie.getString("observacoes")+" "+"<a href='index.jsp?url=esppecieAlt&idEsppecie="+esppecie.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=esppecieDel&idEsppecie="+esppecie.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar esppecie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=esppeciePes">
    <fieldset>
      <legend>Pesquisa - Esppecie</legend>

      <p>
        <label for="cNome">Esppecie: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>  
    </fieldset>
</form>
