<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idEstadio_maturacao = request.getParameter("idEstadio_maturacao");
             
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

                sql = "delete from estadio_maturacao where id="+idEstadio_maturacao;
out.println(sql);
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Estadio da maturação excluída com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=estadio_maturacaoPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=estadio_maturacaoPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir estadio_maturacao. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet estadio_maturacao = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM estadio_maturacao WHERE id = "+idEstadio_maturacao;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					estadio_maturacao = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            estadio_maturacao.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=estadio_maturacaoDel">
    <fieldset>
        <legend>Estadio_maturacao</legend>
            
        <p> <input id="idEstadio_maturacao" name="idEstadio_maturacao" type="hidden" value="<% out.print(idEstadio_maturacao); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(estadio_maturacao.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(estadio_maturacao.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
