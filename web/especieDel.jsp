<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
    
    String idEspecie = request.getParameter("idEspecie");
    
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

                sql = "delete from especie where id="+idEspecie;
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Espécie excluída com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=especiePes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=especiePes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir especie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet especie = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM especie WHERE id = "+idEspecie;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					especie = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            especie.next();
           
%>


<form method="post" id="cadastro" action="index.jsp?url=especieDel">
    <fieldset>
        <legend>Especie</legend>
      <p> <input id="idEspecie" name="idEspecie" type="hidden" value="<% out.print(idEspecie); %>" />        
        <label for="cNome">Especie: </label><input id="cNome" name="tNome" type="text" value="<%out.print(especie.getString("nome")); %>" size="30" maxlength="255" readonly/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" cols="50" maxlength="1000" readonly><%out.print(especie.getString("observacoes")); %></textarea>
      </p>
    
    <% out.println(mensagem);%>
    <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
    </p>  
    </fieldset>
</form>