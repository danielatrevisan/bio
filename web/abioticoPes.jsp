<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String tLocalColeta = request.getParameter("tLocalColeta");   
    String tDataColeta = request.getParameter("tDataColeta");
    String tProjeto = request.getParameter("tProjeto");
    String tAmostra = request.getParameter("tAmostra");  
    
    String botao = request.getParameter("botao");
	
	//Trata a ação do Botao
    
    String acao = "";
    
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    ResultSet abiotico = null;    
    if(acao.equals("Pesquisar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "select * from abiotico where upper(projeto) = upper('%"+tLocalColeta+"%') or upper(data_coleta) =  upper('%"+tDataColeta+"%') or upper(amostra) = upper('%"+tProjeto+"%') or upper(local) = upper('%"+tAmostra+"%'))"; 
                   
                PreparedStatement stmt = connection.prepareStatement(sql);
				
		abiotico = stmt.executeQuery(); 
		  while(abiotico.next()) {
                    mensagem = mensagem + "<p>"+abiotico.getString("nome")+" - "+abiotico.getString("observacoes")+" "+"<a href='index.jsp?url=abioticoAlt&idAbiotico="+abiotico.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=abioticoDel&idAbiotico="+abiotico.getString("id")+"'>Excluir</a></p>";
                }
                
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao pesquisar o abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

        <form method="post" id="cadastro" action="index.jsp?url=abioticoPes">
            <fieldset>
                <legend>Dados Abióticos</legend>                
                <fieldset>
                    <p>
                        <label for="tAmostra">Amostra: </label><input id="tAmostra" name="tAmostra" type="text" size="10" maxlength="50"/>
                        <label for="tProjeto">Projeto: </label>                         
                        <%
                            ResultSet proj = null;
                            try {
                                    Connection connection = PosFactory.getConnection();

                                    sql = "select id, nome from projeto order by projeto";
                                    
                                    PreparedStatement stmt = connection.prepareStatement(sql);

                                    proj = stmt.executeQuery(); 
                                    
                                    connection.close();
                                } catch (SQLException sqle) {
                                    out.println("Ocorreu um erro ao cadastrar abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

                        %>
                        <select name="tProjeto" id="projetoId">
                        <option></option>
                        <%while(proj.next()) { %>
                            <option value="<%out.print(proj.getString("id"));%>"><%out.print(proj.getString("nome"));%></option>
                        <%}%>
                        </select>
                    </p>
                    <p>
                        <label for="LocalColetaId">Local da Coleta: </label>
                        <%
                            ResultSet local = null;
                            try {
                                    Connection connection = PosFactory.getConnection();

                                    sql = "select id, nome, sigla from local_coleta order by nome";
                                    
                                    PreparedStatement stmt = connection.prepareStatement(sql);

                                    local = stmt.executeQuery();
                                    
                                    connection.close();
                                } catch (SQLException sqle) {
                                    out.println("Ocorreu um erro ao cadastrar o Abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

                        %>

                        <select name="tLocalColeta" id="localColetaId">
                            <option></option>
                            <%while(local.next()) { %>
                                <option value="<%out.print(local.getString("id"));%>"><%out.print(local.getString("nome"));%> - <%out.print(local.getString("sigla"));%></option>
                            <%}%>
                        </select>
                        
                        <label for="DataColeta">Data: </label><input id="tDataColeta" name="tDataColeta" type="date"/>
                        
                    </p>
                </fieldset>                
        </form>