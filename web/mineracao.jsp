<%@page import="weka.filters.supervised.attribute.AttributeSelection"%>
<%@page import="weka.attributeSelection.*"%>
<%@page import="weka.filters.*"%>
<%@page import="weka.filters.unsupervised.attribute.Remove"%>
<%@page import="weka.associations.Apriori"%>
<%@page import="weka.core.Instances"%>
<%@page import="weka.associations.AprioriItemSet"%>
<%@page import="weka.core.FastVector"%>
<%@page import="weka.experiment.InstanceQuery"%>
<%@page import="java.util.Arrays"%>
<%
	//Inicializa Variáveis
	String sql = "";
	String mensagem = "";

	//Recebe dados do Formulário

	String consulta = "select ";
	InstanceQuery query = new InstanceQuery();
	FastVector rs[];
	AprioriItemSet a;
	query.setDatabaseURL("jdbc:postgresql://localhost:5432/bio");
	query.setUsername("postgres");
	query.setPassword("admin");

	Apriori dado = new Apriori();
	
	//consulta = "select  l.nome as local,ap.nome as aparelho, a.smf, a.ph, coalesce(a.tagua, '') as tagua, a.cond, ab.nome as ambiente, g.nome as gne, m.nome as migraped, md.nome as migrad, gp.nome as guildaped, c.nome as ctrof, f.nome as familia, e.nome as especie from biotico b      left join abiotico a on b.abiotico_id = a.id      left join local_coleta l on a.local_coleta_id = l.id       left join aparelho ap on b.aparelho_id = ap.id      left join ambiente ab on b.ambiente_id = ab.id      left join genero_especie g on b.genero_especie_id = g.id       left join migraped m on b.migraped_id = m.id      left join migrad md on b.migrad_id = md.id      left join guildaped gp on b.guildaped_id = gp.id      left join ctrof c  on  b.ctrof_id = c.id      left join familia f on b.familia_id = f.id       left join especie e on b.especie_id = e.id";
	//consulta = "select coalesce(pj.nome, '') as projeto, coalesce(lc.nome, '') as local, coalesce(ab.nome, '') as ambiente, coalesce(pt.nome, '') as ponto, b.horario, coalesce(ep.nome, '') as especie, coalesce(ct.nome, '') as ctrof, coalesce(gp.nome) as guildaped, coalesce(md.nome) as migrad, coalesce(mp.nome) as migraped, coalesce(ap.nome, '') as aparelho, cast(b.lt as text), cast(b.ls as text), cast(b.wt as text), b.sexo, cast(b.wg as text), cast(b.rgs as text), cast(b.gre as text), cast(b.gri as text), cast(b.gv as text), cast(b.we as text), cast(b.wv as text), coalesce(fm.nome, '') as familia, coalesce(ge.nome) as gnespecie, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as atividade, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from biotico b left join genero_especie ge on b.genero_especie_id = ge.id left join migraped mp on b.migraped_id = mp.id left join migrad md on b.migrad_id = md.id left join ctrof ct on b.ctrof_id = ct.id left join guildaped gp on b.guildaped_id = gp.id left join aparelho ap on b.aparelho_id = ap.id left join ambiente ab on b.ambiente_id = ab.id left join familia fm on b.familia_id = fm.id left join ordem od on fm.ordem_id = od.id left join especie ep on b.especie_id = ep.id left join local_coleta lc on b.local_coleta_id = lc.id left join projeto pj on b.projeto_id = pj.id left join ponto pt on b.ponto_id = pt.id left join abiotico a on b.abiotico_id = a.id --where --b.local_coleta_id in (strLocal) and b.data_coleta between 'tPeriodoIni-01' and 'tPeriodoFim' and local_coleta";
	consulta = "select coalesce(pj.nome, '') as projeto, coalesce(lc.nome, '') as local, coalesce(ab.nome, '') as ambiente, coalesce(pt.nome, '') as ponto, b.horario, coalesce(ep.nome, '') as especie, coalesce(ct.nome, '') as ctrof, coalesce(gp.nome) as guildaped, coalesce(md.nome) as migrad, coalesce(mp.nome) as migraped, coalesce(ap.nome, '') as aparelho, b.lt, b.ls, b.wt, b.sexo, b.wg, b.rgs, b.gre, b.gri, b.gv, b.we, b.wv, coalesce(fm.nome, '') as familia, coalesce(ge.nome) as gnespecie, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as atividade, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from biotico b left join genero_especie ge on b.genero_especie_id = ge.id left join migraped mp on b.migraped_id = mp.id left join migrad md on b.migrad_id = md.id left join ctrof ct on b.ctrof_id = ct.id left join guildaped gp on b.guildaped_id = gp.id left join aparelho ap on b.aparelho_id = ap.id left join ambiente ab on b.ambiente_id = ab.id left join familia fm on b.familia_id = fm.id left join ordem od on fm.ordem_id = od.id left join especie ep on b.especie_id = ep.id left join local_coleta lc on b.local_coleta_id = lc.id left join projeto pj on b.projeto_id = pj.id left join ponto pt on b.ponto_id = pt.id left join abiotico a on b.abiotico_id = a.id --where --b.local_coleta_id in (strLocal) and b.data_coleta between 'tPeriodoIni-01' and 'tPeriodoFim' and local_coleta";
	query.setQuery(consulta);
	Instances data = query.retrieveInstances();

	if (request.getParameter("botao") != null) {

		//out.println(consulta);
		
//Todo esse comentario abaixo é do CfsSubsetEval
/*
		Instances relevantData = null;

		AttributeSelection filter = new AttributeSelection();
		CfsSubsetEval eval = new CfsSubsetEval();
		GreedyStepwise search = new GreedyStepwise();
		search.setSearchBackwards(true);
		filter.setEvaluator(eval);
		filter.setSearch(search);
		try {
			filter.setInputFormat(data);
			relevantData = AttributeSelection.useFilter(data, filter);
		} catch (Exception e) {
			out.println("Erro ao realizar reamostragem dados de entrada com atributos selecionados!");
			out.println("<br><br>");
			e.printStackTrace();
		}
*/
//		out.println("Atributos antigos: " + data);
// 		out.println("<br><br><br>");
// 		out.println("Atributos relevantes: " + relevantData);


	}

