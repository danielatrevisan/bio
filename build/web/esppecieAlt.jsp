<%
	//Inicializa VariÃ¡veis
       
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idEsppecie = request.getParameter("idEsppecie");
             
    String nEspecieAgrupada= request.getParameter("nEspecieAgrupada");
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    
    String botao = request.getParameter("botao");
    Connection connection = null;
    

    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
               connection = PosFactory.getConnection();	

                sql = "update esppecie set nome='"+nNome+"', especie_agrupada_id = '"+nEspecieAgrupada+"', observacoes='"+nObs+"' where id="+idEsppecie;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Esppecie alterado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar esppecie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet esppecie = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM esppecie WHERE id = "+idEsppecie;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					esppecie = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();          
			}
	
             esppecie.next(); 

%>

<form method="post" id="cadastro" action="index.jsp?url=esppecieAlt">
    <fieldset>
        <legend>Esppecie</legend>
      <p>
        <input id="idEsppecie" name="idEsppecie" type="hidden" value="<% out.print(idEsppecie); %>" />
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
                    out.println("Ocorreu um erro ao alterar esppecie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                    sqle.printStackTrace();          
                    }

        %>
        <select name="nEspecieAgrupada" id="especieAgrupadaId">
        <%while(especieAgrupada.next()) { %>
            <%if(esppecie.getString("especie_agrupada_id").equals(especieAgrupada.getString("id")))
            {%>
            <option value="<% out.print(especieAgrupada.getString("id"));%>" selected><%out.print(especieAgrupada.getString("nome"));%></option>
            <% }else {%>
            <option value="<%out.print(especieAgrupada.getString("id"));%>"><%out.print(especieAgrupada.getString("nome"));%></option>
        <%}}%>
        </select>
      </p>   
      <p>
        <label for="cNome">Esppecie: </label><input id="cNome" name="tNome" type="text" value="<%out.print(esppecie.getString("nome")); %>" size="30" maxlength="255"/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" cols="50" maxlength="1000"><%out.print(esppecie.getString("observacoes")); %></textarea>
      </p>
    <% out.println(mensagem);%>
    <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>  
    </fieldset>
</form>
