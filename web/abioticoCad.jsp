<%
    //Inicializa Variáveis
    String sql = "";
    String mensagem = "";
    
    //Recebe dados do Formulário
     
    String tLocalColeta = request.getParameter("tLocalColeta");
    String tPlanc = request.getParameter("tPlanc");
    String tDataColeta = request.getParameter("tDataColeta");
    String tHora = request.getParameter("tHora");
    String tMargem = request.getParameter("tMargem");
    String tSMF = request.getParameter("tSMF");
    String tAtividade = request.getParameter("tAtividade");
    String tVento = request.getParameter("tVento");
    String tNebulosidade = request.getParameter("tNebulosidade");
    String tChuva = request.getParameter("tChuva");
    String tTar = request.getParameter("tTar");
    String tAgua = request.getParameter("tAgua");
    String tTransp = request.getParameter("tTransp");
    String tPh = request.getParameter("tPh");
    String tCond = request.getParameter("tCond");
    String tOdmg = request.getParameter("tOdmg");         
    String tRede = request.getParameter("tRede");    
    String tProjeto = request.getParameter("tProjeto");
    String tAmostra = request.getParameter("tAmostra");
    String tProfundidade = request.getParameter("tProfundidade");
        
    
    String botao = request.getParameter("botao");
    
    //Trata a ação do Botao
    
    String acao = "";
    
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
    
    
    if(acao.equals("Salvar")) {        
        try {
                 Connection connection = PosFactory.getConnection();

                sql = "insert into abiotico (amostra, projeto_id, local_coleta_id, planc, rede, data_coleta, hora, margem, smf, profundidade, ativ, vento, nebulosidade, chuva, tar, tagua, transp, ph, cond)"
                        + "values ('" +tAmostra+"','" +tProjeto+"','" +tLocalColeta+"','" + tPlanc+"','" + tRede+"','" +tDataColeta+"','" + tHora+"','" + tMargem+"','" + tSMF+"','" + tProfundidade+"','" + tAtividade+"','" + tVento+"','" + tNebulosidade+"','" + tChuva+"','" + tTar+"','" + tAgua+"','" + tTransp+"','" + tPh+"','" + tCond+"')"; 
  
                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Abiótico Cadastrado com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar o abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

        <form method="post" id="tadastro" action="index.jsp?url=abioticoCad">
            <fieldset>
                <legend>Dados Abióticos</legend>
                <input type="hidden" name="idAbiotico" value="">
                <fieldset>
                <table width="0" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="150"><label for="tAmostra">Amostra: </label><input id="tAmostra" name="tAmostra" type="text" size="10" maxlength="50"/></td>
                    <td width="150">
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
                    </td>                    
                  </tr>
                  <tr>
                    <td>
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
                    </td>
                    <td>
                        <label for="DataColeta">Data: </label><input id="tDataColeta" name="tDataColeta" type="date"/>
                        
                    </td>
                    <tr>
                        <td>                       
                            <label for="tHora">Hora: </label><input id="tHora" name="tHora" type="text" size="10" maxlength="50"/>
                        </td>
                    </tr>
                  </tr>
                </table>
                </fieldset>
                <fieldset>
                    <table width="0" border="0" cellspacing="0" cellpadding="0">
                      <tr>                        
                        <td width="150"><label for="tPlanc">Planc: </label><input id="tPlanc" name="tPlanc" type="text" size="10" maxlength="50"/></td>
                        <td width="150"><label for="tRede">Rede: </label><input id="tRede" name="tRede" type="text" size="10" maxlength="50"/></td>
                      </tr>
                    </table>
                </fieldset>
                <fieldset>
                    <table width="0" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="150"><label for="tMargem">Margem: </label><input id="tMargem" name="tMargem" type="text" size="10" maxlength="50"/></td>
                        <td width="150"><label for="tSMF">SMF: </label><input id="tSMF" name="tSMF" type="text" size="10" maxlength="50"/></td>
                        <td width="150"><label for="tProfundidade">Profundidade: </label><input id="tProfundidade" name="tProfundidade" type="text" size="10" maxlength="50"/></td>
                      </tr>
                    </table>
                </fieldset>
                <fieldset>
                    <table width="0" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="150"><label for="tAtividade">Atividade: </label><input id="tAtividade" name="tAtividade" type="text" size="10" maxlength="50"/></td>
                        <td width="150"><label for="tVento">Vento: </label><input id="tVento" name="tVento" type="text" size="10" maxlength="50"/></td>
                        <td width="150"><label for="tNebulosidade">Nebulosidade: </label><input id="tNebulosidade" name="tNebulosidade" type="text" size="10" maxlength="50"/></td>
                      </tr>
                      <tr>
                        <td width="150"><label for="tchuva">Chuva: </label><input id="tChuva" name="tChuva" type="text" size="10" maxlength="50"/></td>
                        <td width="150"><label for="tTar">Temperatura do Ar (°C): </label><input id="tTar" name="tTar" type="text" size="3" maxlength="50"/></td>
                        <td width="150"><label for="tTagua">Temperatura da Água (°C): </label><input id="tTagua" name="tAgua" type="text" size="3" maxlength="50"/></td>
                      </tr>
                      <tr>
                        <td width="150"><label for="tTransp">Transparência (m): </label><input id="tTransp" name="tTransp" type="text" size="10" maxlength="50"/></td>
                        <td width="150"><label for="tPh">PH: </label><input id="tPh" name="tPh" type="text" size="10" maxlength="50"/></td>
                        <td width="150"><label for="tCond">Condutividade <sub>(mS/cm)</sub>: </label><input id="tCond" name="tCond" type="text" size="9" maxlength="50"/></td>
                        <td width="150"><label for="tOdmg">OD<sub>(mg/L)</sub>: </label><input id="tOdmg" name="tOdmg" type="text" size="9" maxlength="50"/></td>
                      </tr>                      
                    </table>
                </fieldset>                
                <% out.println(mensagem);%>
                <p>
                    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
                </p>
            </fieldset>
        </form>