%>

<form id="mineracao" method="post" action="index.jsp?url=mineracao">
	<fieldset>
		<legend>Geração de Regras de Associação</legend>
		<fieldset>
			<legend>Campos</legend>
			<table width="449" border="1">
				<tr>
					<td width="201"><label for="nLocalColeta">Local: <%
						ResultSet local = null;
						try {
							Connection connection = PosFactory.getConnection();

							sql = "select id, nome, sigla from local_coleta";

							PreparedStatement stmt = connection.prepareStatement(sql);

							local = stmt.executeQuery();

							connection.close();
						} catch (SQLException sqle) {
							out.println("Ocorreu um erro ao cadastrar o exemplar. Entre em contato com o Administrador do Sistema. Erro: <br/>"
									+ sqle);
							sqle.printStackTrace();
						}
					%> <select name="nLocal" id="localId" size="5" multiple="MULTIPLE">
								<!-- alteração para multiple-->
								<!--<option value="Todos">Todos </option>-->
								<%
									while (local.next()) {
								%>
								<option value="<%out.print(local.getString("id"));%>">
									<%
										out.print(local.getString("nome"));
									%> -
									<%
										out.print(local.getString("sigla"));
									%>
								</option>

								<%
									}
								%>
						</select></td>
				</tr>
				<tr>
					<!-- alteração no tipo de entrada de data-->
					<td><label for="periodoIni">Data inicial:<br /> <input
							id="tPeriodoIni" name="tPeriodoIni" type="text"
							placeholder="dd/mm/yyyy" /></td>
					<td><label for="periodoFim">Data final:<br /> <input
							id="tPeriodoFim" name="tPeriodoFim" type="text"
							placeholder="dd/mm/yyyy" /></td>
				</tr>
				<tr>
					<!-- alteração no formulário para listar todos os campos-->
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><b>Remover os campos:</b></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<%
					String[] fields;
						
					fields = request.getParameterValues("field");
					/*	
						out.println ("<center>Selecionados: ");
						
						   if (fields != null) 
						   {
						      for (int i = 0; i < fields.length; i++) 
						      {
						         out.println ("<b>"+fields[i]+"</b>");
						      }
						   }
						   else out.println ("<b>nenhum</b>");
						   
						   out.println ("</center>");
					*/		
					int temp = 0;
					for (int i = 0; i < data.numAttributes(); i++) {
						//out.println("indice["+i+"] :" + data.attribute(i).name() + " <br>");
						if (i % 3 == 0) {
							if (temp == 0) {
								out.println("<tr>");
								temp = 1;
							} else {
								out.println("</tr>");
								temp = 0;
							}
						}
				%>
				<td><input type="checkbox" name="field" value="<%=i%>"
					<% if(fields != null && Arrays.asList(fields).contains(String.valueOf(i))){ out.println (" checked "); } %> />
					<% out.println(data.attribute(i).name()); %>
				</td>
				<%
		
			} 
				
				%>

			</table>
		</fieldset>
		<fieldset>
			<legend>Parâmetros</legend>

			<table width="449" border="1">
				<tr>
					<td>Métrica <select name="selectMetric">
							<option value="0" selected>Confidence</option>
							<option value="1">Lift</option>
							<option value="2">Leverage</option>
							<option value="3">Conviction</option>
					</select>
					</td>
					<td >Valor mínimo da métrica <input name=minMetric type="text" 
					value="<% if(request.getParameter("minMetric") == null){ out.println ("0.9"); }else out.println (request.getParameter("minMetric"));  %>" />
					</td>
				</tr>
				<tr>
					<td>Nº de Regras <input name="numRules" type="text" 
					value="<% if(request.getParameter("numRules") == null){ out.println ("10"); }else out.println (request.getParameter("numRules"));  %>" />
					</td>
					<td>Suporte M&iacute;nimo <input name="minSupport" type="text"
						value="<% if(request.getParameter("minSupport") == null){ out.println ("0.1"); }else out.println (request.getParameter("minSupport"));  %>" />
					</td>
					<td>Suporte M&aacute;ximo <input name="maxSupport" type="text"
						value="<% if(request.getParameter("maxSupport") == null){ out.println ("1.0"); }else out.println (request.getParameter("maxSupport"));  %>" />
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<p>
				<input class="botao-form" id="btEnvia" name="botao" type="Submit"
					value="Minerar" />
			</p>
		</fieldset>
