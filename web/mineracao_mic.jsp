<%@page import="weka.filters.supervised.attribute.AttributeSelection"%>
<%@page import="weka.attributeSelection.*"%>
<%@page import="weka.filters.*"%>
<%@page import="weka.associations.PredictiveApriori"%>
<%@page import="weka.core.Instances"%>
<%@page import="weka.associations.AprioriItemSet"%>
<%@page import="weka.core.FastVector"%>
<%@page import="weka.experiment.InstanceQuery"%>
<%
	//Inicializa Variáveis
	String sql = "";
	String mensagem = "";

	//Recebe dados do Formulário

	String checkboxValues = request.getParameter("field");

	String consulta = "select ";
	InstanceQuery query = new InstanceQuery();
	FastVector rs[];
	AprioriItemSet a;
	query.setDatabaseURL("jdbc:postgresql://localhost:5432/bio");
	query.setUsername("postgres");
	query.setPassword("admin");

	PredictiveApriori dado = new PredictiveApriori();

	if (request.getParameter("botao") != null) {

		//out.println("Consulta1 <br>" + consulta + "<br> ---------------------<br><br><br>");
		consulta = "select  l.nome as local,ap.nome as aparelho, a.smf, a.ph, coalesce(a.tagua, '') as tagua, a.cond, ab.nome as ambiente, g.nome as gne, m.nome as migraped, md.nome as migrad, gp.nome as guildaped, c.nome as ctrof, f.nome as familia, e.nome as especie from biotico b      left join abiotico a on b.abiotico_id = a.id      left join local_coleta l on a.local_coleta_id = l.id       left join aparelho ap on b.aparelho_id = ap.id      left join ambiente ab on b.ambiente_id = ab.id      left join genero_especie g on b.genero_especie_id = g.id       left join migraped m on b.migraped_id = m.id      left join migrad md on b.migrad_id = md.id      left join guildaped gp on b.guildaped_id = gp.id      left join ctrof c  on  b.ctrof_id = c.id      left join familia f on b.familia_id = f.id       left join especie e on b.especie_id = e.id";
	//	out.println("Consulta2 <br>" + consulta	+ "<br> ---------------------<br><br><br>");
		query.setQuery(consulta);
		Instances data = query.retrieveInstances();
		
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
		//out.println("Atributos antigos: " + data);
		//out.println("<br><br><br>");
		//out.println("Atributos relevantes: " + relevantData);

		dado.setOptions(weka.core.Utils.splitOptions("-N 20 -T 0 -C 0.1 -D 0.05 -U 1.0 -M 0.1 -S -1.0 -c -1"));

		//dado.buildAssociations(relevantData);
		dado.buildAssociations(data);
		//out.println("dados: "+dado.toString());

		dado.setOptions(weka.core.Utils.splitOptions("-N 20 -T 0 -C 0.1 -D 0.05 -U 1.0 -M 0.1 -S -1.0 -c -1"));
		dado.buildAssociations(data);
		//    out.println(dado.toString());

	}
%>

	<form id="mineracao" method="post" action="index.jsp?url=mineracao">
		<fieldset>
			<legend>Geração de Regras de Associação</legend>
			<fieldset>
				<legend>Campos</legend>
				<table width="449" border="1">
					<tr>
						<td width="201"><label for="nLocalColeta">Local: </label>
<%
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
 %> 
 							<select name="nLocal" id="localId">
							<option value="Todos">Todos</option>
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
					<td width="232"><input type="checkbox" name="field"	value="nAmbiente" checked="checked" /> Ambiente</td>
				</tr>
				<tr>
					<td><label> Per&iacute;odo da Coleta <select
							name="nPeriodo">
								<option value="Todos" selected="selected">Todos</option>
								<option value="Antes">Antes</option>
								<option value="Durante">Durante</option>
								<option value="Depois">Depois</option>
						</select>
					</label></td>
					<td><label> <input type="checkbox" name="field"	value="nGne" checked="checked"/> Gênero/Espécie </label></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="field" value="nAparelho" checked="checked"/> Aparelho</td>
					<td><label> <input type="checkbox" name="field"	value="nMigraped" checked="checked"/> Migraped</label></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="field" value="nSMF" checked="checked"/> SMF</td>
					<td><label> <input type="checkbox" name="field" value="nMigrad" checked="checked"/> Migrad</label></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="field"	value="nProfundidade" checked="checked"/> Profundidade</td>
					<td><label> <input type="checkbox" name="field" value="nGuildaped" checked="checked"/> Guildaped	</label></td>
				</tr>
				<tr>
					<td><label> <input type="checkbox" name="field" value="nPH" checked="checked"/> PH</label></td>
					<td><label> <input type="checkbox" name="field" value="nCTROF" checked="checked"/> CTROF	</label></td>
				</tr>
				<tr>
					<td><label> <input type="checkbox" name="field" value="nTagua" checked="checked"/> Temperatura da &aacute;gua</label></td>
					<td><label> <input type="checkbox" name="field" value="nFamilia" checked="checked"/> Fam&iacute;lia</label></td>
				</tr>
				<tr>
					<td><label> <input type="checkbox" name="field" value="nCondutividade" checked="checked" /> Condutividade	</label></td>
					<td><label> <input type="checkbox" name="field" value="nEspecie" checked="checked"/> Esp&eacute;cie </label></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</fieldset>
		<fieldset>
			<legend>Parâmetros</legend>

			<table width="449" border="1">
				<tr>
					<td><label>Métrica <select name="select">
								<option value="0">Confidence</option>
								<option value="1">Lift</option>
								<option value="2">Leverage</option>
								<option value="3">Conviction</option>
						</select>
					</label></td>
					<td><label>Confiança <input name="conf" type="text"
							value="0.9" />
					</label></td>
				</tr>
				<tr>
					<td><label>Nº de Regras <input name="regras"
							type="text" value="10" />
					</label></td>
					<td><label>Suporte M&iacute;nimo <input name="sup"
							type="text" value="0.1" />
					</label></td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<p>
				<input class="botao-form" id="btEnvia" name="botao" type="Submit"
					value="SQL" />
			</p>
		</fieldset>
</form>



<%out.println("<br> __________________________________________ <br>"+ checkboxValues + "<br> __________________________________________ <br>"); %>

<% if (request.getParameter("botao") != null) { %>
<fieldset>
	<legend>Resultado do Processamento</legend>
	<span> 
	<%
	
				String result = dado.toString();
				out.print(result.replaceAll("\n", "<br>")); 
	%>
	</span>
</fieldset>
<% } %>