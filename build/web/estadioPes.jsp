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
        
    ResultSet estadio = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select e.id, e.nome, em.nome as estadio_mat from estadio e left join estadio_maturacao em on e.estadio_maturacao_id = em.id where upper(e.nome) like upper('%"+cNome+"%') order by e.nome";
                
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>Estádio</b></td> <td><b>Estádio da Maturação</b></td> </tr>";
				
		estadio = stmt.executeQuery(); 
		  while(estadio.next()) {
                    mensagem = mensagem + "<tr> <td>"+estadio.getString("nome")+" </td> <td> "+estadio.getString("estadio_mat")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=estadioAlt&idEstadio="+estadio.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=estadioDel&idEstadio="+estadio.getString("id")+"'>Excluir</a></p> </td> </tr>";                    
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar estádio. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=estadioPes">
    <fieldset>
       <legend>Pesquisa - Estádio</legend>

      <p>
        <label for="cNome">Estádio: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
