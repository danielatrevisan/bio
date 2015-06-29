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
        
    if(acao.equals("Salvar")) {
        try {
               connection = PosFactory.getConnection();	

                sql = "update ordem set nome='"+nNome+"', observacoes='"+nObs+"' where id="+idOrdem;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Ordem alterada com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar ordem. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
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

<form method="post" id="cadastro" action="index.jsp?url=ordemAlt">
    <fieldset>
        <legend>Ordem</legend>
            
        <p> <input id="idOrdem" name="idOrdem" type="hidden" value="<% out.print(idOrdem); %>" />
            <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(ordem.getString("nome")); %>" size="50" maxlength="255"/>
        </p>
        <p>        
            <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000"><%out.print(ordem.getString("observacoes"));%></textarea>
        </p>
        
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
        </p>  
        </fieldset>
</form>
