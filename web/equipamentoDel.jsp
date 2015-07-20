<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idEquipamento = request.getParameter("idEquipamento");
             
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

                sql = "delete from equipamento where id="+idEquipamento;
out.println(sql);
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Equipamento excluída com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=equipamentoPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=equipamentoPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir equipamento. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet equipamento = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM equipamento WHERE id = "+idEquipamento;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					equipamento = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            equipamento.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=equipamentoDel">
    <fieldset>
        <legend>Equipamento</legend>
            
        <p> <input id="idEquipamento" name="idEquipamento" type="hidden" value="<% out.print(idEquipamento); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(equipamento.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(equipamento.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
