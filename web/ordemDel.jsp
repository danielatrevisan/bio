<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idOrdem = request.getParameter("idOrdem");
             
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

                sql = "delete from ordem where id="+idOrdem;
out.println(sql);
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Ordem excluída com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=ordemPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=ordemPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir ordem. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet ordem = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM ordem WHERE id = "+idOrdem;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					ordem = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            ordem.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=ordemDel">
    <fieldset>
        <legend>Ordem</legend>
            
        <p> <input id="idOrdem" name="idOrdem" type="hidden" value="<% out.print(idOrdem); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(ordem.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(ordem.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
