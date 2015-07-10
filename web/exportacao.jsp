<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.io.PrintWriter"%>
<%
	//Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    int cont=0;
    //Recebe dados do Formulário
    
    String nAbiotico = request.getParameter("nAbiotico");
    String nBiotico = request.getParameter("nBiotico");    
    
    
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
    String acao = "";
%>

<form id="exportacao" method="post" action="arquivo.jsp" target="_blank">	
        <fieldset><legend>Exporta&ccedil;&atilde;o</legend>
	<fieldset><legend>Par&acirc;metros</legend>
        <table width="590" border="1">

          <tr>
            <td><label for="LocalColetaId">Local da Coleta: </label>
                        <%
                            ResultSet local = null;
                            try {
                                    Connection connection = PosFactory.getConnection();

                                    sql = "select id, nome, sigla from local_coleta order by nome";
                                    
                                    PreparedStatement stmt = connection.prepareStatement(sql);

                                    local = stmt.executeQuery();
                                    
                                    connection.close();
                                } catch (SQLException sqle) {
                                    out.println("Ocorreu um erro ao pesquisar o Abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

                        %>
                        <select name="nLocal" id="localId" size="5" multiple="MULTIPLE">
                            <option value="Todos" selected>Todos </option>
                            <%while(local.next()) { %>
                                <option value="<%out.print(local.getString("id"));%>"><%out.print(local.getString("nome"));%> - <%out.print(local.getString("sigla"));%></option>
                            <%}%>
                        </select>
            </td>
          </tr>
          <tr>
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
            <td><label for="periodoIni">Ano/Mês - início: </label><input id="tPeriodoIni" name="tPeriodoIni" type="month"/></td>
            <td><label for="periodoFim">Ano/Mês - fim: </label><input id="tPeriodoFim" name="tPeriodoFim" type="month"/></td>   
          </tr>
        </table>
  </fieldset>
  
  <fieldset><legend>Campos</legend>
      <table width="590" border="1">
        <tr>
          <td><label>
            <input type="checkbox" name="nAbiotico" value="checkbox" />Abiótico</label></td>
          <td><input type="checkbox" name="nBiotico" value="checkbox" />Biótico </td>
        </tr>        
        <tr>          
        </table>
		</fieldset> 
        <p>
          <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Exportar"/>
        </p>
        <% out.println(mensagem);%>     
        </fieldset> 
      
    </form>
        <br>            
