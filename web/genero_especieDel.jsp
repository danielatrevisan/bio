<%
	//Inicializa Variáveis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do Formulário
        
    String idGenero_especie = request.getParameter("idGenero_especie");
             
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

                sql = "delete from genero_especie where id="+idGenero_especie;
out.println(sql);
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "G�nero/Esp�cie exclu�do com sucesso";
             
                
                connection.close();
                request.getRequestDispatcher("index.jsp?url=genero_especiePes&mensagem="+mensagem).forward(request, response);
               // response.sendRedirect("index.jsp?url=genero_especiePes");
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao excluir genero_especie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
        

			ResultSet genero_especie = null;
			try {
					connection = PosFactory.getConnection();	
		
					sql = "SELECT * FROM genero_especie WHERE id = "+idGenero_especie;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					genero_especie = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();         
			}
	
                
           
            genero_especie.next();
           
%>

<form method="post" id="cadastro" action="index.jsp?url=genero_especieDel">
    <fieldset>
        <legend>Genero_especie</legend>
            
        <p> <input id="idGenero_especie" name="idGenero_especie" type="hidden" value="<% out.print(idGenero_especie); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(genero_especie.getString("nome")); %>" size="50" maxlength="255" readonly/>
        </p>
        <p>        
            <label for="cObs">Observa��es: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000" readonly><%out.print(genero_especie.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
        </p>  
        </fieldset>
</form>
