<%
	//Inicializa VariÃ¡veis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
     
    String cNome = request.getParameter("tNome");
    
    String botao = request.getParameter("botao");
	
	//Trata a AÃ§Ã£o do BotÃ£o
    
    mensagem = request.getParameter("mensagem");
    if (mensagem==null)
    {
        mensagem="";
    }
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    ResultSet especie = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select e.id, e.nome, coalesce(ea.nome, '') as spgroup from especie e left join especie_agrupada ea on e.especie_agrupada_id = ea.id where upper(e.nome) like upper('%"+cNome+"%') order by e.nome";
                
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>Espécie</b></td> <td><b>Espécie Agrupada</b></td> </tr>";
				
		especie = stmt.executeQuery(); 
		  while(especie.next()) {
                    mensagem = mensagem + "<tr> <td>"+especie.getString("nome")+" </td> <td> "+especie.getString("spgroup")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=especieAlt&idEspecie="+especie.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=especieDel&idEspecie="+especie.getString("id")+"'>Excluir</a></p>";
                    
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar espécie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=especiePes">
    <fieldset>
      <legend>Espécie</legend>       
      <p>
        <legend>Pesquisa - Espécie</legend>       
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