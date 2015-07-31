
<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String cNome = request.getParameter("tNome");
    
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
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
        
    ResultSet esppecie = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select e.id, e.nome, coalesce(ea.nome, '') as spgroup from esppecie e left join especie_agrupada ea on e.especie_agrupada_id = ea.id where upper(e.nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>Esppecie</b></td> <td><b>Esp�cie Agrupada</b></td> </tr>";
				
		esppecie = stmt.executeQuery(); 
		  while(esppecie.next()) {                    
                    mensagem = mensagem + "<tr> <td>"+esppecie.getString("nome")+" </td> <td> "+esppecie.getString("spgroup")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=esppecieAlt&idEsppecie="+esppecie.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=esppecieDel&idEsppecie="+esppecie.getString("id")+"'>Excluir</a></p> </td> </tr>";
                    
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar esppecie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=esppeciePes">
    <fieldset>
      <legend>Pesquisa - Esppecie</legend>

      <p>
        <label for="cNome">Esppecie: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>  
    </fieldset>
</form>
