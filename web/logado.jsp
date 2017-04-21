<%-- 
    Document   : logado
    Created on : Jan 28, 2017, 12:38:10 PM
    Author     : David Santos
--%>

<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="com.consystem.clientsInfo.databaseConectivity"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%
    // Get session creation time.
    Date createTime = null;

    String userID = new String("userID");
    String userName = new String("userName");
    String nomeCompl = new String("nomeCompl");

    if (request.getParameter("novo_login") != null) {
        try {
            Map MapDados = databaseConectivity.validaLogin(request.getParameter("username"),
                    request.getParameter("password").hashCode());

            if (!MapDados.isEmpty()) {
                session.setAttribute(userID, MapDados.get("login_id"));
                session.setAttribute(userName, MapDados.get("nome"));
                session.setAttribute(nomeCompl, MapDados.get("nome_compl"));
            } else {
                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>Usuário ou Senha Inválido.</ErrorMessage></xml>");
                return;
            }
            out.print("<xml version='2.0'><returnType>OK</returnType><ErrorMessage></ErrorMessage></xml>");
            return;
        } catch (Exception e) {
            //<script> window.location = 'index.jsp?message=Erro%20na%20funcao%20databaseConectivity.validaLogin';</script>
            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + "</ErrorMessage></xml>");
            return;
        }
    } else if (request.getParameter("getlogged") != null) {

        // Check if this is new comer on your web page.
        try {
            if (session.isNew()) {
                out.print("<xml version='2.0'><returnType>REDIRECT</returnType><ErrorMessage>Essa é uma Nova Sessão, Efetue o Login</ErrorMessage></xml>");
                return;
            }
            createTime = new Date(session.getCreationTime());
            if (session.getAttribute(userName) == null) {
                out.print("<xml version='2.0'><returnType>REDIRECT</returnType><ErrorMessage>Usuário não Identificado, Efetue o Login</ErrorMessage></xml>");
                 return;
            }
            out.print("<xml version='2.0'><returnType>OK</returnType><ErrorMessage></ErrorMessage></xml>");
            return;

        } catch (IllegalStateException ise) {
            // it's invalid
            out.print("<xml version='2.0'><returnType>REDIRECT</returnType><ErrorMessage>Sessão Invalida, Efetue o Login.</ErrorMessage></xml>");
            return;
        }

        //userID = (String) session.getAttribute(userIDKey);
    }
%>


<div id="wb_logado">
    <nav class="navbar navbar-default navbar-center">
        <div class="container-fluid">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <p class="dropdown-toggle" data-toggle="dropdown" style="font-weight: bold;">
                        <%=session.getAttribute(nomeCompl)%>
                        <span class="caret"></span></p>
                    <div class="col-md-6 dropdown-menu site-color-fundo">
                        <div class="table-responsive">
                            <table id="table_logado" class="table table-striped table-hover border1">
                                <tr>
                                    <td><%=session.getAttribute(userName)%></td>
                                </tr>
                                <tr>
                                    <td><a href="inicial.jsp">Página Inicial</a></td>
                                </tr>
                                <tr>
                                    <td><a href="config.jsp">Configurações</a></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </nav>
</div>

