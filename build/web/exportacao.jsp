<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.io.PrintWriter"%>
<%
	//Inicializa Variáveis
    String sql = "";
    String mensagem = "";
    int cont=0;
    //Recebe dados do Formul�rio
    
    String nAbiotico = request.getParameter("nAbiotico");
    String nBiotico = request.getParameter("nBiotico");
        String tPeriodoIni = request.getParameter("tPeriodoIni");
    String tPeriodoFim = request.getParameter("tPeriodoFim");
    
    
    
    String botao = request.getParameter("botao");
	
	//Trata a A��o do Bot�o
    
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
	<fieldset><legend>Per�odo</legend>
        <table width="590" border="1">

          <tr>
            <td><label for="periodoIni">Ano/M�s - in�cio: </label><input id="tPeriodoIni" name="tPeriodoIni" type="month"/></td>
            <td><label for="periodoFim">Ano/M�s - fim: </label><input id="tPeriodoFim" name="tPeriodoFim" type="month"/></td>   
          </tr>
        </table>
  </fieldset>
  
  <fieldset><legend>Dados</legend>
      <table width="590" border="1">
        <tr>
          <td><label>
            <input type="checkbox" name="nAbiotico" value="abiotico" />Abi�tico</label></td>
            <td><input type="checkbox" name="nBiotico" value="biotico"/>Bi�tico </td>
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
