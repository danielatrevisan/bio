<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String tLocalColeta = request.getParameter("tLocalColeta");  
    String tPeriodoIni = request.getParameter("tPeriodoIni");
    String tPeriodoFim = request.getParameter("tPeriodoFim");
    String tProjeto = request.getParameter("tProjeto");    

    String ultimoDia = "";
    
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
    Date today = new Date();  
        int mes,ano;
        ano= Integer.parseInt(tPeriodoFim.split("-")[0]);
        mes= Integer.parseInt(tPeriodoFim.split("-")[1]);
        Calendar calendar = Calendar.getInstance();  
        calendar.setTime(today);  

        calendar.set(Calendar.YEAR, ano);  
        calendar.set(Calendar.DAY_OF_MONTH, 1);  
        calendar.set(Calendar.MONTH, mes);
        //calendar.add(Calendar.MONTH, 1);
        calendar.add(Calendar.DATE, -1);  

        Date lastDayOfMonth = calendar.getTime();  

        DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
        ultimoDia=sdf.format(lastDayOfMonth);
    }  catch (Exception e) {                
                mensagem = "Preencha ao menos um campo do formulário<br/>";
                //e.printStackTrace();
                //out.print(e.toString());
            
        } 
        try { 
                tPeriodoFim = ultimoDia; 
                Connection connection = PosFactory.getConnection();      
                
                //Pesquisa por local - periodo - projeto
                if((tLocalColeta.equals(""))&&((tPeriodoIni.equals("")))&&((tPeriodoFim.equals("")))&&(tProjeto.equals(""))){                     
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id order by p.nome, l.nome, a.data_coleta, a.hora";
                }                
                //Pesquisa por Projeto e Data
                if((tLocalColeta=="")&&(!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals("")))&&(tProjeto!="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquisa por Projeto e Local
                if((tLocalColeta!="")&&(tPeriodoIni.equals(""))&&(tPeriodoFim.equals(""))&&(tProjeto!="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and local_coleta_id =  '"+tLocalColeta+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquisa por Local e data
                if((tLocalColeta!="")&&((!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals(""))))&&(tProjeto=="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id =  '"+tLocalColeta+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquisa por Projeto Local e data
                if((tLocalColeta!="")&&(!(tPeriodoIni.equals(""))&&(!(tPeriodoFim.equals(""))))&&(tProjeto!="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id =  '"+tLocalColeta+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquisa por Projeto
                if((tLocalColeta=="")&&((tPeriodoIni.equals("")))&&((tPeriodoFim.equals("")))&&(tProjeto!="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                 //Pesquisa por Local
                if((tLocalColeta!="")&&((tPeriodoIni.equals("")))&&((tPeriodoFim.equals("")))&&(tProjeto=="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id = '"+tLocalColeta+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                 //Pesquisa por Data
                if((tLocalColeta=="")&&((!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals(""))))&&(tProjeto=="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }                
               
                PreparedStatement stmt = connection.prepareStatement(sql);
		
                mensagem = "<table> <tr> <tdclass='td_g'><b>Id</b></td> <td class='td_g'><b>Proj</b></td> <td class='td_g'><b>Amostra</b></td> <td class='td_g'><b>Planc</b></td> <td class='td_g'><b>Rede</b></td> <td class='td_g'><b>Local</b></td> <td class='td_g'><b>Data da Coleta</b></td> <td class='td_g'><b>Hora</b></td> <td class='td_g'><b>Margem</b></td> <td class='td_g'><b>SMF</b></td> <td class='td_g'><b>Ativ</b></td> <td class='td_g'><b>Vento</b></td> <td class='td_g'><b>Nebulosidade</b></td> <td class='td_g'><b>Chuva</b></td> <td class='td_g'><b>Tar</b></td> <td class='td_g'><b>Tagua</b></td> <td class='td_g'><b>Profund</b></td> <td class='td_g'><b>ODmg</b></td><td><b>Transp</b></td> <td class='td_g'><b>PH</b></td> <td class='td_g'><b>Cond</b></td><td></td> </tr>";
                       
               
                 abiotico = stmt.executeQuery(); 
		  while(abiotico.next()) {
                    mensagem = mensagem + "<tr> <td class='td_g'>"+abiotico.getString("id")+" </td> <td class='td_g'>"+abiotico.getString("projeto")+" </td> <td class='td_g'>"+abiotico.getString("amostra")+" </td> <td class='td_g'>"+abiotico.getString("planc")+" </td> <td class='td_g'>"+abiotico.getString("rede")+" </td> <td class='td_g'> "+abiotico.getString("local")+"</td> <td class='td_g'> "+abiotico.getString("data_coleta")+"</td> <td class='td_g'>"+abiotico.getString("hora")+" </td> <td class='td_g'>"+abiotico.getString("margem")+" </td><td class='td_g'> "+abiotico.getString("smf")+"</td> <td class='td_g'>"+abiotico.getString("ativ")+" </td> <td class='td_g'>"+abiotico.getString("vento")+" </td> <td class='td_g'>"+abiotico.getString("nebulosidade")+" <td class='td_g'>"+abiotico.getString("chuva")+" <td class='td_g'>"+abiotico.getString("tar")+" </td> <td class='td_g'>"+abiotico.getString("tagua")+" </td> <td class='td_g'>"+abiotico.getString("profundidade")+" </td> <td class='td_g'>"+abiotico.getString("odmg")+" </td> <td class='td_g'>"+abiotico.getString("transparencia")+" </td> <td>"+abiotico.getString("ph")+" </td> <td class='td_g'>"+abiotico.getString("condutividade")+" </td> <td class='td_g'> <a href='index.jsp?url=abioticoAlt&idAbiotico="+abiotico.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=abioticoDel&idAbiotico="+abiotico.getString("id")+"'>Excluir</a></p></td> </tr>";                    
                }
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) { 
                //mensagem = "Preencha ao menos um campo do formulário<br/>";
                sqle.printStackTrace();
                //out.println(sql);
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