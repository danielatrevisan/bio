
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
        
    ResultSet familia = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from familia where upper(nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		familia = stmt.executeQuery(); 
		  while(familia.next()) {
                    mensagem = mensagem + "<p>"+familia.getString("nome")+" - "+familia.getString("observacoes")+" "+"<a href='index.jsp?url=familiaAlt&idFamilia="+familia.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=familiaDel&idFamilia="+familia.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar est�dio de matura��o. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=familiaPes">
    <fieldset>
       <legend>Pesquisa - Fam�lia</legend>

      <p>
        <label for="cNome">Fam�lia: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
