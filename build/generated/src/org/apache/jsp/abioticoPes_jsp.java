package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;

public final class abioticoPes_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	//Inicializa Variáveis
    String sql = "";
	String mensagem = "";
    
    //Recebe dados do Formulário
     
    String tLocalColeta = request.getParameter("tLocalColeta");  
    String tPeriodoIni = request.getParameter("tPeriodoIni");
    String tPeriodoFim = request.getParameter("tPeriodoFim");
    String tProjeto = request.getParameter("tProjeto");    
    
    String ultimoDia = "";
    
    String botao = request.getParameter("botao");
    

	//Trata a ação do Botao
    
    String acao = "";
    
    if(botao==null){
        acao = "nada";
    }else{
        acao = request.getParameter("botao");
    }
      
    Date today = new Date();  
        int mes,ano;
        ano = Integer.parseInt(tPeriodoFim.split("-")[0]);
        mes = Integer.parseInt(tPeriodoFim.split("-")[1]);
        Calendar calendar = Calendar.getInstance();  
        calendar.setTime(today);  

        calendar.set(Calendar.YEAR, ano);  
        calendar.set(Calendar.DAY_OF_MONTH, 1);  
        calendar.set(Calendar.MONTH, mes);
        calendar.add(Calendar.MONTH, 1);
        calendar.add(Calendar.DATE, -1);  

        Date lastDayOfMonth = calendar.getTime();  

        DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
       // ultimoDia=sdf.format(lastDayOfMonth);
       
    ResultSet abiotico = null;    
    
    if(acao.equals("Pesquisar")) {
        try { 
               // tPeriodoFim = ultimoDia;
                Connection connection = PosFactory.getConnection();      
                
                if((tLocalColeta.equals(""))&&((tPeriodoIni.equals("")))&&((tPeriodoFim.equals("")))&&(tProjeto.equals(""))){                     
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id order by p.nome, l.nome, a.data_coleta, a.hora";
                }                
                //Pesquisa por Projeto e Data
                if((tLocalColeta=="")&&(!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals("")))&&(tProjeto!="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquisa por Projeto e Local
                if((tLocalColeta!="")&&(tPeriodoIni.equals(""))&&(tPeriodoFim.equals(""))&&(tProjeto!="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' and local_coleta_id =  '"+tLocalColeta+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquisa por Local e data
                if((tLocalColeta!="")&&(!(!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals(""))))&&(tProjeto=="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id =  '"+tLocalColeta+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquisa por Projeto Local e data
                if((tLocalColeta!="")&&(!(!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals(""))))&&(tProjeto!="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id =  '"+tLocalColeta+"' and data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                //Pesquisa por Projeto
                if((tLocalColeta=="")&&((tPeriodoIni.equals("")))&&((tPeriodoFim.equals("")))&&(tProjeto!="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where projeto_id = '"+tProjeto+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                 //Pesquisa por Local
                if((tLocalColeta!="")&&((tPeriodoIni.equals("")))&&((tPeriodoFim.equals("")))&&(tProjeto=="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where local_coleta_id = '"+tLocalColeta+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }
                 //Pesquisa por Data
                if((tLocalColeta=="")&&((!(tPeriodoIni.equals("")))&&(!(tPeriodoFim.equals(""))))&&(tProjeto=="")){                    
                    sql = "select a.id, coalesce(p.nome, '') as projeto, coalesce(a.amostra, '') as amostra, coalesce(a.planc, '') as planc, coalesce(a.rede, '') as rede, l.nome as local, a.data_coleta, a.hora, coalesce(a.margem, '') as margem, coalesce(a.smf, '') as smf, coalesce(a.ativ, '') as ativ, coalesce(a.vento, '') as vento, coalesce(a.nebulosidade, '') as nebulosidade, coalesce(a.chuva, '') as chuva, coalesce(a.tar, '') as tar, coalesce(a.tagua, '') as tagua, coalesce(a.profundidade, '') as profundidade, coalesce(a.odmg, '') as odmg, coalesce(a.transp, '') as transparencia, coalesce(a.ph, '') as ph, coalesce(a.cond, '') as condutividade from abiotico a left join projeto p on a.projeto_id = p.id left join local_coleta l on a.local_coleta_id = l.id where data_coleta between '"+tPeriodoIni+"-01' and '"+tPeriodoFim+"' order by p.nome, l.nome, a.data_coleta, a.hora";
                }                
               
                PreparedStatement stmt = connection.prepareStatement(sql);
		out.println(sql);
                mensagem = "<table> <tr> <tdclass='td_g'><b>Id</b></td> <td class='td_g'><b>Proj</b></td> <td class='td_g'><b>Amostra</b></td> <td class='td_g'><b>Planc</b></td> <td class='td_g'><b>Rede</b></td> <td class='td_g'><b>Local</b></td> <td class='td_g'><b>Data da Coleta</b></td> <td class='td_g'><b>Hora</b></td> <td class='td_g'><b>Margem</b></td> <td class='td_g'><b>SMF</b></td> <td class='td_g'><b>Ativ</b></td> <td class='td_g'><b>Vento</b></td> <td class='td_g'><b>Nebulosidade</b></td> <td class='td_g'><b>Chuva</b></td> <td class='td_g'><b>Tar</b></td> <td class='td_g'><b>Tagua</b></td> <td class='td_g'><b>Profund</b></td> <td class='td_g'><b>ODmg</b></td><td><b>Transp</b></td> <td class='td_g'><b>PH</b></td> <td class='td_g'><b>Cond</b></td><td></td> </tr>";
                       
               
                 abiotico = stmt.executeQuery(); 
		  while(abiotico.next()) {
                    mensagem = mensagem + "<tr> <td class='td_g'>"+abiotico.getString("id")+" </td> <td class='td_g'>"+abiotico.getString("projeto")+" </td> <td class='td_g'>"+abiotico.getString("amostra")+" </td> <td class='td_g'>"+abiotico.getString("planc")+" </td> <td class='td_g'>"+abiotico.getString("rede")+" </td> <td class='td_g'> "+abiotico.getString("local")+"</td> <td class='td_g'> "+abiotico.getString("data_coleta")+"</td> <td class='td_g'>"+abiotico.getString("hora")+" </td> <td class='td_g'>"+abiotico.getString("margem")+" </td><td class='td_g'> "+abiotico.getString("smf")+"</td> <td class='td_g'>"+abiotico.getString("ativ")+" </td> <td class='td_g'>"+abiotico.getString("vento")+" </td> <td class='td_g'>"+abiotico.getString("nebulosidade")+" <td class='td_g'>"+abiotico.getString("chuva")+" <td class='td_g'>"+abiotico.getString("tar")+" </td> <td class='td_g'>"+abiotico.getString("tagua")+" </td> <td class='td_g'>"+abiotico.getString("profundidade")+" </td> <td class='td_g'>"+abiotico.getString("odmg")+" </td> <td class='td_g'>"+abiotico.getString("transparencia")+" </td> <td>"+abiotico.getString("ph")+" </td> <td class='td_g'>"+abiotico.getString("condutividade")+" </td> <td class='td_g'> <a href='index.jsp?url=abioticoAlt&idAbiotico="+abiotico.getString("id")+"'>Alterar</a>"+" | "+"<a href='index.jsp?url=abioticoDel&idAbiotico="+abiotico.getString("id")+"'>Excluir</a></p></td> </tr>";                    
                }
                mensagem = mensagem + "</table>";
                connection.close();
            } catch (SQLException sqle) { 
                //mensagem = "Preencha ao menos um campo do formulário<br/>";
                sqle.printStackTrace();
                //out.println(sql);
                out.print(sqle.toString());
                sqle.printStackTrace();   
                
        } 
    }        

      out.write("\r\n");
      out.write("\r\n");
      out.write("        <form method=\"post\" id=\"cadastro\" action=\"index.jsp?url=abioticoPes\">\r\n");
      out.write("            <fieldset>\r\n");
      out.write("                <legend>Dados Abióticos</legend>                \r\n");
      out.write("                <fieldset>\r\n");
      out.write("                    <p>\r\n");
      out.write("                        <input class=\"botao-form\" id=\"btEnvia\" name=\"botao\" type=\"Submit\" value=\"Pesquisar\"/> \r\n");
      out.write("                    </p>\r\n");
      out.write("                    <p>                        \r\n");
      out.write("                        <label for=\"tProjeto\">Projeto: </label>                         \r\n");
      out.write("                        ");

                            ResultSet proj = null;
                            try {
                                    Connection connection = PosFactory.getConnection();

                                    sql = "select id, nome from projeto order by projeto";
                                    
                                    PreparedStatement stmt = connection.prepareStatement(sql);

                                    proj = stmt.executeQuery(); 
                                    
                                    connection.close();
                                } catch (SQLException sqle) {
                                    out.println("Ocorreu um erro ao pesquisar abiótico. Entre em contato com o Administrador do Sistema. Erro: <br/>" + sqle);
                                    sqle.printStackTrace();          
                            }

                        
      out.write("\r\n");
      out.write("                        <select name=\"tProjeto\" id=\"projetoId\">\r\n");
      out.write("                        <option></option>\r\n");
      out.write("                        ");
while(proj.next()) { 
      out.write("\r\n");
      out.write("                            <option value=\"");
out.print(proj.getString("id"));
      out.write('"');
      out.write('>');
out.print(proj.getString("nome"));
      out.write("</option>\r\n");
      out.write("                        ");
}
      out.write("\r\n");
      out.write("                        </select>\r\n");
      out.write("                    </p>\r\n");
      out.write("                    <p>\r\n");
      out.write("                        <label for=\"LocalColetaId\">Local da Coleta: </label>\r\n");
      out.write("                        ");

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

                        
      out.write("\r\n");
      out.write("                        <select name=\"tLocalColeta\" id=\"localColetaId\">\r\n");
      out.write("                            <option></option>\r\n");
      out.write("                            ");
while(local.next()) { 
      out.write("\r\n");
      out.write("                                <option value=\"");
out.print(local.getString("id"));
      out.write('"');
      out.write('>');
out.print(local.getString("nome"));
      out.write(" - ");
out.print(local.getString("sigla"));
      out.write("</option>\r\n");
      out.write("                            ");
}
      out.write("\r\n");
      out.write("                        </select>\r\n");
      out.write("                    </p>\r\n");
      out.write("                    <p>                        \r\n");
      out.write("                        <label for=\"periodoIni\">Ano/Mês - início: </label><input id=\"tPeriodoIni\" name=\"tPeriodoIni\" type=\"month\"/>\r\n");
      out.write("                        <label for=\"periodoFim\">Ano/Mês - fim: </label><input id=\"tPeriodoFim\" name=\"tPeriodoFim\" type=\"month\"/>                        \r\n");
      out.write("                    </p>\r\n");
      out.write("        \r\n");
      out.write("        ");
 out.println(mensagem);
      out.write("\r\n");
      out.write("        <p>\r\n");
      out.write("            <input class=\"botao-form\" id=\"btEnvia\" name=\"botao\" type=\"Submit\" value=\"Pesquisar\"/> \r\n");
      out.write("        </p>\r\n");
      out.write("                </fieldset>                \r\n");
      out.write("        </form>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
