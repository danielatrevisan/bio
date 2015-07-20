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
        String tPeriodoIni = request.getParameter("tPeriodoIni");
    String tPeriodoFim = request.getParameter("tPeriodoFim");
    
    
    
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
    String acao = "";
%>
<script lang="JavaScript">
    function validateForm() {
    var Abio = document.forms["exportacao"]["nAbiotico"].checked;
    var Bio = document.forms["exportacao"]["nBiotico"].checked;
    
    if (!Abio && !Bio) {
        alert("Selecione Uma base");
        return false;
    }
}
</script>
<form name="exportacao" id="exportacao" method="post" action="arquivo.jsp" target="_blank" onsubmit="return validateForm()">	
        <fieldset><legend>Exporta&ccedil;&atilde;o</legend>
	<fieldset><legend>Período</legend>
        <table width="590" border="1">

          <tr>
            <td><label for="periodoIni">Ano/Mês - início: </label><input id="tPeriodoIni" name="tPeriodoIni" type="month"/></td>
            <td><label for="periodoFim">Ano/Mês - fim: </label><input id="tPeriodoFim" name="tPeriodoFim" type="month"/></td>   
          </tr>
        </table>
  </fieldset>
  
  <fieldset><legend>Dados</legend>
      <table width="590" border="1">
        <tr>
          <td><label>
            <input type="checkbox" name="nAbiotico" value="abiotico" />Abiótico</label></td>
            <td><input type="checkbox" name="nBiotico" value="biotico"/>Biótico </td>
        </tr>        
        <tr>          
        </table>
		</fieldset> 
        <p>
            <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Exportar" />
        </p>
        <% out.println(mensagem);%>     
        </fieldset> 
      
    </form>
        <br>            
