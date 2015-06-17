<%
	//Inicializa VariÃ¡veis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
    
    String nEquipamento = request.getParameter("nEquipamento");
    String cNome = request.getParameter("tNome");    
    String nObs = request.getParameter("tObs");
    
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

                sql = "select * from aparelho";

                PreparedStatement stmt = connection.prepareStatement(sql);

                stmt.execute();         

                mensagem = "Aparelho Cadastrado com Sucesso";

                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Ocorreu um erro ao cadastrar o aparelho. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle;
                sqle.printStackTrace();          
        } 
    }        
%>

    <form id="exportacao" method="post" action="index.jsp?url=exportacao">	
        <fieldset><legend>Exporta&ccedil;&atilde;o</legend>
	<fieldset><legend>Par&acirc;metros</legend>
        <table width="590" border="1">

          <tr>
            <td width="48"><label>Local</label></td>
            <td width="526"><select name="select">
            </select></td>
          </tr>
          <tr>
            <td><label>Projeto</label></td>
            <td><label>
              <select name="select2">
              </select>
            </label></td>
          </tr>
          <tr>
            <td><label>Período</label></td>
            <td><label>
            <input type="data" name="textfield" /> <input name="calendario" type="datetime"/>
            </label></td>
          </tr>
        </table>
  </fieldset>
  
  <fieldset><legend>Campos</legend>
      <table width="590" border="1">
        <tr>
          <td><label>
            <input type="checkbox" name="checkbox" value="checkbox" />Local</label></td>
          <td><input type="checkbox" name="nLocal" value="checkbox" />Planc </td>
        </tr>
        <tr>
          
          <td width="212"><input type="checkbox" name="nProjeto" value="checkbox" />Projeto</td>
          <td><input type="checkbox" name="nRede" value="checkbox" />Rede</td>
        </tr>
        <tr>
          <td>
            <label>
            <input type="checkbox" name="nAmbiente" value="checkbox" />Ambiente</label></td>
          <td><label>
            <input type="checkbox" name="nMargem" value="checkbox" />Margem</label></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nPonto" value="checkbox" />Ponto</td>
          <td><label>
            <input type="checkbox" name="nSmf" value="checkbox" />SMF</label></td>
        </tr>
	<tr>
		  <td><input type="checkbox" name="nData" value="checkbox" />Data</td>
		  <td><label>
            <input type="checkbox" name="nAtiv" value="checkbox" />Ativ</label>          </td>
	</tr>
	<tr>
          <td><input type="checkbox" name="nHora" value="checkbox" />Hora</td>
          <td><input type="checkbox" name="nVento" value="checkbox" />Vento</td>
	</tr>
        <tr>
          <td><input type="checkbox" name="nEsporigi" value="checkbox" />Esporigi</td>
          <td><input type="checkbox" name="nNebulosidade" value="checkbox" />Nebulosidade</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nEsppecie" value="checkbox"/>Esppecie</td>
          <td><input type="checkbox" name="nChuva" value="checkbox" />Chuva</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nEspecie" value="checkbox" />Especie</td>
          <td><label>
            <input type="checkbox" name="nTar" value="checkbox" />
            Temperatura do ar</label>          </td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nEspatual" value="checkbox" />Espatual</td>
          <td><label>
            <input type="checkbox" name="nTagua" value="checkbox" />Temperatura da &aacute;gua</label>          </td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nSpgroup" value="checkbox" />Esp&eacute;cie Agrupada</td>
          <td><label>
            <input type="checkbox" name="nProfundidade" value="checkbox" />Profundidade</label>          </td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nCtrof" value="checkbox" />Categoria Tr&oacute;fica</td>
          <td><input type="checkbox" name="nOdmg" value="checkbox" />ODMG</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nGuildaped" value="checkbox" />Guildaped</td>
          <td><input type="checkbox" name="nTransp" value="checkbox" />Transpar&ecirc;ncia</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nMigrad" value="checkbox" />Migrad</td>
          <td><label>
            <input type="checkbox" name="nPH" value="checkbox" />PH </label>          </td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nMigraped" value="checkbox" />Migraped</td>
          <td><label>
            <input type="checkbox" name="nCondutividade" value="checkbox" />Condutividade</label></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nAparelho" value="checkbox" />Aparelho</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nLt" value="checkbox" />LT</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nLs" value="checkbox" />LS</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nWt" value="checkbox" />WT</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nSexo" value="checkbox" />Sexo</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nEstadio" value="checkbox" />Est&aacute;dio </td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nWg" value="checkbox" />WG</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nRgs" value="checkbox" />RGS</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nGre" value="checkbox" />GRE</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nGri" value="checkbox" />GRI</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nGv" value="checkbox" />GV</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nWe" value="checkbox" />WE</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nWv" value="checkbox" />WV</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nOrdem" value="checkbox" />Ordem</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nFamilia" value="checkbox" />Fam&iacute;lia</td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="nGne" value="checkbox" />G&ecirc;nero/Esp&eacute;cie</td>
          <td></td>
        </tr>
        </table>
		</fieldset> 
        <p>
          <input class="botao-form" id="btEnvia" name="botao" type="Submit" value="Gerar Arquivo XSLX"/>
        </p>
        </fieldset> 
      
    </form>
                
