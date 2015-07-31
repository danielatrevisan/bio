<%
	//Inicializa VariÃ¡veis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
     
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    String nEstadioMaturacao = request.getParameter("nEstadioMaturacao");
        
    String botao = request.getParameter("botao");
	
	//Trata a AÃ§Ã£o do BotÃ£o
out.println(sql);     
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
out.println(sql);        
    if(acao.equals("Salvar")) {
        try {
                Connection connection = PosFactory.getConnection();
out.println(sql);
                sql = "insert into estadio (estadio_maturacao_id, nome, observacoes) values ("+nEstadioMaturacao+",'"+nNome+"','"+nObs+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Estádio Cadastrado com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar estádio. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=estadioCad">
    <fieldset>
        <legend>Estádio</legend>
      <p>
        <label for="cNome">Estádio: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="estadioMaturacaoId">Estádio de Maturação: </label>
        <%
            ResultSet estadioMaturacao = null;
            try {
                Connection connection = PosFactory.getConnection();

                sql = "select id, nome from estadio_maturacao";
                                    
                PreparedStatement stmt = connection.prepareStatement(sql);

                estadioMaturacao = stmt.executeQuery(); 
                                    
                connection.close();
                } catch (SQLException sqle) {
                    out.println("Ocorreu um erro ao cadastrar o estádio. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                    sqle.printStackTrace();          
            }

        %>
        <select name="nEstadioMaturacao" id="especieAgrupadaId"> 
        <option value="null" selected></option>
        <%while(estadioMaturacao.next()) { %>
            <option value="<%out.print(estadioMaturacao.getString("id"));%>"><%out.print(estadioMaturacao.getString("nome"));%></option>
        <%}%>
        </select>          
      </p>   
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" columns="50" maxlength="1000"></textarea>
      </p>
    <% out.println(mensagem);%>
    <p>
    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>
    </fieldset>
</form>
