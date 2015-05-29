<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String tLocalColeta = request.getParameter("tLocalColeta");  
    String tDataColeta = request.getParameter("tDataColeta");
    String tProjeto = request.getParameter("tProjeto");    
    
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
                
                //Pesquis por Projeto e Data
                if((tLocalColeta=="")&&(!(tDataColeta.equals("")))&&(tProjeto!="")){
                    sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta as data_coleta, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and data_coleta = '"+tDataColeta+"'";
                }
                //Pesquis por Projeto e Local
                if((tLocalColeta!="")&&(tDataColeta.equals(""))&&(tProjeto!="")){
                    sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and local_coleta_id =  '"+tLocalColeta+"'";
                }
                //Pesquis por Local e data
                if((tLocalColeta!="")&&(!(tDataColeta.equals("")))&&(tProjeto=="")){
                    sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id =  '"+tLocalColeta+"' and data_coleta =  '"+tDataColeta+"'";
                }
                //Pesquis por Projeto Local e data
                if((tLocalColeta!="")&&(!(tDataColeta.equals("")))&&(tProjeto!="")){
                    sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and local_coleta_id =  '"+tLocalColeta+"' and data_coleta =  '"+tDataColeta+"'";
                }
                //Pesquis por Projeto
                if((tLocalColeta=="")&&(tDataColeta.equals(""))&&(tProjeto!="")){
                    sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"'";
                }
                 //Pesquis por Local
                if((tLocalColeta!="")&&(tDataColeta.equals(""))&&(tProjeto=="")){
                    sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta,  coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id = '"+tLocalColeta+"'";
                }
                 //Pesquis por Data
                if((tLocalColeta=="")&&(!(tDataColeta.equals("")))&&(tProjeto=="")){
                    sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where data_coleta =  '"+tDataColeta+"'";
                }
               
                PreparedStatement stmt = connection.prepareStatement(sql);
		
                mensagem = "<table> <tr> <td><b>Projeto</b></td> <td><b>Local</b></td> <td><b>Sigla</b></td> <td><b>Data da Coleta</b></td> <td><b>SMF</b></td> <td></td> </tr>";
                
                        
                
                  abiotico = stmt.executeQuery(); 
		  while(abiotico.next()) {
                    mensagem = mensagem + "<tr> <td>"+abiotico.getString("id")+" </td> <td>"+abiotico.getString("projeto")+" </td> <td> "+abiotico.getString("local")+"</td> <td> "+abiotico.getString("sigla")+"</td> <td> "+abiotico.getString("data_coleta")+"</td> <td> "+abiotico.getString("smf")+"</td> <td> <a href='index.jsp?url=abioticoAlt&idAbiotico="+abiotico.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=abioticoDel&idAbiotico="+abiotico.getString("id")+"'>Excluir</a></p></td> </tr>";                    
                }
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Preencha ao menos um campo do formulário<br/>";
                sqle.printStackTrace();          
        } 
    }        
%>

        <form method="post" id="cadastro" action="index.jsp?url=abioticoPes">
            <fieldset>
                <legend>Dados Abióticos</legend>                
                <fieldset>
                    <p>
                        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
                    </p>
                    <p>                        
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
                                    out.println("Ocorreu um erro ao pesquisar abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
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
                                    out.println("Ocorreu um erro ao pesquisar o Abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

                        %>
                        <select name="tLocalColeta" id="localColetaId">
                            <option></option>
                            <%while(local.next()) { %>
                                <option value="<%out.print(local.getString("id"));%>"><%out.print(local.getString("nome"));%> - <%out.print(local.getString("sigla"));%></option>
                            <%}%>
                        </select>
                    </p>
                    <p>                        
                        <label for="DataColeta">Data: </label><input id="tDataColeta" name="tDataColeta" type="date"/>
                        
                    </p>
                    
        <% out.println(mensagem);%>
        <p>
            <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
        </p>
                </fieldset>                
        </form>