<%
	//Inicializa VariÃ¡veis
       
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idEstadio = request.getParameter("idEstadio");
             
    String nEstadioMaturacao= request.getParameter("nEstadioMaturacao");
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

                sql = "update estadio set nome='"+nNome+"', estadio_maturacao_id = '"+nEstadioMaturacao+"', observacoes='"+nObs+"' where id="+idEstadio;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Estádio alterado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar estadio. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet estadio = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM estadio WHERE id = "+idEstadio;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					estadio = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();          
			}
	
             estadio.next(); 

%>

<form method="post" id="cadastro" action="index.jsp?url=estadioAlt">
    <fieldset>
        <legend>Estádio</legend>
      <p>
        <input id="idEstadio" name="idEstadio" type="hidden" value="<% out.print(idEstadio); %>" />
        <label for="estadioMaturacaoId">Espécie Agrupada: </label>
        <%
            ResultSet estadioMaturacao = null;
                try {
                    connection = PosFactory.getConnection();

                    sql = "select id, nome from estadio_maturacao order by nome";
                                    
                    PreparedStatement stmt = connection.prepareStatement(sql);

                    estadioMaturacao = stmt.executeQuery(); 
                                    
                    connection.close();
                    } catch (SQLException sqle) {
                    out.println("Ocorreu um erro ao alterar estádio. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                    sqle.printStackTrace();          
                    }

        %>
        <select name="nEstadioMaturacao" id="estadioMaturacaoId">
        <%while(estadioMaturacao.next()) { %>
            <%if(estadio.getString("estadio_maturacao_id").equals(estadioMaturacao.getString("id")))
            {%>
            <option value="<% out.print(estadioMaturacao.getString("id"));%>" selected><%out.print(estadioMaturacao.getString("nome"));%></option>
            <% }else {%>
            <option value="<%out.print(estadioMaturacao.getString("id"));%>"><%out.print(estadioMaturacao.getString("nome"));%></option>
        <%}}%>
        </select>
      </p>   
      <p>
        <label for="cNome">Estádio: </label><input id="cNome" name="tNome" type="text" value="<%out.print(estadio.getString("nome")); %>" size="30" maxlength="255"/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" cols="50" maxlength="1000"><%out.print(estadio.getString("observacoes")); %></textarea>
      </p>
    <% out.println(mensagem);%>
    <p>
    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>
    </fieldset>
</form>
