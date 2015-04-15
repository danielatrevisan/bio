<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="conn.PosFactory"%>


<%

    Connection conexao = null;
    String sql;
    ResultSet rs;
    
    String opcao = request.getParameter("operacao");
    String operacao;
    if(opcao==null){
        operacao = "cadastrar";
    }else{
        operacao = request.getParameter("operacao");
    }
    

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
    
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
   // if (botao != null) {
        out.println("Salvar");
        try {
                Connection connection = PosFactory.getConnection();

                sql = "insert into abiotico (aparelho_id, local_coleta_id, planc, data_coleta, hora, margem, smf, ativ, vento, nebulosidade, chuva, tar, tagua, transp, ph, cond, odmg, volume, ovo, lar1, lar2, juve, cama, rede, densiovo, densilar, densiict)"
                        + "          values ('" +nAparelho+"','" +nLocalColeta+"','" + tPlanc+"','" +tDataColeta+"','" + tHora+"','" + tMargem+"','" + tSMF+"','" + tAtividade+"','" + tVento+"','" + tNebulosidade+"','" + tChuva+"','" + tTar+"','" + tAgua+"','" + tTransp+"','" + tPh+"','" + tCond+"','" + tOdmg+"','" + tVolume+"','" + tOvo+"','" + tLar1+"','" + tLar2+"','" + tJuve+"','" + tCama+"','" + tRede+"','" + tDensiovo+"','" + tDensilar+"','" + tDensiict+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                out.println("Cadastrado.");

                connection.close();
            } catch (SQLException sqle) {
                out.write("OCORREU UMA PROBLEMA - FAVOR INFORMAR ADMINISTRADOR POR email@email.com.br!<br><br>Exception::<br>" + sqle);
                sqle.printStackTrace();          
        } 
    }else if(acao.equals("Excluir")) {
   // if (botao != null) {
        out.println("Excluir");
        try {
                Connection connection = PosFactory.getConnection();

                sql = "DELETE FROM abiotico WHERE id = "+idAbiotico;
                                
                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                out.println("Excluído.");

                connection.close();
            } catch (SQLException sqle) {
                out.write("OCORREU UMA PROBLEMA - FAVOR INFORMAR ADMINISTRADOR POR email@email.com.br!<br><br>Exception::<br>" + sqle);
                sqle.printStackTrace();          
        } 
    }else if((acao.equals("Salvar")) && (idAbiotico!=null)) {
   // if (botao != null) {
        out.println("Alterar");
        try {
                Connection connection = PosFactory.getConnection();

                sql = "UPDATE abiotico "
                        + " SET aparelho_id='"+nAparelho+"', local_coleta_id='"+nLocalColeta+"', planc='"+tPlanc+"', data_coleta='"+tDataColeta+"', hora='"+tHora+"', margem='"+tMargem+"', smf='"+tSMF+"', ativ='"+tAtividade+"', vento='"+tVento+"', nebulosidade='"+tNebulosidade+"', chuva='"+tChuva+"', "
                        + "     tar='"+tTar+"', tagua='"+tAgua+"', transp='"+tTransp+"', ph='"+tPh+"', cond='"+tCond+"', odmg='"+tOdmg+"', volume='"+tVolume+"', ovo='"+tOvo+"', lar1='"+tLar1+"', lar2='"+tLar2+"', juve='"+tJuve+"', cama='"+tCama+"', rede='"+tRede+"', densiovo='"+tDensiovo+"', "
                        + "     densilar='"+tDensilar+"', densiict='"+tDensiict+"')"
                        + " WHERE id"+idAbiotico;
                               
                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                out.println("Excluído.");

                connection.close();
            } catch (SQLException sqle) {
                out.write("OCORREU UMA PROBLEMA - FAVOR INFORMAR ADMINISTRADOR POR email@email.com.br!<br><br>Exception::<br>" + sqle);
                sqle.printStackTrace();          
        }
    }
    ResultSet abiotico = null;
    String frase = null;
    if(operacao.equals("cadastrar")){
        frase = "Cadastro";
    }else if(operacao.equals("editar")){
         frase = "Edição";
         try {
                Connection connection = PosFactory.getConnection();

                sql = "SELECT * FROM abiotico WHERE id = "+idAbiotico;
                
                PreparedStatement stmt = connection.prepareStatement(sql);

                abiotico = stmt.executeQuery();      

                out.println("selecionando.");

                connection.close();
            } catch (SQLException sqle) {
                out.write("OCORREU UMA PROBLEMA - FAVOR INFORMAR ADMINISTRADOR POR email@email.com.br!<br><br>Exception::<br>" + sqle);
                sqle.printStackTrace();          
        }
    }else if(operacao.equals("excluir")){
         frase = "Exclusão";
         try {
                Connection connection = PosFactory.getConnection();

                sql = "SELECT * FROM abiotico WHERE id = "+idAbiotico;
                
                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                out.println("excluindo.");

                connection.close();
            } catch (SQLException sqle) {
                out.write("OCORREU UMA PROBLEMA - FAVOR INFORMAR ADMINISTRADOR POR email@email.com.br!<br><br>Exception::<br>" + sqle);
                sqle.printStackTrace();          
        }
    }        
