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
        
    ResultSet ctrof = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from ctrof where upper(nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		ctrof = stmt.executeQuery(); 
		  while(ctrof.next()) {
                    mensagem = mensagem + "<p>"+ctrof.getString("nome")+" - "+ctrof.getString("observacoes")+" "+"<a href='index.jsp?url=ctrofAlt&idCtrof="+ctrof.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=ctrofDel&idCtrof="+ctrof.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar a categoria tr�fica. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=categoria_troficaPes">
    <fieldset>
        <legend>Pesquisa - Categoria Tr�fica</legend>
      <p>
        <label for="cNome">Nome: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
      
    <% out.println(mensagem);%>
    <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
    </p>  
    </fieldset>
</form>