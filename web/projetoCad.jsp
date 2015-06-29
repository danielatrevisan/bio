<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
        
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "insert into projeto (nome, observacoes) values ('"+nNome+"','"+nObs+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Projeto Cadastrado com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar projeto. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=projetoCad">
    <fieldset>
        <legend>Projeto</legend>
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="cObs">Observa��es: </label><textarea id="cObs" name="tObs"  rows="10" columns="50" maxlength="1000"> </textarea>
      </p>
    <% out.println(mensagem);%>
    <p>
    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>
    </fieldset>
</form>
