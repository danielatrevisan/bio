<%
	//Inicializa VariÃ¡veis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
     
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    String nSigla = request.getParameter("tSigla");
    String nMunicipio = request.getParameter("tMunicipio");
        
    String botao = request.getParameter("botao");
	
	//Trata a AÃ§Ã£o do BotÃ£o
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "insert into local_coleta (nome, observacoes, sigla, municipio) values ('"+nNome+"','"+nObs+"','"+nSigla+"','"+nMunicipio+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Local da Coleta Cadastrado com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar local da coleta. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=local_coletaCad">
    <fieldset>
        <legend>Local da Coleta</legend>
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>            
      <p>
        <label for="cSigla">Sigla: </label><input id="cSigla" name="tSigla" type="text" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="cMun">Muncípio: </label><input id="cSigla" name="tMun" type="text" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" columns="50" maxlength="1000"> </textarea>
      </p>
      
    <% out.println(mensagem);%>
    <p>
    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>
    </fieldset>
</form>
