<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idAparelho = request.getParameter("idAparelho");
             
    String nEquipamento= request.getParameter("tEquipamento");
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    
    String botao = request.getParameter("botao");
    Connection connection;
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
               connection = PosFactory.getConnection();	

                sql = "update aparelho set nome='"+nNome+"', equipamento_id = '"+nEquipamento+"', observacoes='"+nObs+"' where id="+idAmbiente;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Aparelho alterado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar Aparelho. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet aparelho = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM aparelho WHERE id = "+idAparelho;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					aparelho = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();          
			}
	
             aparelho.next(); 

%>


<form method="post" id="cadastro" action="index.jsp?url=aparelhoAlt">
    <fieldset>
        <legend>Aparelho</legend>

      <p> <input id="idAparelho" name="idAparelho" type="hidden" value="<% out.print(idAparelho); %>" />
        <label for="equipamentoId" Equipamento: </label><input id="nEquipamento" name="tNome" type="text" value="<%out.print(aparelho.getString("equipamento_id")); %>" size="50" maxlength="255"/>
        <%
            ResultSet equip = null;
            try {
                Connection connection = PosFactory.getConnection();

                sql = "select id, nome from equipamento order by nome";
                                    
                PreparedStatement stmt = connection.prepareStatement(sql);

                equip = stmt.executeQuery();
                                    
                connection.close();
                } catch (SQLException sqle) {
                    out.println("Ocorreu um erro ao alterar o aparelho. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
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
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(aparelho.getString("nome")); %>" size="50" maxlength="255"/>
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