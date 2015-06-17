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
        
    ResultSet local = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select id, nome, coalesce(sigla, '') as sigla, coalesce(municipio, '') as municipio from local_coleta where upper(nome) like upper('%"+cNome+"%') order by nome";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>Local</b></td> <td><b>Sigla</b></td> <td><b>Munic�pio</b></td> </tr>";
				
		local = stmt.executeQuery(); 
		  while(local.next()) {
                    mensagem = mensagem + "<tr> <td>"+local.getString("nome")+" </td> <td> "+local.getString("sigla")+" </td> <td> "+local.getString("municipio")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=localAlt&idLocal="+local.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=localDel&idLocal="+local.getString("id")+"'>Excluir</a></p> </td> </tr>";
                    
                }
                  
                mensagem = mensagem + "</table>";                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar local da coleta. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=local_coletaPes">
    <fieldset>
       <legend>Pesquisa - Local da Coleta</legend>

      <p>
        <label for="cNome">Local: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
