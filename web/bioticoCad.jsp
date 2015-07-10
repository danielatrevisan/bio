<%
	//Inicializa VariÃ¡veis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do FormulÃ¡rio
     
    String nNumero = request.getParameter("tNumero");
    String nData = request.getParameter("tData");
    String nHorario = request.getParameter("tHorario");
    String nProjeto = request.getParameter("nProjetoId");
    String nPonto = request.getParameter("nPontoId");
    String nAparelho = request.getParameter("nAparelhoId");
    String nGeneroEspecie = request.getParameter("nGeneroEspecieId");
    String nMigraped = request.getParameter("nMigrapedId");
    String nMigrad = request.getParameter("nMigradId");
    String nGuildaped = request.getParameter("nGuildapedId");
    String nCtrof = request.getParameter("nCtrofId");
    String nFamilia = request.getParameter("nFamiliaId");
    String nEsporigi = request.getParameter("nEsporigiId");
    String nEspecie = request.getParameter("nEspecieId");
    String nEsppecie = request.getParameter("nEsppecieId");
    String nEspatual = request.getParameter("nEspatualId");
    String nEstadio = request.getParameter("nEstadioId");
    String nAmbiente = request.getParameter("nAmbienteId");    
    String nLt = request.getParameter("tLt");
    String nLs = request.getParameter("tLs");
    String nWt = request.getParameter("tWt");
    String nWg = request.getParameter("tWg");
    String nGre = request.getParameter("tGre");
    String nGri = request.getParameter("tGri");
    String nWe = request.getParameter("tWe");
    String nWv = request.getParameter("tWv");
    String nSexo = request.getParameter("tSexo"); 
    String nLocalColeta = request.getParameter("nLocalColetaId"); 
        
    String botao = request.getParameter("botao");
	
	//Trata a AÃ§Ã£o do BotÃ£o
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "insert into biotico (genero_especie_id, migraped_id, migrad_id, guildaped_id, ctrof_id, aparelho_id, estadio_id, ambiente_id, esporigi_id, familia_id, especie_id, esppecie_id, espatual_id,ponto_id, local_coleta_id, projeto_id, data_coleta, horario, numero, lt, ls, wt, sexo, wg, gre, gri, we, wv)"
                        + "values ('" +nGeneroEspecie+"', '" +nMigraped+"', '" +nMigrad+"', '" +nGuildaped+"', '" +nCtrof+"', '" +nAparelho+"', '" +nEstadio+"', '" +nAmbiente+"', '" +nEsporigi+"', '" +nFamilia+"', '" +nEspecie+"', '" +nEsppecie+"', '" +nEspatual+"', '" +nPonto+"', '" +nLocalColeta+"', '" +nProjeto+"', '" +nData+"', '" +nHorario+"', '" +nNumero+"', '" +nLt+"','" +nLs+"','" +nWt+"', '" +nSexo+"', '" +nWg+"','" +nGre+"','" +nGri+"','" +nWe+"','" +nWv+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Biótico Cadastrado com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } out.println(sql);
    }        
%>

