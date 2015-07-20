<%
	//Inicializa VariÃ¡veis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
     
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    String nEspecieAgrupada = request.getParameter("nEspecieAgrupada");
    
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

                sql = "insert into espatual (especie_agrupada_id, nome, observacoes) values ("+nEspecieAgrupada+",'"+nNome+"','"+nObs+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Espatual cadastrado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar espatual. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>


<form method="post" id="cadastro" action="index.jsp?url=espatualCad">
    <fieldset>
        <legend>Espatual</legend>
      <p>
        <label for="especieAgrupadaId">Espécie Agrupada: </label>
        <%
                            ResultSet especieAgrupada = null;
                            try {
                                    Connection connection = PosFactory.getConnection();

                                    sql = "select id, nome from especie_agrupada";
                                    
                                    PreparedStatement stmt = connection.prepareStatement(sql);

                                    especieAgrupada = stmt.executeQuery(); 
                                    
                                    connection.close();
                                } catch (SQLException sqle) {
                                    out.println("Ocorreu um erro ao cadastrar a espatual. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

        %>
        <select name="nEspecieAgrupada" id="especieAgrupadaId">
        <option value="null" selected></option>
        <%while(especieAgrupada.next()) { %>
            <option value="<%out.print(especieAgrupada.getString("id"));%>"><%out.print(especieAgrupada.getString("nome"));%></option>
        <%}%>
        </select>               
      </p>   
      <p>
        <label for="cNome">Espatual: </label><input id="cNome" name="tNome" type="text" size="30" maxlength="255"/>
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