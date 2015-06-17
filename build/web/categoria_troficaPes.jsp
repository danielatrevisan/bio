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
        
    ResultSet ctrof = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from ctrof where upper(nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                
                mensagem = "<table> <tr> <td><b>Categoria Trófica</b></td></tr>";
				
		ctrof = stmt.executeQuery(); 
		  while(ctrof.next()) {
                    mensagem = mensagem + "<tr> <td>"+ctrof.getString("nome")+" </td> <td> "+"</td> <td><a href='index.jsp?url=ctrofAlt&idCtrof="+ctrof.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=ctrofDel&idCtrof="+ctrof.getString("id")+"'>Excluir</a></p> </td> </tr>";
                    
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
                
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar a categoria trófica. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=categoria_troficaPes">
    <fieldset>
        <legend>Pesquisa - Categoria Trófica</legend>
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
      
    <% out.println(mensagem);%>
    <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
    </p>  
    </fieldset>
</form>