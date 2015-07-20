<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idEstadio = request.getParameter("idEstadio");
             
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

                sql = "delete from estadio where id="+idEstadio;
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Estádio excluído com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=estadioPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=estadioPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir estadio. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet estadio = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM estadio WHERE id = "+idEstadio;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					estadio = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            estadio.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=estadioDel">
    <fieldset>
        <legend>Estadio</legend>
            
        <p> <input id="idEstadio" name="idEstadio" type="hidden" value="<% out.print(idEstadio); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(estadio.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(estadio.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
