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
        
    ResultSet migraped = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from migraped where upper(nome) like upper('%"+cNome+"%') order by nome";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>Migraped</b></td> </tr>";
				
		migraped = stmt.executeQuery(); 
		  while(migraped.next()) {
                    mensagem = mensagem + "<tr> <td>"+migraped.getString("nome")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=migrapedAlt&idMigraped="+migraped.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=migrapedDel&idMigraped="+migraped.getString("id")+"'>Excluir</a></p> </td> </tr>";
                    
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar MIGRAPED. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=migrapedPes">
    <fieldset>
       <legend>Pesquisa - MIGRAPED</legend>

      <p>
        <label for="cNome">Migraped: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