<form method="post" id="cadastro" action="index.jsp?url=bioticoCad">
    <fieldset>
        <legend>Dados bióticos</legend>
        <fieldset>            
            <p>
            	<label for="cNumero">Número: </label><input id="cNumero" name="tNumero" type="text" size="10" maxlength="50"/>
                <label for="cData">Data da Coleta: </label><input id="cData" name="tData" type="date"/>
                <label for="cHorario">Horário: </label><input id="cHorario" name="tHorario" type="text" size="10" maxlength="15"/>
            </p> 
            <p> 
                <label for="projetoId">Projeto: </label>
                <%
                    ResultSet projeto = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from projeto";
                                                                
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            projeto = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nProjetoId" id="projetoId">
                    <option> </option>
                    <%while(projeto.next()) { %>
                    <option value="<%out.print(projeto.getString("id"));%>"><%out.print(projeto.getString("nome"));%></option>
                <%}%>
                </select>
                
                <label for="localColetaId">Local da Coleta: </label>
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

                        <select name="nLocalColetaId" id="localColetaId">
                            <option> </option> 
                            <%while(local.next()) { %>
                                <option value="<%out.print(local.getString("id"));%>"><%out.print(local.getString("nome"));%> - <%out.print(local.getString("sigla"));%></option>
                            <%}%>
                        </select>
                
                <label for="ambienteId">Ambiente: </label>
                <%
                    ResultSet amb = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from ambiente order by nome";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            amb = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nAmbienteId" id="ambienteId">
                    <option> </option> 
                    <%while(amb.next()) { %>
                    <option value="<%out.print(amb.getString("id"));%>"><%out.print(amb.getString("nome"));%></option>
                <%}%>
                </select>               
            </p>    
            <p>
                <label for="pontoId">Ponto: </label>
                <%
                    ResultSet ponto = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from ponto";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            ponto = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nPontoId" id="pontoId">
                    <option> </option> 
                    <%while(ponto.next()) { %>
                    <option value="<%out.print(ponto.getString("id"));%>"><%out.print(ponto.getString("nome"));%></option>
                <%}%>
                </select>
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
                                    out.println("Ocorreu um erro ao cadastrar biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

                        %>
                        <select name="tAparelho" id="aparelhoId">
                        <option></option>
                        <%while(aparelho.next()) { %>
                            <option value="<%out.print(aparelho.getString("id"));%>"><%out.print(aparelho.getString("aparelho"));%> - <%out.print(aparelho.getString("equipamento"));%></option>
                        <%}%>
                        </select>               
            </p>
        </fieldset>  
        <fieldset>
        	<p>
                <label for="generoEspecieId">Gênero/Nome da Espécie: </label>
                <%
                    ResultSet gne = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from genero_especie order by nome";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            gne = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nGeneroEspecieId" id="generoEspecieId">
                    <option> </option> 
                    <%while(gne.next()) { %>
                    <option value="<%out.print(gne.getString("id"));%>"><%out.print(gne.getString("nome"));%></option>
                <%}%>
                </select>
                
                <label for="migrapedId">Guilda Reprodutiva - MIGRAPED: </label>
                <%
                    ResultSet migraped = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from migraped order by nome";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            migraped = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nMigrapedId" id="migrapedId">
                    <option> </option> 
                    <%while(migraped.next()) { %>
                    <option value="<%out.print(migraped.getString("id"));%>"><%out.print(migraped.getString("nome"));%></option>
                <%}%>
                </select>
                
                <label for="migradId">Guilda Reprodutiva - MIGRAD: </label>
                <%
                    ResultSet migrad = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from migrad order by nome";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            migrad = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nMigradId" id="migradId">
                    <option> </option> 
                    <%while(migrad.next()) { %>
                    <option value="<%out.print(migrad.getString("id"));%>"><%out.print(migrad.getString("nome"));%></option>
                <%}%>
                </select>
             </p>
             <p>  
                <label for="guildaId">Guilda Trófica de Alimentação - GUILDAPED: </label>
                <%
                    ResultSet guilda = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from guildaped order by nome";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            guilda = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nGuildapedId" id="guildapedId">
                    <option> </option> 
                    <%while(guilda.next()) { %>
                    <option value="<%out.print(guilda.getString("id"));%>"><%out.print(guilda.getString("nome"));%></option>
                <%}%>
                </select>              
			    
                <label for="ctrofId">Categoria Trófica - CTROF: </label>
                <%
                    ResultSet ctrof = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from ctrof order by nome";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            ctrof = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nCtrofId" id="ctrofId">
                    <option> </option> 
                    <%while(ctrof.next()) { %>
                    <option value="<%out.print(ctrof.getString("id"));%>"><%out.print(ctrof.getString("nome"));%></option>
                <%}%>
                </select>

                <label for="familiaId">Família: </label>
                <%
                    ResultSet familia = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select f.id, f.nome fam, o.nome ord from familia f left join ordem o on f.ordem_id = o.id order by f.nome";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            familia = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nFamiliaId" id="familiaId">
                    <option> </option> 
                    <%while(familia.next()) { %>
                    <option value="<%out.print(familia.getString("id"));%>"><%out.print(familia.getString("fam"));%> - <%out.print(familia.getString("ord"));%></option>
                <%}%>
                </select>              
             </p>    
             <p>
                <label hidden for="esporigiId">Esporigi: </label>
                <%
                    ResultSet esporigi = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select e.id, e.nome esporigi, ea.nome especie_agrupada from esporigi e left join especie_agrupada ea on e.especie_agrupada_id = ea.id order by esporigi";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            esporigi = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select hidden name="nEsporigiId" id="esporigiId"> 
                    <option> </option>
                    <%while(esporigi.next()) { %>
                    <option value="<%out.print(esporigi.getString("id"));%>"><%out.print(esporigi.getString("esporigi"));%> - <%out.print(esporigi.getString("especie_agrupada"));%></option>
                <%}%>
                </select> 
                           
                <label for="especieId">Espécie: </label>
                <%
                    ResultSet especie = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select e.id, e.nome especie, ea.nome especie_agrupada from especie e left join especie_agrupada ea on e.especie_agrupada_id = ea.id order by especie";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            especie = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nEspecieId" id="especieId"> 
                    <option> </option>
                    <%while(especie.next()) { %>
                    <option value="<%out.print(especie.getString("id"));%>"><%out.print(especie.getString("especie"));%> - <%out.print(especie.getString("especie_agrupada"));%></option>
                <%}%>
                </select>
            </p>
            <p>
                <label hidden for="esppecieId">Esppecie: </label>
                <%
                    ResultSet esppecie = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select e.id, e.nome especie, ea.nome especie_agrupada from esppecie e left join especie_agrupada ea on e.especie_agrupada_id = ea.id order by especie";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            esppecie = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select hidden name="nEsppecieId" id="esppecieId"> 
                    <option> </option>
                    <%while(esppecie.next()) { %>
                    <option value="<%out.print(esppecie.getString("id"));%>"><%out.print(esppecie.getString("especie"));%> - <%out.print(esppecie.getString("especie_agrupada"));%></option>
                <%}%>
                </select>          
            
                <label hidden for="espatualId">Espatual: </label>
                <%
                    ResultSet espatual = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select e.id, e.nome especie, ea.nome especie_agrupada from espatual e left join especie_agrupada ea on e.especie_agrupada_id = ea.id order by especie";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            espatual = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select hidden name="nEspatualId" id="espatualId">
                    <option> </option>
                    <%while(espatual.next()) { %>
                    <option value="<%out.print(espatual.getString("id"));%>"><%out.print(espatual.getString("especie"));%> - <%out.print(espatual.getString("especie_agrupada"));%></option>
                <%}%>
                </select>
                
		<label for="estadioId">Estádio: </label>
                <%
                    ResultSet estadio = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select e.id, e.nome, em.nome maturacao from estadio e left join estadio_maturacao em on e.estadio_maturacao_id = em.id order by e.nome";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            estadio = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o dado biótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nEstadioId" id="estadioId">   
                    <option> </option>
                    <%while(estadio.next()) { %>
                    <option value="<%out.print(estadio.getString("id"));%>"><%out.print(estadio.getString("nome"));%> - <%out.print(estadio.getString("maturacao"));%></option>
                <%}%>
                </select>                                                                                         
            </p>
            </fieldset>
        <fieldset>            
            <p>              
                <label for="cLt">Comprimento Total: </label><input id="cLt" name="tLt" type="text" size="10" maxlength="50"/>                
                
                <label for="cLs">Comprimento Padrão: </label><input id="cLs" name="tLs" type="text" size="10" maxlength="50"/>                                
                
		<label for="cWt">Peso Total: </label><input id="cWt" name="tWt" type="text" size="10" maxlength="50"/>                
            </p>
            <p>
                <label for="cWg">Peso da Gônoda: </label><input id="cWg" name="tWg" type="text" size="10" maxlength="50"/>                                

                <label for="cGre">GRE: </label><input id="cGre" name="tGre" type="text" size="10" maxlength="50"/>                                
                
		<label for="cGri">GRI: </label><input id="cGri" name="tGri" type="text" size="10" maxlength="50"/>                                
            </p>
            <p>
                <label for="cWe">WE: </label><input id="cWe" name="tWe" type="text" size="10" maxlength="50"/>                
                <label for="cWv">WV: </label><input id="cWv" name="tWv" type="text" size="10" maxlength="50"/>                                                                
                <label for="cSexo">Sexo: </label><input id="cSexo" name="tSexo" type="text" size="10" maxlength="50"/>                                
            </p>
        </fieldset>
                
        <% out.println(mensagem);%>
        <p>
            <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
        </p>
        </fieldset>
</form>