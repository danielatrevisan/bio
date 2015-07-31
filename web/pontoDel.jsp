<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idPonto = request.getParameter("idPonto");
             
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

                sql = "delete from ponto where id="+idPonto;
out.println(sql);
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Ponto excluído com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=pontoPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=pontoPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir ponto. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet ponto = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM ponto WHERE id = "+idPonto;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					ponto = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            ponto.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=pontoDel">
    <fieldset>
        <legend>Ponto</legend>
            
        <p> <input id="idPonto" name="idPonto" type="hidden" value="<% out.print(idPonto); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(ponto.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(ponto.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
