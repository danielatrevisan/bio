<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formul�rio
    
    String nEquipamento = request.getParameter("nEquipamento");
    String cNome = request.getParameter("tNome");    
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

                sql = "insert into aparelho (equipamento_id, nome, observacoes) values ('"+nEquipamento+"','"+cNome+"','"+nObs+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Aparelho Cadastrado com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar o aparelho. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=aparelhoCad">
    <fieldset>
        <legend>Aparelho</legend>

      <p>
        <label for="equipamentoId">Equipamento: </label>
        <%
            ResultSet equip = null;
            try {
                Connection connection = PosFactory.getConnection();

                sql = "select id, nome from equipamento order by nome";
                                    
                PreparedStatement stmt = connection.prepareStatement(sql);

                equip = stmt.executeQuery(); 
                                    
                connection.close();
                } catch (SQLException sqle) {
                    out.println("Ocorreu um erro ao cadastrar o equipamento. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                    sqle.printStackTrace();          
                }

        %>
        <select name="nEquipamento" id="equipamentoId">
            <%while(equip.next()) { %>
                <option value="<%out.print(equip.getString("id"));%>"><%out.print(equip.getString("nome"));%></option>
            <%}%>
        </select>
                            
      </p>        
      <p>
        <label for="cNome">Aparelho: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
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