<%
	//Inicializa Variáveis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do Formulário
     
    String nNome = request.getParameter("tNome");    
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Bot�o
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }

    ResultSet ambiente = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from ambiente where upper(nome) like upper('%"+nNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		ambiente = stmt.executeQuery(); 
		  while(ambiente.next()) {
                    mensagem = mensagem + "<p>"+ambiente.getString("nome")+" - "+ambiente.getString("observacoes")+" "+"<a href='index.jsp?url=ambienteAlt&idAmbiente="+ambiente.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=ambienteDel&idAmbiente="+ambiente.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar o ambiente. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=ambientePes">
    <fieldset>
      <legend>Pesquisa - Ambiente da Coleta</legend>
       
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
            
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
      <p>
        <% 
         out.println(mensagem);
        %>        
      </p>
    </fieldset>
</form>