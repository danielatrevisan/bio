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
    String nEstadioMaturacao = request.getParameter("nEstadioMaturacao");
        
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

                sql = "insert into estadio (estadio_maturacao_id, nome, observacoes) values ('"+nEstadioMaturacao+"','"+nNome+"','"+nObs+"')";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Estádio Cadastrado com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar estádio. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>


<!DOCTYPE html>
<html>
<head lang="pt-br">
    <meta charset="UTF-8">
    <title>Cadastro de Estádio</title>
    <link rel="stylesheet" type="text/css" href="css/form.css"/>
</head>
<body>
<form method="post" id="cadastro" action="">
    <fieldset>
        <legend>Estádio</legend>
      <p>
        <label for="estadioMaturacaoId">Estádio de Maturação: </label>
        <%
            ResultSet estadioMaturacao = null;
            try {
                Connection connection = PosFactory.getConnection();

                sql = "select id, nome from estadio_maturacao";
                                    
                PreparedStatement stmt = connection.prepareStatement(sql);

                estadioMaturacao = stmt.executeQuery(); 
                                    
                connection.close();
                } catch (SQLException sqle) {
                    out.println("Ocorreu um erro ao cadastrar o estádio. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                    sqle.printStackTrace();          
            }

        %>
        <select name="nEstadioMaturacao" id="especieAgrupadaId">
        <%while(estadioMaturacao.next()) { %>
            <option value="<%out.print(estadioMaturacao.getString("id"));%>"><%out.print(estadioMaturacao.getString("nome"));%></option>
        <%}%>
        </select>          
      </p>   
      <p>
        <label for="cNome">Estádio: </label><input id="cNome" name="tNome" type="text" size="50" maxlength="255"/>
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