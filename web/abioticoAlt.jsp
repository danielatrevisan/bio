<%

	//Inicializa VariÃ¡veis
    String sql = "";
	String mensagem = "";
    
    //Recebe Dados do FormulÃ¡rio    

    String idAbiotico = request.getParameter("idAbiotico");
    
    String nAmostra = request.getParameter("nAmostra");
    String nProjeto = request.getParameter("nProjeto");    
    String nLocal = request.getParameter("nLocal");
    String nDataColeta = request.getParameter("nDataColeta");
    String tHora = request.getParameter("tHora");    
    String tPlanc = request.getParameter("tPlanc");
    String tRede = request.getParameter("tRede");
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
    
    
    String botao = request.getParameter("botao");
    Connection connection = null;
	//Trata aÃ§Ã£o do BotÃ£o
    String acao = "";
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
        
    if(acao.equals("Salvar")) {
        try {
                connection = PosFactory.getConnection();
                   
                sql = "UPDATE abiotico "
                        + " SET amostra='"+nAmostra+"',local_coleta_id='"+nLocal+"', planc='"+tPlanc+"', data_coleta='"+nDataColeta+"', hora='"+tHora+"', margem='"+tMargem+"', smf='"+tSMF+"', ativ='"+tAtividade+"', vento='"+tVento+"', nebulosidade='"+tNebulosidade+"', chuva='"+tChuva+"', "
                        + "     tar='"+tTar+"', tagua='"+tAgua+"', transp='"+tTransp+"', ph='"+tPh+"', cond='"+tCond+"', odmg='"+tOdmg+"', rede='"+tRede+"'"
                        + " WHERE id="+idAbiotico;

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Abiótico alterado com sucesso.";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao alterar o Abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        }
    }

			ResultSet abiotico = null;
			try {
					connection = PosFactory.getConnection();
		
					sql = "SELECT * FROM abiotico WHERE id = "+idAbiotico;
					
					PreparedStatement stmt = connection.prepareStatement(sql);
		
					abiotico = stmt.executeQuery();      
		
					connection.close();
				} catch (SQLException sqle) {
					out.write("Ocorreu um erro - Entre em contato com o Administrador do Sistema: email@email.com.br!<br><br>Exception::<br>" + sqle);
					sqle.printStackTrace();          
			}
		abiotico.next(); 
                
%>
<form method="post" id="cadastro" action="index.jsp?url=abioticoAlt">            
    <fieldset>
        <legend>Dados Abióticos</legend>
        <p>
            <input id="idAbiotico" name="idAbiotico" type="hidden" value="<% out.print(idAbiotico); %>" />
            <fieldset>
                <table width="0" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="150"><label for="cAmostra">Amostra: </label><input id="cNome" name="nAmostra" type="text" value="<%out.print(abiotico.getString("amostra")); %>" size="30" maxlength="255"/></td>
                    <td width="150">
                
        <label for="projetoId">Projeto: </label>
        <%
            ResultSet projeto = null;
            try {
                connection = PosFactory.getConnection();

                sql = "select id, nome from projeto order by nome";

                PreparedStatement stmt = connection.prepareStatement(sql);

                projeto = stmt.executeQuery(); 

                connection.close();
                } catch (SQLException sqle) {
                  out.println("Ocorreu um erro ao alterar abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                  sqle.printStackTrace();          
                }
        %>
        <select name="nProjeto" id="projetoId">
            <%while(projeto.next()) { %>
                <%if(abiotico.getString("projeto_id").equals(projeto.getString("id")))
                {%>
                <option value="<% out.print(projeto.getString("id"));%>" selected><%out.print(projeto.getString("nome"));%></option>
                <% }else {%>
                <option value="<%out.print(projeto.getString("id"));%>"><%out.print(projeto.getString("nome"));%></option>
            <%}}%>
        </select>
        </td>                    
                  </tr>
                  <tr>
                    <td><label for="localId">Local: </label>
        <%
            ResultSet local = null;
            try {
                connection = PosFactory.getConnection();

                sql = "select id, nome from local_coleta order by nome";

                PreparedStatement stmt = connection.prepareStatement(sql);

                local = stmt.executeQuery(); 

                connection.close();
                } catch (SQLException sqle) {
                  out.println("Ocorreu um erro ao alterar abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                  sqle.printStackTrace();          
                }
        %>
        <select name="nLocal" id="localId">        
            <%while(local.next()) { %>        
                <%if(abiotico.getString("local_coleta_id").equals(local.getString("id")))
                {%>
                <option value="<% out.print(local.getString("id"));%>" selected><%out.print(local.getString("nome"));%></option>
                <% }else {%>
                <option value="<%out.print(local.getString("id"));%>"><%out.print(local.getString("nome"));%></option>
            <%}}%>
        </select>
        </td>
        <td><label for="DataColeta">Data: </label><input type="date" id="nDataColeta" name="nDataColeta" value="<%out.print(abiotico.getString("data_coleta"));%>"/></td>    
        <td><label for="tHora">Hora: </label><input id="tHora" name="tHora" type="text" size="10" value="<%out.print(abiotico.getString("hora")); %>" maxlength="50"/></td> 
        </table>
        </fieldset>
        <fieldset>
        <table>
        <td><label for="tPlanc">Planc: </label><input id="tPlanc" name="tPlanc" type="text" size="10" value="<%out.print(abiotico.getString("planc")); %>" maxlength="50"/></td> 
        <td><td width="150"><label for="tRede">Rede: </label><input id="tRede" name="tRede" type="text" size="10" value="<%out.print(abiotico.getString("rede")); %>" maxlength="50"/></td> 
        </table>
        </fieldset>
        <fieldset>
                    <table width="0" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="150"><label for="tMargem">Margem: </label><input id="tMargem" name="tMargem" type="text" size="10" value="<%out.print(abiotico.getString("margem")); %>" maxlength="50"/></td>
                        <td width="150"><label for="tSMF">SMF: </label><input id="tSMF" name="tSMF" type="text" size="10" value="<%out.print(abiotico.getString("smf")); %>" maxlength="50"/></td>
                        <td width="150"><label for="tProfundidade">Profundidade: </label><input id="tProfundidade" name="tProfundidade" type="text" size="10" value="<%out.print(abiotico.getString("profundidade")); %>" maxlength="50"/></td>
                      </tr>
                    </table>
                </fieldset>
                <fieldset>
                    <table width="0" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="150"><label for="tAtividade">Atividade: </label><input id="tAtividade" name="tAtividade" type="text" size="10" value="<%out.print(abiotico.getString("ativ")); %>" maxlength="50"/></td>
                        <td width="150"><label for="tVento">Vento: </label><input id="tVento" name="tVento" type="text" size="10" value="<%out.print(abiotico.getString("vento")); %>" maxlength="50"/></td>
                        <td width="150"><label for="tNebulosidade">Nebulosidade: </label><input id="tNebulosidade" name="tNebulosidade" type="text" size="10" value="<%out.print(abiotico.getString("nebulosidade")); %>" maxlength="50"/></td>
                      </tr>
                      <tr>
                        <td width="150"><label for="tchuva">Chuva: </label><input id="tChuva" name="tChuva" type="text" size="10" value="<%out.print(abiotico.getString("chuva")); %>" maxlength="50"/></td>
                        <td width="150"><label for="tTar">Temperatura do Ar: </label><input id="tTar" name="tTar" type="text" size="3" value="<%out.print(abiotico.getString("tar")); %>" maxlength="50"/></td>
                        <td width="150"><label for="tTagua">Temperatura da Água: </label><input id="tTagua" name="tAgua" type="text" size="3" value="<%out.print(abiotico.getString("tagua")); %>" maxlength="50"/></td>
                      </tr>
                      <tr>
                        <td width="150"><label for="tTransp">Transparência: </label><input id="tTransp" name="tTransp" type="text" size="10" value="<%out.print(abiotico.getString("transp")); %>" maxlength="50"/></td>
                        <td width="150"><label for="tPh">PH: </label><input id="tPh" name="tPh" type="text" size="10" value="<%out.print(abiotico.getString("ph")); %>" maxlength="50"/></td>
                        <td width="150"><label for="tCond">Condutividade: </label><input id="tCond" name="tCond" type="text" size="9" value="<%out.print(abiotico.getString("cond")); %>" maxlength="50"/></td>
                        <td width="150"><label for="tOdmg">ODMG: </label><input id="tCond" name="tOdmg" type="text" size="9" value="<%out.print(abiotico.getString("odmg")); %>" maxlength="50"/></td>
                      </tr>                      
                    </table>
                </fieldset>    
      
    <% out.println(mensagem);%>
    <p>
        <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Salvar"/> 
    </p>
    </fieldset>
</form>