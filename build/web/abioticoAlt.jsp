<%

	//Inicializa VariÃ¡veis
    String sql = "";
	String mensagem = "";
    
    //Recebe Dados do FormulÃ¡rio    

    String idAbiotico = request.getParameter("idAbiotico");
     
    String nAparelho = request.getParameter("nAparelho");
    String nLocalColeta = request.getParameter("nLocalColeta");
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
    String tVolume = request.getParameter("tVolume");
    String tOvo = request.getParameter("tOvo");
    String tLar1 = request.getParameter("tLar1");
    String tLar2 = request.getParameter("tLar2");
    String tJuve = request.getParameter("tJuve");
    String tCama = request.getParameter("tCama");
    String tRede = request.getParameter("tRede");
    String tDensiovo = request.getParameter("tDensiovo");
    String tDensilar = request.getParameter("tDensilar");
    String tDensiict = request.getParameter("tDensiict");
    
    String botao = request.getParameter("botao");
    
	//Trata aÃ§Ã£o do BotÃ£o
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "UPDATE abiotico "
                        + " SET aparelho_id='"+nAparelho+"', local_coleta_id='"+nLocalColeta+"', planc='"+tPlanc+"', data_coleta='"+tDataColeta+"', hora='"+tHora+"', margem='"+tMargem+"', smf='"+tSMF+"', ativ='"+tAtividade+"', vento='"+tVento+"', nebulosidade='"+tNebulosidade+"', chuva='"+tChuva+"', "
                        + "     tar='"+tTar+"', tagua='"+tAgua+"', transp='"+tTransp+"', ph='"+tPh+"', cond='"+tCond+"', odmg='"+tOdmg+"', volume='"+tVolume+"', ovo='"+tOvo+"', lar1='"+tLar1+"', lar2='"+tLar2+"', juve='"+tJuve+"', cama='"+tCama+"', rede='"+tRede+"', densiovo='"+tDensiovo+"', "
                        + "     densilar='"+tDensilar+"', densiict='"+tDensiict+"'"
                        + " WHERE id="+idAbiotico;
                               
                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Abiótico alterado com sucesso.";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar o Abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        }
    }
