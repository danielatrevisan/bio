<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idMigrad = request.getParameter("idMigrad");
             
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
        
    if(acao.equals("Excluir")) {
        try {
               connection = PosFactory.getConnection();	

                sql = "delete from migrad where id="+idMigrad;
out.println(sql);
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Migrad excluído com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=migradPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=migradPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir migrad. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet migrad = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM migrad WHERE id = "+idMigrad;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					migrad = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            migrad.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=migradDel">
    <fieldset>
        <legend>Migrad</legend>
            
        <p> <input id="idMigrad" name="idMigrad" type="hidden" value="<% out.print(idMigrad); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(migrad.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(migrad.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
