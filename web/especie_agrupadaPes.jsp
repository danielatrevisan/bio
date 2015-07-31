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
        
    ResultSet especie_agrupada = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from especie_agrupada where upper(nome) like upper('%"+cNome+"%') order by nome";
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
                
                mensagem = "<table> <tr> <td><b>Espécie Agrupada</b></td> </tr>";
				
		especie_agrupada = stmt.executeQuery(); 
		  while(especie_agrupada.next()) {
                       mensagem = mensagem + "<tr> <td>"+especie_agrupada.getString("nome")+" </td> <td> "+"</td> <td> <a href='index.jsp?url=especie_agrupadaAlt&idEspecie_agrupada="+especie_agrupada.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=especie_agrupadaDel&idEspecie_agrupada="+especie_agrupada.getString("id")+"'>Excluir</a></p></td> </tr>";                 
                      
                }
                
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar espécie agrupada. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=especie_agrupadaPes">
    <fieldset>
      <legend>Espécie Agrupada</legend>       
      <p>
        <legend>Pesquisa - Espécie Agrupada</legend>       
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
