<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
        
    String idEspecie_agrupada = request.getParameter("idEspecie_agrupada");
             
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

                sql = "delete from especie_agrupada where id="+idEspecie_agrupada;
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Espécie agrupada excluída com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=especie_agrupadaPes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=especie_agrupadaPes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir especie_agrupada. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet especie_agrupada = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM especie_agrupada WHERE id = "+idEspecie_agrupada;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					especie_agrupada = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            especie_agrupada.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=especie_agrupadaDel">
    <fieldset>
        <legend>Especie_agrupada</legend>
            
        <p> <input id="idEspecie_agrupada" name="idEspecie_agrupada" type="hidden" value="<% out.print(idEspecie_agrupada); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(especie_agrupada.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(especie_agrupada.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
