<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String tLocalColeta = request.getParameter("tLocalColeta");  
    String tPeriodoIni = request.getParameter("tPeriodoIni");
    String tPeriodoFim = request.getParameter("tPeriodoFim");
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
                
                if((tLocalColeta.equals(""))&&((tPeriodoIni.equals("")))&&((tPeriodoFim.equals("")))&&(tProjeto.equals(""))){
                     //sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, a.hora, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id order by p.nome, l.nome, a.data_coleta, a.hora";
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                
                //Pesquis por Projeto e Data
                if((tLocalColeta=="")&&(!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals("")))&&(tProjeto!="")){
                    //sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, a.hora, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"-31' order by p.nome, l.nome, a.data_coleta, a.hora";
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"-31' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquis por Projeto e Local
                if((tLocalColeta!="")&&(!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals("")))&&(tProjeto!="")){
                    //sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, a.hora, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and local_coleta_id =  '"+tLocalColeta+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and local_coleta_id =  '"+tLocalColeta+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquis por Local e data
                if((tLocalColeta!="")&&(!(!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals(""))))&&(tProjeto=="")){
                    //sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, a.hora, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id =  '"+tLocalColeta+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"-31' order by p.nome, l.nome, a.data_coleta, a.hora";
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id =  '"+tLocalColeta+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"-31' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquis por Projeto Local e data
                if((tLocalColeta!="")&&(!(!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals(""))))&&(tProjeto!="")){
                    //sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, a.hora, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and local_coleta_id =  '"+tLocalColeta+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"-31' order by p.nome, l.nome, a.data_coleta, a.hora";
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id =  '"+tLocalColeta+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"-31' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquis por Projeto
                if((tLocalColeta=="")&&((tPeriodoIni.equals("")))&&((tPeriodoFim.equals("")))&&(tProjeto!="")){
                    //sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, a.hora, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                 //Pesquis por Local
                if((tLocalColeta!="")&&((tPeriodoIni.equals("")))&&((tPeriodoFim.equals("")))&&(tProjeto=="")){
                    //sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta,  a.hora, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id = '"+tLocalColeta+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id = '"+tLocalColeta+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                 //Pesquis por Data
                if((tLocalColeta=="")&&((!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals(""))))&&(tProjeto=="")){
                    //sql = "select a.id, p.nome as projeto, l.nome as local, l.sigla, to_char(a.data_coleta, 'DD/MM/YYYY') as data_coleta, a.hora, coalesce(a.smf, '') as smf from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"-31' order by p.nome, l.nome, a.data_coleta, a.hora";
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"-31' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                
               
                PreparedStatement stmt = connection.prepareStatement(sql);
		
                mensagem = "<table> <tr> <td><b>Id</b></td> <td><b>Proj</b></td> <td><b>Amostra</b></td> <td><b>Planc</b></td> <td><b>Rede</b></td> <td><b>Local</b></td> <td><b>Data da Coleta</b></td> <td><b>Hora</b></td> <td><b>Margem</b></td> <td><b>SMF</b></td> <td><b>Ativ</b></td> <td><b>Vento</b></td> <td><b>Nebulosidade</b></td> <td><b>Chuva</b></td> <td><b>Tar</b></td> <td><b>Tagua</b></td> <td><b>Profund</b></td> <td><b>ODmg</b></td><td><b>Transp</b></td> <td><b>PH</b></td> <td><b>Cond</b></td><td></td> </tr>";
                
                        
                
                  abiotico = stmt.executeQuery(); 
		  while(abiotico.next()) {
                    mensagem = mensagem + "<tr> <td>"+abiotico.getString("id")+" </td> <td>"+abiotico.getString("projeto")+" </td> <td>"+abiotico.getString("amostra")+" </td> <td>"+abiotico.getString("planc")+" </td> <td>"+abiotico.getString("rede")+" </td> <td> "+abiotico.getString("local")+"</td> <td> "+abiotico.getString("data_coleta")+"</td> <td>"+abiotico.getString("hora")+" </td> <td>"+abiotico.getString("margem")+" </td><td> "+abiotico.getString("smf")+"</td> <td>"+abiotico.getString("ativ")+" </td> <td>"+abiotico.getString("vento")+" </td> <td>"+abiotico.getString("nebulosidade")+" <td>"+abiotico.getString("chuva")+" <td>"+abiotico.getString("tar")+" </td> <td>"+abiotico.getString("tagua")+" </td> <td>"+abiotico.getString("profundidade")+" </td> <td>"+abiotico.getString("odmg")+" </td> <td>"+abiotico.getString("transparencia")+" </td> <td>"+abiotico.getString("ph")+" </td> <td>"+abiotico.getString("condutividade")+" </td> <td> <a href='index.jsp?url=abioticoAlt&idAbiotico="+abiotico.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=abioticoDel&idAbiotico="+abiotico.getString("id")+"'>Excluir</a></p></td> </tr>";                    
                }
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) {
                //mensagem = "Preencha ao menos um campo do formulário<br/>";
                sqle.printStackTrace();
                out.print(sqle.toString());
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
                        <label for="periodoIni">Ano/Mês - início: </label><input id="tPeriodoIni" name="tPeriodoIni" type="month"/>
                        <label for="periodoFim">Ano/Mês - fim: </label><input id="tPeriodoFim" name="tPeriodoFim" type="month"/>                        
                    </p>
                   
        <% out.println(mensagem);%>
        <p>
            <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Pesquisar"/> 
        </p>
                </fieldset>                
        </form>