</form>


<%
	if (request.getParameter("botao") != null) {
	
	String[] options = new String[2];
	
	options[0] = "-R";
	
	options[1] = "";
	
	
	// preenche options[1] com os indices a serem removidos
	if (fields != null) 
	{
	   for (int i = 0; i < fields.length; i++) 
	   {
		   options[1] += Integer.parseInt(fields[i])+1; // o indice para o remover inicia do 1
		   
	      if (i < fields.length - 1)
	    	  options[1] += ",";
	   }
	   // o filtro só é aplicado se houver campos marcados
		//out.println("options[1] " + options[1] + "<br>");
		Remove remove = new Remove();                         
		remove.setOptions(options);                           
		remove.setInputFormat(data);                          
		Instances removedData = Remove.useFilter(data, remove); 
		data = removedData;
	}

	// Inicializa parametros com valor padrão
		String metric = "0", minMetric = "0.9", numRules = "10", minSupport = "0.1", maxSupport = "1.0";

		metric = request.getParameter("selectMetric");
		minMetric = request.getParameter("minMetric");
		numRules = request.getParameter("numRules");
		minSupport = request.getParameter("minSupport");
		maxSupport = request.getParameter("maxSupport");


		//out.println("Options: -N "+numRules+" -T "+ metric+" -C "+minMetric+"  -D 0.05 -U "+maxSupport+" -M "+minSupport+" -S -1.0 -c -1");
		//dado.setOptions(weka.core.Utils.splitOptions("-N 20 -T 0 -C 0.1 -D 0.05 -U 1.0 -M 0.1 -S -1.0 -c -1"));
		dado.setOptions(weka.core.Utils.splitOptions("-N "+numRules+" -T "+ metric+" -C "+minMetric+"  -D 0.05 -U "+maxSupport+" -M "+minSupport+" -S -1.0 -c -1"));

		dado.buildAssociations(data);
		//    out.println(dado.toString());
%>

<fieldset>
	<legend>Resultado do Processamento</legend>
	<span> <%
		String result = dado.toString();
		out.print(result.replaceAll("\n", "<br>"));
%>
	</span>
</fieldset>
<%
}
%>