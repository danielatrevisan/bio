<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
    
    String idEsporigi = request.getParameter("idEsporigi");
    
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

                sql = "delete from esporigi where id="+idEsporigi;
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Esporigi excluída com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=esporigiPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=esporigiPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir esporigi. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
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


<form method="post" id="cadastro" action="index.jsp?url=esporigiDel">
    <fieldset>
        <legend>Esporigi</legend>
      <p> <input id="idEsporigi" name="idEsporigi" type="hidden" value="<% out.print(idEsporigi); %>" />        
        <label for="cNome">Esporigi: </label><input id="cNome" name="tNome" type="text" value="<%out.print(esporigi.getString("nome")); %>" size="30" maxlength="255" readonly/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" cols="50" maxlength="1000" readonly><%out.print(esporigi.getString("observacoes")); %></textarea>
      </p>
    
    <% out.println(mensagem);%>
    <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
    </p>  
    </fieldset>
</form>