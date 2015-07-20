<%
	//Inicializa Variáveis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do Formul�rio
    
    String cNome = request.getParameter("tNome");    
    
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    ResultSet aparelho = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select a.id, a.nome as aparelho, e.nome as equipamento from aparelho a left join equipamento e on a.equipamento_id = e.id where upper(a.nome) like upper('%"+cNome+"%') order by a.nome";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                
                mensagem = "<table> <tr> <td><b>Aparelho</b></td> <td><b>Equipamento</b></td> </tr>";
				
		aparelho = stmt.executeQuery(); 
		  while(aparelho.next()) {
                    mensagem = mensagem + "<tr> <td>"+aparelho.getString("aparelho")+" </td> <td> "+aparelho.getString("equipamento")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=aparelhoAlt&idAparelho="+aparelho.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=aparelhoDel&idAparelho="+aparelho.getString("id")+"'>Excluir</a></p> </td> </tr>";
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar aparelho. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }           
%>

<form method="post" id="cadastro" action="index.jsp?url=aparelhoPes">
    <fieldset>
        <legend>Pesquisa - Aparelho</legend>

      <p>
        <label for="cNome">Aparelho: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>  
    </fieldset>
</form>