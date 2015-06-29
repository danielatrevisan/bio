<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String cNome = request.getParameter("tNome");
        
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    ResultSet projeto = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from projeto where upper(nome) like upper('%"+cNome+"%') order by nome";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>Projeto</b></td> </tr>";
				
		projeto = stmt.executeQuery(); 
		  while(projeto.next()) {
                    mensagem = mensagem + "<tr> <td>"+projeto.getString("nome")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=projetoAlt&idProjeto="+projeto.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=projetoDel&idProjeto="+projeto.getString("id")+"'>Excluir</a></p> </td> </tr>";
                    
                }
                  
                mensagem = mensagem + "</table>";                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar projeto. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }       
%>

<form method="post" id="cadastro" action="index.jsp?url=projetoPes">
    <fieldset>
       <legend>Pesquisa - Projeto</legend>

      <p>
        <label for="cNome">Projeto: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
