<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
    
    String idEspatual = request.getParameter("idEspatual");
    
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

                sql = "delete from espatual where id="+idEspatual;
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Espatual excluída com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=espatualPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=espatualPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir espatual. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet espatual = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM espatual WHERE id = "+idEspatual;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					espatual = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            espatual.next();
           
%>


<form method="post" id="cadastro" action="index.jsp?url=espatualDel">
    <fieldset>
        <legend>Espatual</legend>
      <p> <input id="idEspatual" name="idEspatual" type="hidden" value="<% out.print(idEspatual); %>" />        
        <label for="cNome">Espatual: </label><input id="cNome" name="tNome" type="text" value="<%out.print(espatual.getString("nome")); %>" size="30" maxlength="255" readonly/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" cols="50" maxlength="1000" readonly><%out.print(espatual.getString("observacoes")); %></textarea>
      </p>
    
    <% out.println(mensagem);%>
    <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
    </p>  
    </fieldset>
</form>