%>

        <%
			ResultSet abiotico = null;
			try {
					Connection connection = PosFactory.getConnection();
		
					sql = "SELECT * FROM abiotico WHERE id = "+idAbiotico;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					abiotico = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("OCORREU UMA PROBLEMA - FAVOR INFORMAR ADMINISTRADOR POR email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();          
			}
		//alterar para first e retirar o while
                  while(abiotico.next()) { %>
        <form method="post" id="cadastro" action="index.jsp?abioticoAlt&idAbiotico=<%out.print(abiotico.getString("id"));%>">            
            <fieldset>
                <legend>Dados Abióticos</legend>
                <input type="hidden" name="idAbiotico" value="<%out.print(abiotico.getString("id"));%>">
                <fieldset>
                    <p>
                        <label for="tAmostra">Amostra: </label><input id="tAmostra" name="tAmostra" type="text" size="10" maxlength="50" READONLY/>
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
                        <label for="tHora">Hora: </label><input id="tHora" name="tHora" type="text" size="10" maxlength="50"/>
                    </p>
                </fieldset>
                <fieldset>
                    
                    <p>
                        <label for="aparelhoId">Aparelho: </label>
                        <%
                            ResultSet aparelho = null;
                            try {
                                    Connection connection = PosFactory.getConnection();

                                    sql = "select a.id as id, a.nome as aparelho, e.nome as equipamento from aparelho a left join equipamento e on a.equipamento_id = e.id order by aparelho";
                                    
                                    PreparedStatement stmt = connection.prepareStatement(sql);

                                    aparelho = stmt.executeQuery(); 
                                    
                                    connection.close();
                                } catch (SQLException sqle) {
                                    out.println("Ocorreu um erro ao cadastrar abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

                        %>
                        <select name="tAparelho" id="aparelhoId">
                        <option></option>
                        <%while(aparelho.next()) { %>
                            <option value="<%out.print(aparelho.getString("id"));%>"><%out.print(aparelho.getString("aparelho"));%> - <%out.print(aparelho.getString("equipamento"));%></option>
                        <%}%>
                        </select>
                        <label for="tPlanc">Planc: </label><input id="tPlanc" name="tPlanc" type="text" size="10" maxlength="50"/>
                        <label for="tRede">Rede: </label><input id="tRede" name="tRede" type="text" size="10" maxlength="50"/>
                    </p>
                </fieldset>
                <fieldset>
                    
                    <p>
                        <label for="tMargem">Margem: </label><input id="tMargem" name="tMargem" type="text" size="10" maxlength="50"/>
                        <label for="tSMF">SMF: </label><input id="tSMF" name="tSMF" type="text" size="10" maxlength="50"/>
                        <label for="tProfundidade">Profundidade: </label><input id="tProfundidade" name="tProfundidade" type="text" size="10" maxlength="50"/>
                    </p>
                </fieldset>
                <fieldset>
                    
                    <p>
                        <label for="tAtividade">Atividade: </label><input id="tAtividade" name="tAtividade" type="text" size="10" maxlength="50"/>
                        <label for="tVento">Vento: </label><input id="tVento" name="tVento" type="text" size="10" maxlength="50"/>
                        <label for="tNebulosidade">Nebulosidade: </label><input id="tNebulosidade" name="tNebulosidade" type="text" size="10" maxlength="50"/>
                    </p>
                    <p>
                        <label for="tchuva">Chuva: </label><input id="tChuva" name="tChuva" type="text" size="10" maxlength="50"/>
                        <label for="tTar">Temperatura do Ar: </label><input id="tTar" name="tTar" type="text" size="10" maxlength="50"/>
                        <label for="tTagua">Temperatura da Água: </label><input id="tTagua" name="tAgua" type="text" size="10" maxlength="50"/>
                    </p>
                    <p>
                        <label for="tTransp">Transparência: </label><input id="tTransp" name="tTransp" type="text" size="10" maxlength="50"/>
                        <label for="tPh">PH: </label><input id="tPh" name="tPh" type="text" size="10" maxlength="50"/>
                        <label for="tCond">Condição: </label><input id="tCond" name="tCond" type="text" size="10" maxlength="50"/>
                    </p>
                    <p>
                        <label for="tOdmg">Oxigênio Dissolvido: </label><input id="tOdmg" name="tOdmg" type="text" size="10" maxlength="50"/>
                        <label for="tVolume">Volume: </label><input id="tVolume" name="tVolume" type="text" size="10" maxlength="50"/>
                    </p>
                </fieldset>
                <fieldset>
                    
                    <p>
                        <label for="tOvo">Ovo: </label><input id="tOvo" name="tOvo" type="text" size="10" maxlength="50"/>
                        <label for="tLar1">Larva 1: </label><input id="tLar1" name="tLar1" type="text" size="10" maxlength="50"/>
                        <label for="tLar2">Larva 2: </label><input id="tLar2" name="tLar2" type="text" size="10" maxlength="50"/>
                    </p>
                    <p>
                        <label for="tJuve">Juvenil: </label><input id="tJuve" name="tJuve" type="text" size="10" maxlength="50"/>
                        <label for="tCama">Cama: </label><input id="tCama" name="tCama" type="text" size="10" maxlength="50"/>                        
                        <label for="tDensiOvo">Densidade do Ovo: </label><input id="tDensiOvo" name="tDensiOvo" type="text" size="10" maxlength="50"/>                        
                        <label for="tDensiLar">Densidade da Larva: </label><input id="tDensiLar" name="tDensiLar" type="text" size="10" maxlength="50"/>                        
                        <label for="tDensiict">Densiict: </label><input id="tDensiict" name="tDensiict" type="text" size="10" maxlength="50"/>
                    </p>
                </fieldset>
                <% out.println(mensagem);%>
                <p>
                    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
                </p>
            </fieldset>
        </form>