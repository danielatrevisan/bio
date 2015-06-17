
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
     
    String nLocal = request.getParameter("nLocal"); 	
    String nPeriodo = request.getParameter("nPeriodo"); 	
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
    
    String consulta = "select ";
    InstanceQuery query = new InstanceQuery();
    FastVector rs[];
    AprioriItemSet a;
    query.setDatabaseURL("jdbc:postgresql://localhost:5432/bio");
    query.setUsername("postgres");
    query.setPassword("admin");
 
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
        
        if ((!(nLocal.equalsIgnoreCase("Todos"))))
        {
            consulta = consulta + " where ";
        }
        if ((nLocal != "") && (nLocal != null))
        {
            if (!(nLocal.equalsIgnoreCase("Todos")))
            {                
                consulta = consulta + " b.local_coleta_id = " + nLocal;
            }            
        }
        
        
        if (!(nPeriodo.equalsIgnoreCase("Todos")))
        {
            if (consulta.contains("where"))
            {
                consulta = consulta + " and ";
            }else
            {
                consulta = consulta + " where ";
            }
          
            if (nPeriodo.equalsIgnoreCase("Antes"))
                {
                    nData = "<= '2001-09-01'";
                }
                if (nPeriodo.equalsIgnoreCase("Durante"))
                {
                    nData = "between '2001-09-01' and '2002-03-01'";
                }
                if (nPeriodo.equalsIgnoreCase("Depois"))
                {
                    nData = ">= '2002-03-01'";
                }
                if (!(nPeriodo.equalsIgnoreCase("Todos")))
                {                        
                    consulta = consulta + " a.data_coleta " + nData;
                }
            
        }
    
    //out.println(consulta);
    consulta="select  l.nome as local,ap.nome as aparelho, a.smf, a.ph, coalesce(a.tagua, '') as tagua, a.cond, ab.nome as ambiente, g.nome as gne, m.nome as migraped, md.nome as migrad, gp.nome as guildaped, c.nome as ctrof, f.nome as familia, e.nome as especie from biotico b      left join abiotico a on b.abiotico_id = a.id      left join local_coleta l on a.local_coleta_id = l.id       left join aparelho ap on b.aparelho_id = ap.id      left join ambiente ab on b.ambiente_id = ab.id      left join genero_especie g on b.genero_especie_id = g.id       left join migraped m on b.migraped_id = m.id      left join migrad md on b.migrad_id = md.id      left join guildaped gp on b.guildaped_id = gp.id      left join ctrof c  on  b.ctrof_id = c.id      left join familia f on b.familia_id = f.id       left join especie e on b.especie_id = e.id";
    query.setQuery(consulta);
    Instances data = query.retrieveInstances();
    dado.setOptions(weka.core.Utils.splitOptions("-N 20 -T 0 -C 0.1 -D 0.05 -U 1.0 -M 0.1 -S -1.0 -c -1"));
    dado.buildAssociations(data);
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
              <label for="nLocalColeta">Local: </label>
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
                <select name="nLocal" id="localId">                    
                    <option value="Todos">Todos </option>
                    <% while(local.next()) { %>
                    <option value="<%out.print(local.getString("id"));%>"><%out.print(local.getString("nome"));%> - <%out.print(local.getString("sigla"));%></option>
                                
                <%}%>
                </select>          </td>
          <td width="232">
            <input type="checkbox" name="nAmbiente" value="checkbox" />
          Ambiente          </td>
        </tr>
        <tr>
          <td>
            <label>
              Per&iacute;odo da Coleta
              <select name="nPeriodo">
                <option value="Todos" selected="selected">
                  Todos                </option>
                <option value="Antes">
                  Antes                </option>
                <option value="Durante">
                  Durante                </option>
                <option value="Depois">
                  Depois                </option>
              </select>
            </label> </td>
          <td>
            <label>
              <input type="checkbox" name="nGne" value="checkbox" />
              Gênero/Espécie            </label>          </td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" name="nAparelho" value="checkbox" />
            Aparelho          </td>
          <td>
            <label>
              <input type="checkbox" name="nMigraped" value="checkbox" />
              Migraped            </label>          </td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" name="nSMF" value="checkbox" />
            SMF          </td>
          <td>
            <label>
              <input type="checkbox" name="nMigrad" value="checkbox" />
              Migrad            </label>          </td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" name="nProfundidade" value="checkbox" />
            Profundidade          </td>
          <td>
            <label>
              <input type="checkbox" name="nGuildaped" value="checkbox" />
              Guildaped            </label>          </td>
        </tr>
        <tr>
          <td>
            <label>
              <input type="checkbox" name="nPH" value="checkbox" />
              PH            </label>          </td>
          <td>
            <label>
              <input type="checkbox" name="nCTROF" value="checkbox" />
              CTROF            </label>          </td>
        </tr>
        <tr>
          <td>
            <label>
              <input type="checkbox" name="nTagua" value="checkbox" />
              Temperatura da &aacute;gua            </label>          </td>
          <td>
            <label>
              <input type="checkbox" name="nFamilia" value="checkbox" />
              Fam&iacute;lia            </label>          </td>
        </tr>
        <tr>
          <td>
            <label>
              <input type="checkbox" name="nCondutividade" value="checkbox" />
              Condutividade            </label>          </td>
          <td>
            <label>
              <input type="checkbox" name="nEspecie" value="checkbox" />
              Esp&eacute;cie            </label>          </td>
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
          <td><label>Métrica
              <select name="select">
                <option value="0">Confidence</option>
                <option value="1">Lift</option>
                <option value="2">Leverage</option>
                <option value="3">Conviction</option>
              </select>
          </label></td>
          <td><label>Confiança
              <input name="conf" type="text" value="0.9" />
          </label></td>
        </tr>
        <tr>          
          <td><label>Nº de Regras
              <input name="regras" type="text" value="10" />
          </label></td>
          <td><label>Suporte M&iacute;nimo
              <input name="sup" type="text" value="0.1" />
          </label></td>
        </tr>        
      </table>
      <p>&nbsp;</p>
      <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="SQL"/> 
      </p>  
     </fieldset>
    </form>
                
    <%String result = dado.toString();%>
    
    <fieldset>            
        <legend>Resultado do Processamento</legend>
        <span><% out.print(result.replaceAll("\n", "<br>"));%> </span>
    </fieldset>