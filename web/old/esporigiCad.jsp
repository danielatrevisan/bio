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
     
    String nNome = request.getParameter("tNome");
    String nObs = request.getParameter("tObs");
    String nEspecieAgrupada = request.getParameter("nEspecieAgrupada");
    
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

                sql = "insert into esporigi (especie_agrupada_id, nome, observacoes) values ('"+nEspecieAgrupada+"','"+nNome+"','"+nObs+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Esporigi Cadastrada com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar esporigi. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>


<!DOCTYPE html>
<html>
<head lang="pt-br">
    <meta charset="UTF-8">
    <title>Cadastro de Esporigi</title>
    <link rel="stylesheet" type="text/css" href="css/form.css"/>
</head>
<body>
<form method="post" id="cadastro" action="esporigiCad.jsp">
    <fieldset>
        <legend>Esporigi</legend>
      <p>
        <label for="especieAgrupadaId">Espécie Agrupada: </label>
        <%
                            ResultSet especieAgrupada = null;
                            try {
                                    Connection connection = PosFactory.getConnection();

                                    sql = "select id, nome from especie_agrupada";
                                    
                                    PreparedStatement stmt = connection.prepareStatement(sql);

                                    especieAgrupada = stmt.executeQuery(); 
                                    
                                    connection.close();
                                } catch (SQLException sqle) {
                                    out.println("Ocorreu um erro ao cadastrar a esporigi. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

        %>
        <select name="nEspecieAgrupada" id="especieAgrupadaId">
        <%while(especieAgrupada.next()) { %>
            <option value="<%out.print(especieAgrupada.getString("id"));%>"><%out.print(especieAgrupada.getString("nome"));%></option>
        <%}%>
        </select>                
      </p>   
      <p>
        <label for="cNome">Esporigi: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
      </p>
      <p>
        <label for="cObs">Observações: </label><textarea id="cObs" name="tObs"  rows="10" columns="50" maxlength="1000"> </textarea>
      </p>
      
    <% out.println(mensagem);%>
    <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>  
    </fieldset>
</form>
</body>
</html>