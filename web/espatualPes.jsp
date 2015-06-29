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
        
    ResultSet espatual = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select e.id, e.nome, coalesce(ea.nome, '') as spgroup from espatual e left join especie_agrupada ea on e.especie_agrupada_id = ea.id where upper(e.nome) like upper('%"+cNome+"%') order by e.nome";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                
                mensagem = "<table> <tr> <td><b>Espatual</b></td> <td><b>Esp�cie Agrupada</b></td> </tr>";
				
		espatual = stmt.executeQuery(); 
		  while(espatual.next()) {
                    mensagem = mensagem + "<tr> <td>"+espatual.getString("nome")+" </td> <td> "+espatual.getString("spgroup")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=espatualAlt&idEspatual="+espatual.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=espatualDel&idEspatual="+espatual.getString("id")+"'>Excluir</a></p> </td> </tr>";
                    
                }
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar espatual. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }          
%>


<form method="post" id="cadastro" action="index.jsp?url=espatualPes">
    <fieldset>      
      <p>
        <legend>Pesquisa - Espatual</legend>       
      <p>
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
            
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>      
    
    <% out.println(mensagem);%>
     
    </fieldset>
</form>