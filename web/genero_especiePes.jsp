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
        
    ResultSet genero_especie = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from genero_especie where upper(nome) like upper('%"+cNome+"%') order by nome";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>G�nero/Esp�cie</b></td>";
				
		genero_especie = stmt.executeQuery(); 
		  while(genero_especie.next()) {
                    mensagem = mensagem + "<tr> <td>"+genero_especie.getString("nome")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=genero_especieAlt&idGenero_especie="+genero_especie.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=genero_especieDel&idGenero_especie="+genero_especie.getString("id")+"'>Excluir</a></p>";
                    
                }
                  
                mensagem = mensagem + "</table>";                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar g�nero/esp�cie. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=genero_especiePes">
    <fieldset>
       <legend>Pesquisa - G�nero / Esp�cie</legend>

      <p>
        <label for="cNome">GNE: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>