<%
	//Inicializa VariÃ¡veis
       
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idFamilia = request.getParameter("idFamilia");
             
    String nOrdem= request.getParameter("nOrdem");
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    
    String botao = request.getParameter("botao");
    Connection connection = null;
    String strId="";

    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
               connection = PosFactory.getConnection();	

                sql = "update familia set nome='"+nNome+"', ordem_id = "+nOrdem+", observacoes='"+nObs+"' where id="+idFamilia;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Família alterado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar família. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet familia = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM familia WHERE id = "+idFamilia;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					familia = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();          
			}
	
             familia.next(); 

%>

<form method="post" id="cadastro" action="index.jsp?url=familiaAlt">
    <fieldset>
        <legend>Fam&iacute;lia</legend>
        <p>
        <label for="cNome">Família: </label><input id="cNome" name="tNome" type="text" value="<%out.print(familia.getString("nome")); %>" size="30" maxlength="255"/>
        </p>
        <p>
        <input id="idFamilia" name="idFamilia" type="hidden" value="<% out.print(idFamilia); %>" />
        <label for="ordemId">Ordem: </label>
        <%
            ResultSet ordem = null;
                try {
                    connection = PosFactory.getConnection();

                    sql = "select id, nome from ordem order by nome";
                                    
                    PreparedStatement stmt = connection.prepareStatement(sql);

                    ordem = stmt.executeQuery(); 
                                    
                    connection.close();
                    } catch (SQLException sqle) {
                    out.println("Ocorreu um erro ao alterar família. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                    sqle.printStackTrace();          
                    }

        %>
        <select name="nOrdem" id="ordemId">    
        <option value="null" selected></option>
        <%  
            if(familia.getObject("ordem_id")==null){
                %>
                <option value="null" selected>&nbsp;</option>                
            <%
                strId="null";
            }else
               strId=familia.getString("ordem_id");                
               while(ordem.next()) { %>
               <%
                 if(strId.equals(ordem.getString("id")))
               {%>
                   <option value="<% out.print(ordem.getString("id"));%>" selected><%out.print(ordem.getString("nome"));%></option>
               <% }else {%>
               <option value="<%out.print(ordem.getString("id"));%>"><%out.print(ordem.getString("nome"));%></option>
        <%}}%>
        </select>
      </p>         
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" cols="50" maxlength="1000"><%out.print(familia.getString("observacoes"));%></textarea>
      </p>
      
      <% out.println(mensagem);%>
      <p>
      <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
      </p>  
      </fieldset>
</form>
