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
        
    ResultSet guildaped = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from guildaped where upper(nome) like upper('%"+cNome+"%') order by nome";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>Guildaped</b></td> </tr>";
				
		guildaped = stmt.executeQuery(); 
		  while(guildaped.next()) {
                    mensagem = mensagem + "<tr> <td>"+guildaped.getString("nome")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=guildapedAlt&idGuildaped="+guildaped.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=guildapedDel&idGuildaped="+guildaped.getString("id")+"'>Excluir</a></p>";
                 
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar GUILDAPED. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=guildapedPes">
    <fieldset>
       <legend>Pesquisa - Guilda Tr�fica de Alimenta��o</legend>

      <p>
        <label for="cNome">Guildaped: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
