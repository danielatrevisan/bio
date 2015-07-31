<%
	//Inicializa VariÃ¡veis
       
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idEsporigi = request.getParameter("idEsporigi");
             
    String nEspecieAgrupada= request.getParameter("nEspecieAgrupada");
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

                sql = "update esporigi set nome='"+nNome+"', especie_agrupada_id = "+nEspecieAgrupada+", observacoes='"+nObs+"' where id="+idEsporigi;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Esporigi alterada com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar esporigi. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet esporigi = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM esporigi WHERE id = "+idEsporigi;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					esporigi = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();          
			}
	
             esporigi.next(); 

%>

<form method="post" id="cadastro" action="index.jsp?url=esporigiAlt">
    <fieldset>
        <legend>Esporigi</legend>
      <p>
        <label for="cNome">Esporigi: </label><input id="cNome" name="tNome" type="text" value="<%out.print(esporigi.getString("nome")); %>" size="30" maxlength="255"/>
      </p>
      <p>
        <input id="idEsporigi" name="idEsporigi" type="hidden" value="<% out.print(idEsporigi); %>" />
        <label for="especieAgrupadaId">Espécie Agrupada: </label>
        <%
            ResultSet especieAgrupada = null;
                try {
                    connection = PosFactory.getConnection();

                    sql = "select id, nome from especie_agrupada order by nome";
                                    
                    PreparedStatement stmt = connection.prepareStatement(sql);

                    especieAgrupada = stmt.executeQuery(); 
                                    
                    connection.close();
                    } catch (SQLException sqle) {
                    out.println("Ocorreu um erro ao alterar esporigi. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                    sqle.printStackTrace();          
                    }

        %>
        <select name="nEspecieAgrupada" id="especieAgrupadaId">
        <%
          if(esporigi.getObject("especie_agrupada_id")==null){
        %>
            <option value="null" selected>&nbsp;</option>                
            <%
                strId="null";
            }else
               strId=esporigi.getString("especie_agrupada_id");                
               while(especieAgrupada.next()) { %>
               <%
                 if(strId.equals(especieAgrupada.getString("id")))
               {%>
               <option value="<% out.print(especieAgrupada.getString("id"));%>" selected><%out.print(especieAgrupada.getString("nome"));%></option>
            <% }else {%>
            <option value="<%out.print(especieAgrupada.getString("id"));%>"><%out.print(especieAgrupada.getString("nome"));%></option>
        <%}}%>
        </select>
      </p>         
      <p>        
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" cols="50" maxlength="1000"><%out.print(esporigi.getString("observacoes")); %></textarea>
      </p>
      
    <% out.println(mensagem);%>
    <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>  
    </fieldset>
</form>
