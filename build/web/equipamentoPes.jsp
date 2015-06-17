<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String nNome = request.getParameter("tNome");
    
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    ResultSet equipamento = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from equipamento where upper(nome) like upper('%"+nNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                
                mensagem = "<table> <tr> <td><b>Equipamento</b></td> </tr>";
				
		equipamento = stmt.executeQuery(); 
		  while(equipamento.next()) {
                    mensagem = mensagem + "<tr> <td>"+equipamento.getString("nome")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=equipamentoAlt&idEquipamento="+equipamento.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=equipamentoDel&idEquipamento="+equipamento.getString("id")+"'>Excluir</a></p> </td> </tr>";
                    
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar o equipamento. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=equipamentoPes">
    <fieldset>     
      <p>
        <legend>Pesquisa - Equipamento</legend>
       
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
            
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
      </p>
      
      <% out.println(mensagem);%>      
    </fieldset>
</form>