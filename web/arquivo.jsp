<%@page import="java.sql.SQLException"%>
<%@page import="conn.PosFactory"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.lang.String"%>
<%@page import="java.io.PrintWriter"%>
<%
    //Inicializa VariÃ¡veis
    String sql = "";
    String mensagem = "";
    int cont=0;
    int n=0;
    //Recebe dados do Formulário
    
    String nAbiotico = request.getParameter("nAbiotico");
    String nBiotico = request.getParameter("nBiotico");    
    
    
    String botao = request.getParameter("botao");
	
	//Trata a Ação do Botão
    
    String acao = "Exportar";
 
    
    ResultSet exp = null;
    ResultSetMetaData rsMetaData=null;
    if(acao.equals("Exportar")) {
        try {
                         
                if ((nAbiotico == null) && (nBiotico != null))
                {
                    sql =  "select b.id as biotico_id, coalesce(pj.nome, '') as projeto, coalesce(lc.nome, '') as local, coalesce(ab.nome, '') as ambiente, coalesce(pt.nome, '') as ponto, b.data_coleta, b.horario, b.numero, coalesce(eg.nome, '') as esporigi, coalesce(epp.nome, '') as esppecie,"
                    +	   "coalesce(ep.nome, '') as especie, coalesce(esp.nome, '') as espatual, coalesce(ea.nome, '') as especie_agrupada, coalesce(ct.nome, '') as ctrof, coalesce(gp.nome) as guildaped, coalesce(md.nome) as migrad, coalesce(mp.nome) as migraped, "
                    +      "coalesce(ap.nome, '') as aparelho, coalesce(eq.nome, '') as apar, b.lt, b.ls, b.wt, b.sexo, coalesce(et.nome, '') as estadio, coalesce(em.nome, '') as estad, b.wg, b.rgs, b.gre, b.gri, b.gv, b.we, b.wv, coalesce(od.nome, '') as ordem, coalesce(fm.nome, '') as familia, coalesce(ge.nome) as gnespecie, b.abiotico_id "
                    +      "from biotico b "
                    +      "left join genero_especie ge on b.genero_especie_id = ge.id left join migraped mp on b.migraped_id = mp.id left join migrad md on b.migrad_id = md.id left join ctrof ct on b.ctrof_id = ct.id "
                    +      "left join guildaped gp on b.guildaped_id = gp.id left join aparelho ap on b.aparelho_id = ap.id left join equipamento eq on ap.equipamento_id = eq.id left join estadio et on b.estadio_id = et.id left join estadio_maturacao em on et.estadio_maturacao_id = em.id left join ambiente ab on b.ambiente_id = ab.id left join esporigi eg on b.esporigi_id = eg.id "
                    +      "left join familia fm on b.familia_id = fm.id left join ordem od on fm.ordem_id = od.id left join especie ep on b.especie_id = ep.id left join especie_agrupada ea on ep.especie_agrupada_id = ea.id left join esppecie epp on b.esppecie_id = epp.id "
                    +      "left join espatual esp on b.espatual_id = esp.id left join ponto pt on b.ponto_id = pt.id left join local_coleta lc on b.local_coleta_id = lc.id left join projeto pj on b.projeto_id = pj.id "
                    +      "order by b.id";
                }
                if ((nAbiotico != null) && (nBiotico == null))
                {
                    sql = "select a.id as abiotico_id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id order by a.id";
                }
                if ((nAbiotico != null) && (nBiotico != null))
                {
                sql =  "select b.id as biotico_id, coalesce(pj.nome, '') as projeto, coalesce(lc.nome, '') as local, coalesce(ab.nome, '') as ambiente, coalesce(pt.nome, '') as ponto, b.data_coleta, b.horario, b.numero, coalesce(eg.nome, '') as esporigi, coalesce(epp.nome, '') as esppecie,"
                    +	   "coalesce(ep.nome, '') as especie, coalesce(esp.nome, '') as espatual, coalesce(ea.nome, '') as especie_agrupada, coalesce(ct.nome, '') as ctrof, coalesce(gp.nome) as guildaped, coalesce(md.nome) as migrad, coalesce(mp.nome) as migraped, "
                    +      "coalesce(ap.nome, '') as aparelho, coalesce(eq.nome, '') as apar, b.lt, b.ls, b.wt, b.sexo, coalesce(et.nome, '') as estadio, coalesce(em.nome, '') as estad, b.wg, b.rgs, b.gre, b.gri, b.gv, b.we, b.wv, coalesce(od.nome, '') as ordem, coalesce(fm.nome, '') as familia, coalesce(ge.nome) as gnespecie, "
                    +      "b.abiotico_id, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, coalesce(a.margem, '') as margem, coalesce(a.smf, ''), coalesce(a.ativ, '') as atividade, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, "
                    +      "coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade "
                    +      "from biotico b "
                    +      "left join genero_especie ge on b.genero_especie_id = ge.id left join migraped mp on b.migraped_id = mp.id left join migrad md on b.migrad_id = md.id left join ctrof ct on b.ctrof_id = ct.id "
                    +      "left join guildaped gp on b.guildaped_id = gp.id left join aparelho ap on b.aparelho_id = ap.id left join equipamento eq on ap.equipamento_id = eq.id left join estadio et on b.estadio_id = et.id left join estadio_maturacao em on et.estadio_maturacao_id = em.id left join ambiente ab on b.ambiente_id = ab.id left join esporigi eg on b.esporigi_id = eg.id "
                    +      "left join familia fm on b.familia_id = fm.id left join ordem od on fm.ordem_id = od.id left join especie ep on b.especie_id = ep.id left join especie_agrupada ea on ep.especie_agrupada_id = ea.id left join esppecie epp on b.esppecie_id = epp.id "
                    +      "left join espatual esp on b.espatual_id = esp.id left join ponto pt on b.ponto_id = pt.id left join local_coleta lc on b.local_coleta_id = lc.id left join projeto pj on b.projeto_id = pj.id left join abiotico a on b.abiotico_id = a.id "
                    +      "order by b.id";;
                }
                 if ((nAbiotico == null) && (nBiotico == null))
                {
                    mensagem = "Preencha ao menos um campo do formulário<br/>";
                }
            Connection connection = PosFactory.getConnection(); 
            PreparedStatement stmt = connection.prepareStatement(sql);
            exp = stmt.executeQuery();
            rsMetaData = exp.getMetaData();
            exp.close();
            exp = stmt.executeQuery();
                
            String nomeArquivo="file.csv";
            response.setContentType("application/csv");
            response.setHeader( "Content-Disposition", "attachment;filename="+nomeArquivo);
            PrintWriter w = response.getWriter();

    
            for (int i = 1; i <= rsMetaData.getColumnCount(); i++) {
           //    w.write(rsMetaData.getColumnName(i));
            //   w.write(";");
                 out.print(rsMetaData.getColumnName(i)+";");
               

           }
          //  w.println();
            out.println();
            n= rsMetaData.getColumnCount();
         while(exp.next()) {
   //         out.print(rsMetaData.getColumnCount());
        //     w.write(exp.getString("amostra"));
             
            for (int i = 1; i <= n; i++) {
                out.print(exp.getString(i)+";");
          
          //            w.write(exp.getString(20));
      //  w.write(exp.getObject(i).toString());
      // w.write(";");
        
        }
           
    cont++;    
    out.println("");
  //  w.println();
    }
   
    //w.prinln(GenerateCsv.generateCsvFile(users));
/*
        w.flush();
        w.close();
*/
                connection.close();
            } catch (SQLException sqle) {
                mensagem = "Preencha ao menos um campo do formulário<br/>";
                sqle.printStackTrace();
                out.print(sqle.toString());
            
        } 
        
        
    }         


%>