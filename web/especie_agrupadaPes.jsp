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
        
    ResultSet especie_agrupada = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from especie_agrupada where upper(nome) like upper('%"+cNome+"%')";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		especie_agrupada = stmt.executeQuery(); 
		  while(especie_agrupada.next()) {
                    mensagem = mensagem + "<p>"+especie_agrupada.getString("nome")+" - "+especie_agrupada.getString("observacoes")+" "+"<a href='index.jsp?url=especie_agrupadaAlt&idEspecie_agrupada="+especie_agrupada.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=especie_agrupadaDel&idEspecie_agrupada="+especie_agrupada.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar especie agrupada. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=especie_agrupadaPes">
    <fieldset>
      <legend>Esp�cie Agrupada</legend>       
      <p>
        <legend>Pesquisa - Esp�cie Agrupada</legend>       
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