%>
<!DOCTYPE html>
<html>
    <head lang="pt-br">
        <meta charset="UTF-8">
        <title>Cadastro de Abiótico</title>
        <link rel="stylesheet" type="text/css" href="css/form.css"/>
    </head>
    <body>
        <% out.println(frase);%>
        <form method="post" id="cadastro" action="abiotico.jsp">
            <%// while(abiotico.next()) { %>
            <fieldset>
                <legend>Dados Abióticos</legend>
                <input type="hidden" name="idAbiotico" value="">
                <fieldset>
                    <legend></legend>
                    <p>
                        <label for="aparelhoId">Aparelho: </label>
                        <select name="nAparelho" id="aparelhoId">
                            <option value="1">1</option>
                        </select>

                        <label for="LocalColetaId">Local da Coleta: </label>
                        <select name="nLocalColeta" id="localColetaId">
                            <option value="1">1</option>
                        </select>
                        
                        <label for="DataColeta">Data da Coleta: </label><input id="cDataColeta" name="tDataColeta" type="date" value="<%out.print(abiotico.getString("data_coleta"));%>"/>
                        
                    </p>
                </fieldset>
                <fieldset>
                    <legend></legend>
                    <p>
                        <label for="cPlanc">Planc: </label><input id="cPlanc" name="tPlanc" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("planc"));%>"/>

                        <label for="cRede">Rede: </label><input id="cRede" name="tRede" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("rede"));%>"/>
                    </p>
                </fieldset>
                <fieldset>
                    <legend></legend>
                    <p>
                        <label for="cMargem">Margem: </label><input id="cMargem" name="tMargem" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("margem"));%>"/>

                        <label for="cSMF">SMF: </label><input id="cSMF" name="tSMF" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("smf"));%>"/>
                    </p>
                </fieldset>
                <fieldset>
                    <legend></legend>
                    <p>
                        <label for="cAtividade">Atividade: </label><input id="cAtividade" name="tAtividade" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("ativ"));%>"/>

                        <label for="cVento">Vento: </label><input id="cVento" name="tVento" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("vento"));%>"/>

                        <label for="cNebulosidade">Nebulosidade: </label><input id="cNebulosidade" name="tNebulosidade" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("nebulosidade"));%>"/>
                    </p>
                    <p>
                        <label for="cchuva">Chuva: </label><input id="cChuva" name="tChuva" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("chuva"));%>"/>

                        <label for="cTar">Temperatura do Ar: </label><input id="cTar" name="tTar" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("tar"));%>"/>

                        <label for="cTagua">Temperatura da Água: </label><input id="cTagua" name="tAgua" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("tagua"));%>"/>
                    </p>
                    <p>
                        <label for="cTransp">Transparência: </label><input id="cTransp" name="tTransp" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("transp"));%>"/>

                        <label for="cPh">PH: </label><input id="cPh" name="tPh" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("ph"));%>"/>

                        <label for="cCond">Condição: </label><input id="cCond" name="tCond" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("cond"));%>"/>
                    </p>
                    <p>
                        <label for="cOdmg">Oxigênio Dissolvido: </label><input id="cOdmg" name="tOdmg" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("odmg"));%>"/>

                        <label for="cVolume">Volume: </label><input id="cVolume" name="tVolume" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("volume"));%>"/>
                    </p>
                </fieldset>
                <fieldset>
                    <legend></legend>
                    <p>
                        <label for="cOvo">Ovo: </label><input id="cOvo" name="tOvo" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("ovo"));%>"/>

                        <label for="cLar1">Larva 1: </label><input id="cLar1" name="tLar1" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("lar1"));%>"/>

                        <label for="cLar2">Larva 2: </label><input id="cLar2" name="tLar2" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("lar2"));%>"/>
                    </p>
                    <p>
                        <label for="cJuve">Juvenil: </label><input id="cJuve" name="tJuve" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("juve"));%>"/>

                        <label for="cCama">Cama: </label><input id="cCama" name="tCama" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("cama"));%>"/>
                        
                        <label for="cDensiOvo">Densidade do Ovo: </label><input id="cDensiOvo" name="tDensiOvo" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("densiovo"));%>"/>
                        
                        <label for="cDensiLar">Densidade da Larva: </label><input id="cDensiLar" name="tDensiLar" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("densilar"));%>"/>
                        
                        <label for="cDensiict">Densiict: </label><input id="cDensiict" name="tDensiict" type="text" size="10" maxlength="50" value="<%out.print(abiotico.getString("densiict"));%>"/>
                    </p>
                </fieldset>
                        <%// }%>
                <p>
                    <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
                    <input class="botao-form" id="btExclui" name="botao" type="Submit" value="Excluir"/> 
                </p>
            </fieldset>
        </form>
    </body>
</html>