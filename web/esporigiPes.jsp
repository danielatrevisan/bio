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
        
    ResultSet esporigi = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select e.id, e.nome, coalesce(ea.nome, '') as spgroup from esporigi e left join especie_agrupada ea on e.especie_agrupada_id = ea.id where upper(e.nome) like upper('%"+cNome+"%') order by e.nome";                
                
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>Esporigi</b></td> <td><b>Esp�cie Agrupada</b></td> </tr>";
				
		esporigi = stmt.executeQuery(); 
		  while(esporigi.next()) {                    
                    mensagem = mensagem + "<tr> <td>"+esporigi.getString("nome")+" </td> <td> "+esporigi.getString("spgroup")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=especieAlt&idEspecie="+esporigi.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=especieDel&idEspecie="+esporigi.getString("id")+"'>Excluir</a></p> </td> </tr>";
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar esporigi. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=esporigiPes">
    <fieldset>       
      <legend>Pesquisa - Esporigi</legend>       
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
            
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>      
    
    <% out.println(mensagem);%>  
    </fieldset>
</form>
