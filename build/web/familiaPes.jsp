
<%
	//Inicializa VariÃ¡veis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
     
    String cNome = request.getParameter("tNome");
    
    String botao = request.getParameter("botao");
	
	//Trata a AÃ§Ã£o do BotÃ£o
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    ResultSet familia = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select f.id, f.nome, coalesce(o.nome, '') as ordem from familia f left join ordem o on f.ordem_id = o.id where upper(f.nome) like upper('%"+cNome+"%') order by f.nome";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>Família</b></td> <td><b>Ordem</b></td> </tr>";
				
		familia = stmt.executeQuery();
		  while(familia.next()) {
                    mensagem = mensagem + "<tr> <td>"+familia.getString("nome")+" </td> <td> "+familia.getString("ordem")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=familiaAlt&idFamilia="+familia.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=familiaDel&idFamilia="+familia.getString("id")+"'>Excluir</a></p> </td> </tr>";                    
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar estádio de maturação. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=familiaPes">
    <fieldset>
       <legend>Pesquisa - Família</legend>

      <p>
        <label for="cNome">Família: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
