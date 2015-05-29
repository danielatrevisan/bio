
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
    
    String consulta = "select ";
  
    
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
        consulta = consulta + "gne ";
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
        consulta = consulta + "migrad ";
    }
    if ((nMigraped != "") && (nMigraped != null))
    {
        if (consulta.length() > 7)
        {
            consulta = consulta + ",";
        }
        consulta = consulta + "migraped ";
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
        consulta = consulta + "guildaped ";
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
        consulta = consulta + "ctrof ";
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
        consulta = consulta + "familia ";
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
        consulta = consulta + "especie ";
    }
  
    if (request.getParameter("botao")!=null)
    {
    consulta = consulta + "from biotico b left join abiotico a on b.abiotico_id = a.id";
    
    out.println(consulta);
    }
%>

    <form id="mineracao" method="post" action="index.jsp?url=mineracao">
      <table width="338" border="1">
        <tr>
          <td width="189">
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
                    <option></option>
                    <option>Todos </option>
                    <% while(local.next()) { %>
                    <option value="<%out.print(local.getString("id"));%>"><%out.print(local.getString("nome"));%><%out.print(local.getString("sigla"));%></option>
                                
                <%}%>
                </select>
                
              
        
          </td>
          <td>
            <input type="checkbox" name="nAmbiente" value="checkbox" />
            Ambiente
          </td>
        </tr>
        <tr>
          <td>
            <label>
              Per&iacute;odo da Coleta
              <select name="nPeriodo">
                <option selected="selected"> </option>
                <option>
                  Todos
                </option>
                <option>
                  Antes
                </option>
                <option>
                  Durante
                </option>
                <option>
                  Depois
                </option>
              </select>
            </label>
          </td>
          <td>
            <label>
              <input type="checkbox" name="nGne" value="checkbox" />
              GNE
            </label>
          </td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" name="nAparelho" value="checkbox" />
            Aparelho
          </td>
          <td>
            <label>
              <input type="checkbox" name="nMigraped" value="checkbox" />
              Migraped
            </label>
          </td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" name="nSMF" value="checkbox" />
            SMF
          </td>
          <td>
            <label>
              <input type="checkbox" name="nMigrad" value="checkbox" />
              Migrad
            </label>
          </td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" name="nProfundidade" value="checkbox" />
            Profundidade
          </td>
          <td>
            <label>
              <input type="checkbox" name="nGuildaped" value="checkbox" />
              Guildaped
            </label>
          </td>
        </tr>
        <tr>
          <td>
            <label>
              <input type="checkbox" name="nPH" value="checkbox" />
              PH
            </label>
          </td>
          <td>
            <label>
              <input type="checkbox" name="nCTROF" value="checkbox" />
              CTROF
            </label>
          </td>
        </tr>
        <tr>
          <td>
            <label>
              <input type="checkbox" name="nTagua" value="checkbox" />
              Temperatura da &aacute;gua
            </label>
          </td>
          <td>
            <label>
              <input type="checkbox" name="nFamilia" value="checkbox" />
              Fam&iacute;lia
            </label>
          </td>
        </tr>
        <tr>
          <td>
            <label>
              <input type="checkbox" name="nCondutividade" value="checkbox" />
              Condutividade
            </label>
          </td>
          <td>
            <label>
              <input type="checkbox" name="nEspecie" value="checkbox" />
              Esp&eacute;cie
            </label>
          </td>
        </tr>
      </table>
     <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="SQL"/> 
      </p>  
    </form>
 