<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idMigraped = request.getParameter("idMigraped");
             
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

                sql = "delete from migraped where id="+idMigraped;
out.println(sql);
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Migraped excluído com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=migrapedPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=migrapedPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir migraped. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet migraped = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM migraped WHERE id = "+idMigraped;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					migraped = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            migraped.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=migrapedDel">
    <fieldset>
        <legend>Migraped</legend>
            
        <p> <input id="idMigraped" name="idMigraped" type="hidden" value="<% out.print(idMigraped); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(migraped.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(migraped.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
