<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idFamilia = request.getParameter("idFamilia");
             
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

                sql = "delete from familia where id="+idFamilia;
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Família excluída com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=familiaPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=familiaPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir família. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet familia = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM familia WHERE id = "+idFamilia;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					familia = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            familia.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=familiaDel">
    <fieldset>
        <legend>Familia</legend>
            
        <p> <input id="idFamilia" name="idFamilia" type="hidden" value="<% out.print(idFamilia); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(familia.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(familia.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
