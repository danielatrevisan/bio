<%
	//Inicializa Vari�veis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formul�rio
     
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    
    String botao = request.getParameter("botao");
	
	//Trata a A��o do Bot�o
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "insert into equipamento (nome, observacoes) values ('"+nNome+"','"+nObs+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Equipamento Cadastrado com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar o equipamento. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>


<form method="post" id="cadastro" action="index.jsp?url=equipamentoCad">
    <fieldset>
        <legend>Equipamento</legend>        
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="cObs">Observa��es: </label><textarea id="cObs" name="tObs"  rows="10" columns="50" maxlength="1000"></textarea>
      </p>
      
      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
     </p>
    </fieldset>
</form>