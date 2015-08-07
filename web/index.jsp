<%@page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.conn.PosFactory"%>

<%
	String url = request.getParameter("url");
	
	//Trata URL
    String link = "";
    if(url==null){
        link = "";
    }else{
        link = url;
    }
%>
<!DOCTYPE html>
<html>
<head lang="pt-br">
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=9" />
	<meta name="robots" content="all" />
	<title>SPVBIO</title>
    <!-- folhas de estilo -->
        <link rel="stylesheet" type="text/css" href="css/_reset.css"  />
        <link rel="stylesheet" type="text/css" href="css/_estilo.css"  />
        <link rel="stylesheet" href="css/css3menu1/style.css" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css"  />
        <style type="text/css">._css3m{display:none}</style>
    <!-- /folhas de estilo -->
</head>
<body>
	<div id="principal">
    
    	<!-- topo -->
        <div id="topo">
            <div id="imagem"><img src="imagens/topo.png" /></div>      
            <div class="inner">
                <%@include file="menu.jsp"%>        
	        	
            </div>
        </div>
    	<!-- /topo -->
        
        
        
        
        <!-- conteudo -->
        <div id="conteudo" >        	
            <!-- secundario -->
            <div id="corpo" height="400">
            	
              
            	<%if(link.equals("abioticoCad")){%>
				 	<%@include file="abioticoCad.jsp"%>
                                <%}%>
                <%if(link.equals("abioticoPes")){%>
				 	<%@include file="abioticoPes.jsp"%>
				<%}%>
                <%if(link.equals("abioticoAlt")){%> 
				 	<%@include file="abioticoAlt.jsp"%>
				<%}%>
                <%/*if(link.equals("abioticoDel")){*/%>
				 	<%/*@include file="abioticoDel.jsp"*/%>
				<%/*}*/%>
                <%if(link.equals("ambienteCad")){%>
				 	<%@include file="ambienteCad.jsp"%>
				<%}%>
                <%if(link.equals("ambientePes")){%>
				 	<%@include file="ambientePes.jsp"%>
                                <%}%>
                <%if(link.equals("ambienteAlt")){%>
				 	<%@include file="ambienteAlt.jsp"%>
				<%}%>
                <%if(link.equals("ambienteDel")){%>
				 	<%@include file="ambienteDel.jsp"%>
				<%}%>
                <%if(link.equals("aparelhoCad")){%>
				 	<%@include file="aparelhoCad.jsp"%>
				<%}%>
                <%if(link.equals("aparelhoPes")){%>
				 	<%@include file="aparelhoPes.jsp"%>
				<%}%>
                <%if(link.equals("aparelhoAlt")){%>
				 	<%@include file="aparelhoAlt.jsp"%>
				<%}%>
                <%if(link.equals("aparelhoDel")){%>
				 	<%@include file="aparelhoDel.jsp"%>
				<%}%>                
                <%if(link.equals("bioticoCad")){%>
				 	<%@include file="bioticoCad.jsp"%>
				<%}%>
                <%if(link.equals("categoria_troficaCad")){%>
				 	<%@include file="categoria_troficaCad.jsp"%>
				<%}%>
                <%if(link.equals("categoria_troficaPes")){%>
				 	<%@include file="categoria_troficaPes.jsp"%>
				<%}%>
                <%if(link.equals("categoria_troficaAlt")){%>
				 	<%@include file="categoria_troficaAlt.jsp"%>
				<%}%>
                <%if(link.equals("categoria_troficaDel")){%>
				 	<%@include file="categoria_troficaDel.jsp"%>
				<%}%>                
                <%if(link.equals("equipamentoCad")){%>
				 	<%@include file="equipamentoCad.jsp"%>
				<%}%>
                <%if(link.equals("equipamentoPes")){%>
				 	<%@include file="equipamentoPes.jsp"%>
                                <%}%>        
                <%if(link.equals("equipamentoAlt")){%>
				 	<%@include file="equipamentoAlt.jsp"%>
                                <%}%> 
                <%if(link.equals("equipamentoDel")){%>
				 	<%@include file="equipamentoDel.jsp"%>
                                <%}%>
                <%if(link.equals("espatualCad")){%>
				 	<%@include file="espatualCad.jsp"%>
				<%}%>
                <%if(link.equals("espatualPes")){%>
				 	<%@include file="espatualPes.jsp"%>
				<%}%>
                <%if(link.equals("espatualAlt")){%>
				 	<%@include file="espatualAlt.jsp"%>
				<%}%>
                <%if(link.equals("espatualDel")){%>
				 	<%@include file="espatualDel.jsp"%>
				<%}%>
                <%if(link.equals("especie_agrupadaCad")){%>
				 	<%@include file="especie_agrupadaCad.jsp"%>
				<%}%>
                <%if(link.equals("especie_agrupadaAlt")){%>
				 	<%@include file="especie_agrupadaAlt.jsp"%>
				<%}%>
                <%if(link.equals("especie_agrupadaPes")){%>
				 	<%@include file="especie_agrupadaPes.jsp"%>
				<%}%>
                <%if(link.equals("especie_agrupadaDel")){%>
				 	<%@include file="especie_agrupadaDel.jsp"%>
				<%}%>
                <%if(link.equals("especieCad")){%>
				 	<%@include file="especieCad.jsp"%>
				<%}%>
                <%if(link.equals("especiePes")){%>
				 	<%@include file="especiePes.jsp"%>
				<%}%>
                <%if(link.equals("especieAlt")){%>
				 	<%@include file="especieAlt.jsp"%>
				<%}%>
                <%if(link.equals("especieDel")){%>
				 	<%@include file="especieDel.jsp"%>
				<%}%>
                <%if(link.equals("esporigiCad")){%>
				 	<%@include file="esporigiCad.jsp"%>
				<%}%>
                <%if(link.equals("esporigiAlt")){%>
				 	<%@include file="esporigiAlt.jsp"%>
				<%}%>
                <%if(link.equals("esporigiPes")){%>
				 	<%@include file="esporigiPes.jsp"%>
				<%}%>
                <%if(link.equals("esporigiDel")){%>
				 	<%@include file="esporigiDel.jsp"%>
				<%}%>
                <%if(link.equals("esppecieCad")){%>
				 	<%@include file="esppecieCad.jsp"%>
				<%}%>
                <%if(link.equals("esppeciePes")){%>
				 	<%@include file="esppeciePes.jsp"%>
				<%}%>
                <%if(link.equals("esppecieAlt")){%>
				 	<%@include file="esppecieAlt.jsp"%>
				<%}%>
                <%if(link.equals("esppecieDel")){%>
				 	<%@include file="esppecieDel.jsp"%>
				<%}%>
                <%if(link.equals("estadio_maturacaoCad")){%>
				 	<%@include file="estadio_maturacaoCad.jsp"%>
				<%}%>
                <%if(link.equals("estadio_maturacaoPes")){%>
				 	<%@include file="estadio_maturacaoPes.jsp"%>
				<%}%>
                <%if(link.equals("estadio_maturacaoDel")){%>
				 	<%@include file="estadio_maturacaoDel.jsp"%>
				<%}%>
                <%if(link.equals("estadio_maturacaoAlt")){%>
				 	<%@include file="estadio_maturacaoAlt.jsp"%>
				<%}%>
                <%if(link.equals("estadioCad")){%>
				 	<%@include file="estadioCad.jsp"%>
				<%}%>
                <%if(link.equals("estadioPes")){%>
				 	<%@include file="estadioPes.jsp"%>
				<%}%>
                <%if(link.equals("estadioAlt")){%>
				 	<%@include file="estadioAlt.jsp"%>
				<%}%>
                <%if(link.equals("estadioDel")){%>
				 	<%@include file="estadioDel.jsp"%>
				<%}%>
                <%if(link.equals("familiaCad")){%>
				 	<%@include file="familiaCad.jsp"%>
				<%}%>
                <%if(link.equals("familiaPes")){%>
				 	<%@include file="familiaPes.jsp"%>
				<%}%>
                <%if(link.equals("familiaAlt")){%>
				 	<%@include file="familiaAlt.jsp"%>
				<%}%>
                <%if(link.equals("familiaDel")){%>
				 	<%@include file="familiaDel.jsp"%>
				<%}%>
                <%if(link.equals("genero_especieCad")){%>
				 	<%@include file="genero_especieCad.jsp"%>
				<%}%>
                <%if(link.equals("genero_especiePes")){%>
				 	<%@include file="genero_especiePes.jsp"%>
				<%}%>
                <%if(link.equals("genero_especieAlt")){%>
				 	<%@include file="genero_especieAlt.jsp"%>
				<%}%>
                <%if(link.equals("genero_especieDel")){%>
				 	<%@include file="genero_especieDel.jsp"%>
				<%}%>
                <%if(link.equals("guildapedCad")){%>
				 	<%@include file="guildapedCad.jsp"%>
				<%}%>
                <%if(link.equals("guildapedPes")){%>
				 	<%@include file="guildapedPes.jsp"%>
				<%}%>
                <%if(link.equals("guildapedAlt")){%>
				 	<%@include file="guildapedAlt.jsp"%>
				<%}%>
                <%if(link.equals("guildapedDel")){%>
				 	<%@include file="guildapedDel.jsp"%>
				<%}%>
                <%if(link.equals("local_coletaCad")){%>
				 	<%@include file="local_coletaCad.jsp"%>
				<%}%>
                <%if(link.equals("local_coletaAlt")){%>
				 	<%@include file="local_coletaAlt.jsp"%>
				<%}%>
                <%if(link.equals("local_coletaPes")){%>
				 	<%@include file="local_coletaPes.jsp"%>
				<%}%>
                <%if(link.equals("local_coletaDel")){%>
				 	<%@include file="local_coletaDel.jsp"%>
				<%}%>
                <%if(link.equals("migradCad")){%>
				 	<%@include file="migradCad.jsp"%>
				<%}%>
                <%if(link.equals("migradPes")){%>
				 	<%@include file="migradPes.jsp"%>
				<%}%>
                <%if(link.equals("migradAlt")){%>
				 	<%@include file="migradAlt.jsp"%>
				<%}%>
                <%if(link.equals("migradDel")){%>
				 	<%@include file="migradDel.jsp"%>
				<%}%>
                <%if(link.equals("migrapedCad")){%>
				 	<%@include file="migrapedCad.jsp"%>
				<%}%>
                <%if(link.equals("migrapedPes")){%>
				 	<%@include file="migrapedPes.jsp"%>
				<%}%>                
                <%if(link.equals("migrapedAlt")){%>
				 	<%@include file="migrapedAlt.jsp"%>
				<%}%>
                <%if(link.equals("migrapedDel")){%>
				 	<%@include file="migrapedDel.jsp"%>
				<%}%>
                <%if(link.equals("ordemCad")){%>
				 	<%@include file="ordemCad.jsp"%>
				<%}%>
                <%if(link.equals("ordemPes")){%>
				 	<%@include file="ordemPes.jsp"%>
				<%}%>
                <%if(link.equals("ordemAlt")){%>
				 	<%@include file="ordemAlt.jsp"%>
				<%}%>
                <%if(link.equals("ordemDel")){%>
				 	<%@include file="ordemDel.jsp"%>
				<%}%>
                <%if(link.equals("pontoCad")){%>
				 	<%@include file="pontoCad.jsp"%>
				<%}%>
                <%if(link.equals("pontoPes")){%>
				 	<%@include file="pontoPes.jsp"%>
				<%}%>
                <%if(link.equals("pontoAlt")){%>
				 	<%@include file="pontoAlt.jsp"%>
				<%}%>
                <%if(link.equals("pontoDel")){%>
				 	<%@include file="pontoDel.jsp"%>
				<%}%>
                <%if(link.equals("projetoCad")){%>
				 	<%@include file="projetoCad.jsp"%>
				<%}%>
                <%if(link.equals("projetoPes")){%>
				 	<%@include file="projetoPes.jsp"%>
				<%}%>
                <%if(link.equals("projetoAlt")){%>
				 	<%@include file="projetoAlt.jsp"%>
				<%}%>
                <%if(link.equals("projetoDel")){%>
				 	<%@include file="projetoDel.jsp"%>
				<%}%>
                <%if(link.equals("mineracao")){%>
				 	<%@include file="mineracao.jsp"%>
				<%}%>
                <%if(link.equals("exportacao")){%>
				 	<%@include file="exportacao.jsp"%>
				<%}%>
            	
            </div>
            <!-- /secundario -->
        
        </div>
        <!-- /conteudo -->
        <!-- rodape -->
        <div id="rodape">
        	<!-- foto, links, tempo, propaganda -->
        	        	
        	<!-- copy -->
        	<div class="copy">
        		<small>© Copyright 2015-2015, SPVBIO. Todos os direitos reservados.</small>
        	</div>
        	<!-- /copy -->
        </div>
        <!-- /rodape -->        

    </div>
    <script src="js/jquery-1.11.3.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/localization/datepicker-pt-BR.js"></script>
	<script src="js/jquery.maskedinput.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script src="js/localization/messages_pt_BR.min.js"></script>
	<script src="js/main.js"></script>
</body>
</html>
