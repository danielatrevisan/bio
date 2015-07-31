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
        
    ResultSet ordem = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from ordem where upper(nome) like upper('%"+cNome+"%') order by nome";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                mensagem = "<table> <tr> <td><b>Ordem</b></td> </tr>";
				
		ordem = stmt.executeQuery(); 
		  while(ordem.next()) {
                    mensagem = mensagem + "<tr> <td>"+ordem.getString("nome")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=ordemAlt&idOrdem="+ordem.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=ordemDel&idOrdem="+ordem.getString("id")+"'>Excluir</a></p> </td> </tr>";
                    
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar ordem. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=ordemPes">
    <fieldset>
       <legend>Pesquisa - Ordem</legend>

      <p>
        <label for="cNome">Ordem: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>

      <% out.println(mensagem);%>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
    </fieldset>
</form>
