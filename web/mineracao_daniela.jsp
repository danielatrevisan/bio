<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="weka.filters.supervised.attribute.AttributeSelection"%>
<%@page import="weka.attributeSelection.*" %>
<%@page import="weka.filters.*"%>
<%@page import="weka.associations.PredictiveApriori"%>
<%@page import="weka.core.Instances"%>
<%@page import="weka.associations.AprioriItemSet"%>
<%@page import="weka.core.FastVector"%>
<%@page import="weka.experiment.InstanceQuery"%>
<%
	//Inicializa Variáveis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do Formulário
    
    String[] nLocal = request.getParameterValues("nLocal"); 	
    String tPeriodoIni = request.getParameter("tPeriodoIni");
    String tPeriodoFim = request.getParameter("tPeriodoFim");
    
    String tProjeto = request.getParameter("tProjeto"); 	
    String nAparelho = request.getParameter("nAparelho");
    String nAmbiente = request.getParameter("nAmbiente"); 	
    String nGne = request.getParameter("nGne");
    String nSMF = request.getParameter("nSMF");
    String nMigrad = request.getParameter("nMigrad");
    String nMigraped = request.getParameter("nMigraped");
    String nProfundidade = request.getParameter("nProfundidade");
    String nGuildaped = request.getParameter("nGuildaped");
    String nPH = request.getParameter("nPH");
    String nCTROF = request.getParameter("nCTROF");
    String nTagua = request.getParameter("nCTagua");
    String nFamilia = request.getParameter("nFamilia");
    String nCondutividade = request.getParameter("nCondutividade");
    String nEspecie = request.getParameter("nEspecie");
    String nData = "";
    String result="";
    String ultimoDia="";    
    String consulta = "select ";
    String strLocal = "";
    
    InstanceQuery query = new InstanceQuery();
    FastVector rs[];
    AprioriItemSet a;
    query.setDatabaseURL("jdbc:postgresql://localhost:5432/bio");
    query.setUsername("postgres");
    query.setPassword("admin");
    /*
    for(int i=0;i< nLocal.length;i++){
        //strLocal = strLocal + "," +nLocal[i];
        out.println(nLocal[i]+",");
    }
    */
    
    PredictiveApriori  dado= new PredictiveApriori();
         
             
    if ((nAparelho != "") && (nAparelho != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "aparelho_id ";
    }
    if ((nAmbiente != "") && (nAmbiente != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "ambiente_id ";
    }
    if ((nGne != "") && (nGne != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "genero_especie_id ";
    }
    if ((nSMF != "") && (nSMF != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "smf ";
    }
    if ((nMigrad != "") && (nMigrad != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "migrad_id ";
    }
    if ((nMigraped != "") && (nMigraped != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "migraped_id ";
    }
    if ((nProfundidade != "") && (nProfundidade != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "profundidade ";
    }
    if ((nGuildaped != "") && (nGuildaped != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "guildaped_id ";
    }
    if ((nPH != "") && (nPH != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "ph ";
    }
    if ((nCTROF != "") && (nCTROF != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "ctrof_id ";
    }
    if ((nTagua != "") && (nTagua != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "tagua ";
    }
    if ((nFamilia != "") && (nFamilia != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "familia_id ";
    }
    if ((nCondutividade != "") && (nCondutividade != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "cond ";
    }
    if ((nEspecie != "") && (nEspecie != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "especie_id ";
    }
  
    if (request.getParameter("botao")!=null)
    {
        consulta = consulta + "from biotico b left join abiotico a on b.abiotico_id = a.id";
        
        if ((!(nLocal.length > 0)))
        {
            consulta = consulta + " where "; //ainda tem que colocar a variavel e completar este comando
        }
        if ((nLocal.length>0) && (nLocal != null))
        {
            
                consulta = consulta + " b.local_coleta_id in " + nLocal.toString();
            
        }
        
        //alteração para verficar se periodo de inicio e fim sao, MAS AINDA INCOMPLETO
        if ((!tPeriodoIni.equalsIgnoreCase(""))&&(!tPeriodoFim.equalsIgnoreCase("")))
        {           
            try { //Para verificar qual o último dia do mês e setar a data completa para o periodo de fim (com dia/mes/ano)
                Date today = new Date();  
                int mes,ano;
                ano= Integer.parseInt(tPeriodoFim.split("-")[0]);
                mes = Integer.parseInt(tPeriodoFim.split("-")[1]);
                Calendar calendar = Calendar.getInstance();  
                calendar.setTime(today);  

                calendar.set(Calendar.YEAR, ano);  
                calendar.set(Calendar.DAY_OF_MONTH, 1);  
                calendar.set(Calendar.MONTH, mes);
                calendar.add(Calendar.MONTH, 1);
                calendar.add(Calendar.DATE, -1);  

                Date lastDayOfMonth = calendar.getTime();  

                DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
                ultimoDia=sdf.format(lastDayOfMonth);
                tPeriodoFim = ultimoDia;
            }  catch (Exception e) {
                    out.println(sql);
                    mensagem = "Preencha ao menos um campo do formulário<br/>";
                    e.printStackTrace();
                    out.print(e.toString());

            } 
            if (consulta.contains("where")) //acho que pra montar o where da com a seria isso
            {
                consulta = consulta + " and b.data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"'";
            }else
            {
                consulta = consulta + " where b.data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"'";
            }
            
          
            
         
        }
    
    //out.println(consulta);
    consulta="select l.nome as local,ap.nome as aparelho, a.smf, a.ph, coalesce(a.tagua, '') as tagua, a.cond, ab.nome as ambiente, g.nome as gne, m.nome as migraped, md.nome as migrad, gp.nome as guildaped, c.nome as ctrof, f.nome as familia, e.nome as especie from biotico b      left join abiotico a on b.abiotico_id = a.id      left join local_coleta l on a.local_coleta_id = l.id       left join aparelho ap on b.aparelho_id = ap.id      left join ambiente ab on b.ambiente_id = ab.id      left join genero_especie g on b.genero_especie_id = g.id       left join migraped m on b.migraped_id = m.id      left join migrad md on b.migrad_id = md.id      left join guildaped gp on b.guildaped_id = gp.id      left join ctrof c  on  b.ctrof_id = c.id      left join familia f on b.familia_id = f.id       left join especie e on b.especie_id = e.id";
    query.setQuery(consulta);
    Instances data = query.retrieveInstances();
    
    Instances relevantData = null;

	AttributeSelection filter = new AttributeSelection();
	CfsSubsetEval eval = new CfsSubsetEval();
	GreedyStepwise search = new GreedyStepwise();
	search.setSearchBackwards(true);
	filter.setEvaluator(eval);
    filter.setSearch(search);
    try {
        filter.setInputFormat(data);
        relevantData = AttributeSelection.useFilter(data,filter);
      }
     catch (  Exception e) {
    	 out.println("Erro ao realizar reamostragem dados de entrada com atributos selecionados!");
    	 out.println("<br><br>");
        e.printStackTrace();
      }

	out.println("Atributos antigos: "+data);
	out.println("<br><br><br>");
	out.println("Atributos relevantes: "+relevantData);

	dado.setOptions(weka.core.Utils.splitOptions("-N 20 -T 0 -C 0.1 -D 0.05 -U 1.0 -M 0.1 -S -1.0 -c -1"));
	
	
	//dado.buildAssociations(relevantData);
	dado.buildAssociations(data);
	//out.println("dados: "+dado.toString());
    
    
    
    dado.setOptions(weka.core.Utils.splitOptions("-N 20 -T 0 -C 0.1 -D 0.05 -U 1.0 -M 0.1 -S -1.0 -c -1"));
    dado.buildAssociations(data);
    result=dado.toString();
//    out.println(dado.toString());
 
    }
    
   
%>

    <form id="mineracao" method="post" action="index.jsp?url=mineracao">
        <fieldset>            
        <legend>Geração de Regras de Associação</legend>
        <fieldset>            
        <legend>Campos</legend>
      <table width="449" border="1">
        <tr>
          <td width="201">
              <label for="nLocalColeta">Local: 
                <%
                    ResultSet local = null;
                        try {
                            Connection connection = PosFactory.getConnection();
                                
                            sql = "select id, nome, sigla from local_coleta";
                                                                
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            local = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nLocal" id="localId" size="5" multiple="MULTIPLE">    <!-- alteração para multiple-->                
                    <!--<option value="Todos">Todos </option>-->
                    <% while(local.next()) { %>
                    <option value="<%out.print(local.getString("id"));%>"><%out.print(local.getString("nome"));%> - <%out.print(local.getString("sigla"));%></option>
                                
                <%}%>
                </select>         
            </td>     
        </tr>
        <tr>        <!-- alteração no tipo de entrada de data-->          
          <td><label for="periodoIni">Ano/Mês - início: <input id="tPeriodoIni" name="tPeriodoIni" type="month"/></td>
          <td><label for="periodoFim">Ano/Mês - fim: <input id="tPeriodoFim" name="tPeriodoFim" type="month"/></td>          
        </tr>
        <tr> <!-- alteração no formulário para listar todos os campos-->       
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nAmbiente" value="" />Projeto</td> <!-- Ver se realmente justifica o projeto fazer parte da mineração-->
          <td><input type="checkbox" name="nHorario" value="" />Horário</td> <!-- Será que seria interessante discretizar o horário em período?-->     
          <td><input type="checkbox" name="nAmbiente" value="" />Ambiente</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nSMF" value="" />SMF</td>
          <td><input type="checkbox" name="nPonto" value="" />Ponto</td>          
          <td><input type="checkbox" name="nMargem" value="" />Margem</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nAparelho" value="" />Aparelho</td>
          <td><input type="checkbox" name="nRede" value="" />Rede</td>                   
          <td><input type="checkbox" name="nPlanc" value="" />Planc</td> 
        </tr>
        <tr>  
          <td><input type="checkbox" name="nProfundidade" value="" />Profundidade</td>
          <td><input type="checkbox" name="nPH" value="" />PH</td>
          <td><input type="checkbox" name="nTagua" value="" />Temperatura da &aacute;gua</td>          
        </tr>
        <tr>
          <td><input type="checkbox" name="nTar" value="" />Temperatura do ar</td>
          <td><input type="checkbox" name="nChuva" value="" />Chuva</td>          
          <td><input type="checkbox" name="nVento" value="" />Vento</td>          
        </tr>
        <tr>
          <td><input type="checkbox" name="nNebulosidade" value="" />Nebulosidade</td>
          <td><input type="checkbox" name="nAtiv" value="" />Ativ</td>          
          <td><input type="checkbox" name="nVento" value="" />Vento</td>          
        </tr>
        <tr>
          <td><input type="checkbox" name="nCondutividade" value="" />Condutividade</td>
          <td><input type="checkbox" name="nTransparencia" value="" />Transparência</td>          
          <td><input type="checkbox" name="nODMG" value="" />ODmg</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nMigraped" value="" />Migraped</td>
          <td><input type="checkbox" name="nMigrad" value="" />Migrad</td>          
          <td><input type="checkbox" name="nGuildaped" value="" />Guildaped</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nCTROF" value="" />CTROF</td>
          <td><input type="checkbox" name="nFamilia" value="" />Fam&iacute;lia</td>          
          <td><input type="checkbox" name="nGne" value="" />Gênero/Espécie</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nEspecie" value="" />Esp&eacute;cie</td>
          <td><input type="checkbox" name="nLt" value="" />Lt</td>
          <td><input type="checkbox" name="nLt" value="" />Lt</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nLs" value="" />Ls</td>
          <td><input type="checkbox" name="nWt" value="" />Wt</td>
          <td><input type="checkbox" name="nWg" value="" />Wg</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nWe" value="" />We</td>
          <td><input type="checkbox" name="nWv" value="" />Wv</td>
          <td><input type="checkbox" name="nGre" value="" />Gre</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nGri" value="" />Gri</td>          
          <td><input type="checkbox" name="nRgs" value="" />Rgs</td>          
          <td><input type="checkbox" name="nSexo" value="" />Sexo</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        </table>
        </fieldset> 
        <fieldset> 
        <legend>Parâmetros</legend>
        
        <table width="449" border="1">
        <tr>
          <td>Métrica
              <select name="select">
                <option value="0">Confidence</option>
                <option value="1">Lift</option>
                <option value="2">Leverage</option>
                <option value="3">Conviction</option>
              </select>
          </td>
          <td>Confiança
              <input name="conf" type="text" value="0.9" />
          </td>
        </tr>
        <tr>          
          <td>Nº de Regras
              <input name="regras" type="text" value="10" />
          </td>
          <td>Suporte M&iacute;nimo
              <input name="sup" type="text" value="0.1" />
          </td>
        </tr>        
      </table>
      <p>&nbsp;</p>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="SQL"/> 
      </p>  
     </fieldset>
    </form>
                
    
    
    <fieldset>            
        <legend>Resultado do Processamento</legend>
        <span>
            <% 
    try
    {
                    out.print(result.replaceAll("\n", "<br>"));
       }catch (Exception e) {
                out.println(sql);
                e.printStackTrace();
                out.print(e.toString());
            
        } 
        %> </span>
    </fieldset>