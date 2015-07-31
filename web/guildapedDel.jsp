<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idGuildaped = request.getParameter("idGuildaped");
             
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

                sql = "delete from guildaped where id="+idGuildaped;
out.println(sql);
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Guildaped excluído com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=guildapedPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=guildapedPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir guildaped. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet guildaped = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM guildaped WHERE id = "+idGuildaped;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					guildaped = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            guildaped.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=guildapedDel">
    <fieldset>
        <legend>Guildaped</legend>
            
        <p> <input id="idGuildaped" name="idGuildaped" type="hidden" value="<% out.print(idGuildaped); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(guildaped.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(guildaped.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
