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
        
    if(acao.equals("Salvar")) {
        try {
               connection = PosFactory.getConnection();	

                sql = "update estadio_maturacao set nome='"+nNome+"', observacoes='"+nObs+"' where id="+idEstadio_maturacao;

                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.execute();         

                mensagem = "Estádio da maturação alterado com sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar o estádio da maturação. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
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

<form method="post" id="cadastro" action="index.jsp?url=estadio_maturacaoAlt">
    <fieldset>
      <legend>Estádio de Maturação</legend>      
      
      <p><p> <input id="idEstadio_maturacao" name="idEstadio_maturacao" type="hidden" value="<% out.print(idEstadio_maturacao); %>" />
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" value="<%out.print(estadio_maturacao.getString("nome")); %>" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs" rows="10" cols="50" maxlength="1000"><%out.print(estadio_maturacao.getString("observacoes"));%></textarea>
      </p>
    <% out.println(mensagem);%>
    <p>
    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>  
    </fieldset>
</form>
