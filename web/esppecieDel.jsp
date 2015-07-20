<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
    
    String idEsppecie = request.getParameter("idEsppecie");
    
    String cNome = request.getParameter("tNome"); 
    String nObs = request.getParameter("tObs");
    
    String botao = request.getParameter("botao");
    Connection connection;
	    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Excluir")) {
        try {
               connection = PosFactory.getConnection();	

                sql = "delete from esppecie where id="+idEsppecie;
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Esppecie excluída com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=esppeciePes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=esppeciePes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir esppecie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
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


<form method="post" id="cadastro" action="index.jsp?url=esppecieDel">
    <fieldset>
        <legend>Esppecie</legend>
      <p> <input id="idEsppecie" name="idEsppecie" type="hidden" value="<% out.print(idEsppecie); %>" />        
        <label for="cNome">Esppecie: </label><input id="cNome" name="tNome" type="text" value="<%out.print(esppecie.getString("nome")); %>" size="30" maxlength="255" readonly/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" cols="50" maxlength="1000" readonly><%out.print(esppecie.getString("observacoes")); %></textarea>
      </p>
    
    <% out.println(mensagem);%>
    <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
    </p>  
    </fieldset>
</form>