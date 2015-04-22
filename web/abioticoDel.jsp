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
    
    //Recebe Dados do Formulário    

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
    
	//Trata ação do Botão
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Excluir")) {
        try {
                Connection connection = PosFactory.getConnection();

                sql = "DELETE FROM abiotico WHERE id = "+idAbiotico;
                                
                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem="Abiotico Excluído com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar o Abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }
%>
<!DOCTYPE html>
<html>
    <head lang="pt-br">
        <meta charset="UTF-8">
        <title>Edição de Abiótico</title>
        <link rel="stylesheet" type="text/css" href="css/form.css"/>
    </head>
    <body>
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
		%>
        <% while(abiotico.next()) { %>
        <form method="post" id="cadastro" action="abioticoDel.jsp?idAbiotico=<%out.print(abiotico.getString("id"));%>">
            <fieldset>
                <legend>Dados Abióticos</legend>
                <input type="hidden" name="idAbiotico" value="<%out.print(abiotico.getString("id"));%>">
                <fieldset>
                    <legend></legend>
                    <p>
                        <label for="aparelhoId">Aparelho: </label>
                        <%
                            ResultSet aparelho = null;
                            try {
                                    Connection connection = PosFactory.getConnection();

                                    sql = "select a.id as id, a.nome as aparelho, e.nome as equipamento from aparelho a left join equipamento_apar e on a.equipamento_apar_id = e.id order by aparelho";
                                    
                                    PreparedStatement stmt = connection.prepareStatement(sql);

                                    aparelho = stmt.executeQuery(); 
                                    
                                    connection.close();
                                } catch (SQLException sqle) {
                                    out.println("Ocorreu um erro ao cadastrar o Abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

                        %>
                        <select name="nAparelho" id="aparelhoId">
                        <%while(aparelho.next()) { 
                            if(aparelho.getString("id").equals(abiotico.getString("aparelho_id"))){
                                
                        %>                            
                        <option value="<%out.print(aparelho.getString("id"));%>" selected><%out.print(aparelho.getString("aparelho"));%>-<%out.print(aparelho.getString("equipamento"));%></option>
                        <%}}%>                         
                        </select>

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
                        <select name="nLocalColeta" id="localColetaId">
                        <%while(local.next()) { 
                            if(local.getString("id").equals(abiotico.getString("local_coleta_id"))){
                                
                        %>                            
                        <option value="<%out.print(local.getString("id"));%>" selected><%out.print(local.getString("nome"));%>-<%out.print(local.getString("sigla"));%></option>
                        <%} else {
                                
                          %><option value="<%out.print(local.getString("id"));%>"><%out.print(local.getString("nome"));%>-<%out.print(local.getString("sigla"));%></option>
                        <%}}%>
                        </select>
                        
                        <label for="DataColeta">Data da Coleta: </label><input id="cDataColeta" name="tDataColeta" type="date" value="<%out.print(abiotico.getString("data_coleta"));%>" readonly/>
                        
                    </p>
                </fieldset>
                <fieldset>
                    <legend></legend>
                    <p>
                        <label for="cPlanc">Planc: </label><input id="cPlanc" name="tPlanc" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("planc"));%>" readonly/>

                        <label for="cRede">Rede: </label><input id="cRede" name="tRede" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("rede"));%>" readonly/>
                    </p>
                </fieldset>
                <fieldset>
                    <legend></legend>
                    <p>
                        <label for="cMargem">Margem: </label><input id="cMargem" name="tMargem" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("margem"));%>" readonly/>

                        <label for="cSMF">SMF: </label><input id="cSMF" name="tSMF" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("smf"));%>" readonly/>
                    </p>
                </fieldset>
                <fieldset>
                    <legend></legend>
                    <p>
                        <label for="cAtividade">Atividade: </label><input id="cAtividade" name="tAtividade" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("ativ"));%>" readonly/>

                        <label for="cVento">Vento: </label><input id="cVento" name="tVento" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("vento"));%>" readonly/>

                        <label for="cNebulosidade">Nebulosidade: </label><input id="cNebulosidade" name="tNebulosidade" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("nebulosidade"));%>" readonly/>
                    </p>
                    <p>
                        <label for="cchuva">Chuva: </label><input id="cChuva" name="tChuva" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("chuva"));%>" readonly/>

                        <label for="cTar">Temperatura do Ar: </label><input id="cTar" name="tTar" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("tar"));%>" readonly/>

                        <label for="cTagua">Temperatura da Água: </label><input id="cTagua" name="tAgua" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("tagua"));%>" readonly/>
                    </p>
                    <p>
                        <label for="cTransp">Transparência: </label><input id="cTransp" name="tTransp" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("transp"));%>" readonly/>

                        <label for="cPh">PH: </label><input id="cPh" name="tPh" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("ph"));%>" readonly/>

                        <label for="cCond">Condição: </label><input id="cCond" name="tCond" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("cond"));%>" readonly/>
                    </p>
                    <p>
                        <label for="cOdmg">Oxigênio Dissolvido: </label><input id="cOdmg" name="tOdmg" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("odmg"));%>" readonly/>

                        <label for="cVolume">Volume: </label><input id="cVolume" name="tVolume" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("volume"));%>" readonly/>
                    </p>
                </fieldset>
                <fieldset>
                    <legend></legend>
                    <p>
                        <label for="cOvo">Ovo: </label><input id="cOvo" name="tOvo" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("ovo"));%>" readonly/>

                        <label for="cLar1">Larva 1: </label><input id="cLar1" name="tLar1" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("lar1"));%>" readonly/>

                        <label for="cLar2">Larva 2: </label><input id="cLar2" name="tLar2" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("lar2"));%>" readonly/>
                    </p>
                    <p>
                        <label for="cJuve">Juvenil: </label><input id="cJuve" name="tJuve" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("juve"));%>" readonly/>

                        <label for="cCama">Cama: </label><input id="cCama" name="tCama" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("cama"));%>" readonly/>
                        
                        <label for="cDensiOvo">Densidade do Ovo: </label><input id="cDensiOvo" name="tDensiOvo" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("densiovo"));%>" readonly/>
                        
                        <label for="cDensiLar">Densidade da Larva: </label><input id="cDensiLar" name="tDensiLar" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("densilar"));%>" readonly/>
                        
                        <label for="cDensiict">Densiict: </label><input id="cDensiict" name="tDensiict" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("densiict"));%>" readonly/>
                    </p>
                </fieldset>
                        <%
							}
							out.println(mensagem);
						%>
                <p>
                    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Excluir"/> 
                </p>
            </fieldset>
        </form>
    </body>
</html>