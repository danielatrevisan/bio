<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idAparelho = request.getParameter("idAparelho");
             
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

                sql = "delete from aparelho where id="+idAparelho;
out.println(sql);
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Aparelho excluído com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=aparelhoPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=aparelhoPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir aparelho. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet aparelho = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM aparelho WHERE id = "+idAparelho;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					aparelho = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            aparelho.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=aparelhoDel">
    <fieldset>
        <legend>Aparelho</legend>
            
        <p> <input id="idAparelho" name="idAparelho" type="hidden" value="<% out.print(idAparelho); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(aparelho.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(aparelho.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>