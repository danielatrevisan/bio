
<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    String nOrdem = request.getParameter("nOrdem");
    
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

                sql = "insert into familia (ordem_id, nome, observacoes) values ("+nOrdem+",'"+nNome+"','"+nObs+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Fam�lia Cadastrada com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar fam�lia. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=familiaCad">
    <fieldset>
        <legend>Fam&iacute;lia</legend>
        <p>
           <label for="cNome">Fam&iacute;lia: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
       </p>
        <p>
           <label for="ordemId">Ordem: </label>
           <%
                            ResultSet ordem = null;
                            try {
                                    Connection connection = PosFactory.getConnection();

                                    sql = "select id, nome from ordem";
                                    
                                    PreparedStatement stmt = connection.prepareStatement(sql);

                                    ordem = stmt.executeQuery(); 
                                    
                                    connection.close();
                                } catch (SQLException sqle) {
                                    out.println("Ocorreu um erro ao cadastrar a fam�lia. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

        %>
        <select name="nOrdem" id="ordemId">
        <option value="null" selected></option>
        <%while(ordem.next()) { %>
            <option value="<%out.print(ordem.getString("id"));%>"><%out.print(ordem.getString("nome"));%></option>
        <%}%>
        </select>             
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
