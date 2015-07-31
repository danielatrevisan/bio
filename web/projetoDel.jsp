<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idProjeto = request.getParameter("idProjeto");
             
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

                sql = "delete from projeto where id="+idProjeto;
out.println(sql);
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Projeto excluído com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=projetoPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=projetoPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir projeto. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet projeto = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM projeto WHERE id = "+idProjeto;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					projeto = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            projeto.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=projetoDel">
    <fieldset>
        <legend>Projeto</legend>
            
        <p> <input id="idProjeto" name="idProjeto" type="hidden" value="<% out.print(idProjeto); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(projeto.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(projeto.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
