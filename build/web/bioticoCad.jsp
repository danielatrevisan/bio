<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="conn.PosFactory"%>


<%
	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String nNumero = request.getParameter("tNumero");
    String nData = request.getParameter("tData");
    String nHorario = request.getParameter("tHorario");
    String nProjeto = request.getParameter("nProjeto");
    String nPonto = request.getParameter("nPonto");
    String nAparelho = request.getParameter("nAparelhoId");
    String nGeneroEspecie = request.getParameter("nGeneroEspecie");
    String nMigraped = request.getParameter("nMigrapedId");
    String nMigradId = request.getParameter("nMigradId");
    String nGuildaped = request.getParameter("nGuildapedId");
    String nCtrof = request.getParameter("nCtrofId");
    String nFamilia = request.getParameter("nFamilia");
    String nEsporigi = request.getParameter("nEsporigi");
    String nEspecie = request.getParameter("nEspecie");
    String nEsppecie = request.getParameter("nEsppecie");
    String nEspatual = request.getParameter("nEspatual");
    String nEstadioId = request.getParameter("nEstadioId");    
    String nLt = request.getParameter("tLt");
    String nLs = request.getParameter("tLs");
    String nWt = request.getParameter("tWt");
    String nWg = request.getParameter("tWg");
    String nGre = request.getParameter("tGre");
    String nGri = request.getParameter("tGri");
    String nWe = request.getParameter("tWe");
    String nWv = request.getParameter("tWv");
    String nSexo = request.getParameter("tSexo"); 
    
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "insert into exemplar (genero_especie_id, migraped_id, migrad_id, guildaped_id, ctrof_id, aparelho_id, estadio_id, ambiente_id, esporigi_id, familia_id, especie_id, esppecie_id, exemplar_id, espatual_id,ponto_id, local_coleta_id, projeto_id, data_coleta, horario, numero, lt, ls, wt, sexo, wg, gre, gri, we, wv)"
                        + "values ('" +nNumero+"','" +nData+"','" +nHorario+"','" +nProjeto+"','" +nPonto+"','" +nAparelhoId+"','" +nGeneroEspecie+"','" +nMigrapedId+"','" +nMigradId+"','" +nGuildapedId+"','" +nCtrofId+"','" +nFamilia+"','" +nEsporigi+"','" +nEspecie+"','" +nEsppecie+"','" +nEspatual+"','" +nEstadioId+"','" +nLt+"','" +nLs+"','" +nWt+"','" +nWg+"','" +nGre+"','" +nGri+"','" +nWe+"','" +nWv+"','" +nSexo+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Exemplar Cadastrado com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>
<!DOCTYPE html>
<html>
<head lang="pt-br">
    <meta charset="UTF-8">
    <title>Cadastro de Dados Biótico</title>
    <link rel="stylesheet" type="text/css" href="css/form.css"/>
</head>
<body>
<form method="post" id="cadastro" action="">
    <fieldset>
        <legend>Dados bióticos</legend>
        <fieldset>
            <legend></legend>
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
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nOrdem" id="ordemId">
                <%while(projeto.next()) { %>
                    <option value="<%out.print(projeto.getString("id"));%>"><%out.print(projeto.getString("nome"));%></option>
                <%}%>
                </select>
                
                <label for="localId">Local da Coleta: </label>
                <%
                    ResultSet local = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from local_coleta";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            local = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nLocal" id="localId">
                <%while(local.next()) { %>
                    <option value="<%out.print(local.getString("id"));%>"><%out.print(projeto.getString("nome"));%></option>
                <%}%>
                </select>
                
                <label for="ambienteId">Ambiente: </label>
                <%
                    ResultSet amb = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from ambiente";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            amb = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nAmbiente" id="ambienteId">
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
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nPonto" id="pontoId">
                <%while(ponto.next()) { %>
                    <option value="<%out.print(ponto.getString("id"));%>"><%out.print(ponto.getString("nome"));%></option>
                <%}%>
                </select>
                
		<label for="aparelhoId">Aparelho: </label>
                <%
                    ResultSet apar = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from aparelho";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            apar = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nAparelho" id="aparelhoId">
                <%while(apar.next()) { %>
                    <option value="<%out.print(apar.getString("id"));%>"><%out.print(apar.getString("nome"));%></option>
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

                            sql = "select id, nome from aparelho";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            gne = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nGeneroEspecie" id="generoEspecieId">
                <%while(gne.next()) { %>
                    <option value="<%out.print(gne.getString("id"));%>"><%out.print(gne.getString("nome"));%></option>
                <%}%>
                </select>
                
                <label for="migrapedId">Guilda Reprodutiva - MIGRAPED: </label>
                <%
                    ResultSet migraped = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from migraped";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            gne = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nMigraped" id="migrapedId">
                <%while(migraped.next()) { %>
                    <option value="<%out.print(migraped.getString("id"));%>"><%out.print(migraped.getString("nome"));%></option>
                <%}%>
                </select>
                
                <label for="migradId">Guilda Reprodutiva - MIGRAD: </label>
                <%
                    ResultSet migrad = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from migrad";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            gne = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nMigrad" id="migradId">
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

                            sql = "select id, nome from guildaped";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            gne = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nGuildaped" id="guildapedId">
                <%while(guilda.next()) { %>
                    <option value="<%out.print(guilda.getString("id"));%>"><%out.print(guilda.getString("nome"));%></option>
                <%}%>
                </select>              
			    
                <label for="ctrofId">Categoria Trófica - CTROF: </label>
                <%
                    ResultSet ctrof = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select id, nome from ctrof";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            gne = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="nCtrof" id="ctrofId">
                <%while(ctrof.next()) { %>
                    <option value="<%out.print(ctrof.getString("id"));%>"><%out.print(ctrof.getString("nome"));%></option>
                <%}%>
                </select>

                <label for="familiaId">Família: </label>
                <%
                    ResultSet familia = null;
                        try {
                            Connection connection = PosFactory.getConnection();

                            sql = "select f.id, f.nome fam, o.nome ord from familia f join ordem o on f.ordem_id = o.id";
                                    
                            PreparedStatement stmt = connection.prepareStatement(sql);

                            gne = stmt.executeQuery(); 
                                    
                            connection.close();
                            } catch (SQLException sqle) {
                                out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                sqle.printStackTrace();          
                            }
                %>
                <select name="familia" id="ctrofId">
                <%while(ctrof.next()) { %>
                    <option value="<%out.print(familia.getString("id"));%>"><%out.print(familia.getString("fam"));%>-<%out.print(familia.getString("ord"));%></option>
                <%}%>
                </select>              
             </p>    
             <p>
                <label for="esporigiId">Esporigi: </label>
                <select name="nEsporigi" id="esporigiId">
                    <option></option>
                </select>
                           
                <label for="especieId">Espécie: </label>
                <select name="nEspecie" id="especieId">
                    <option></option>
                </select>

                <label for="esppecieId">Esppecie: </label>
                <select name="nEsppecie" id="esppecieId">
                    <option></option>
                </select>                
            </p>    
            <p>
                <label for="espatualId">Espatual: </label>
                <select name="nEspatual" id="espatualId">
                    <option></option>
                </select>

				<label for="estadioId">Estádio: </label>
                <select name="nEstadioId" id="estadioId">
                    <option></option>
                </select>                                                                              
            </p>
            </fieldset>
        <fieldset>
            <legend></legend>
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
        <% out.println(mensagem);%>
        <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
        </p>
        </fieldset>
</form>
</body>
</html>