<%-- 
    Document   : getData
    Created on : Jan 14, 2017, 1:15:45 AM
    Author     : David Santos
--%>

<%@page import="java.util.Random"%>
<%@page import="com.consystem.clientsInfo.mailSerder"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.Instant"%>
<%@page import="java.sql.Date"%>
<%@page import="org.apache.derby.client.am.DateTime"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.Reader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.consystem.clientsInfo.databaseConectivity"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="com.consystem.clientsInfo.messageType"%>
<%@page import="com.consystem.clientsInfo.broadMessage"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--
<script>
    function goBack() {
        window.history.back();
    }
</script>

<script>
    function goHome() {
        alert("Configuração Invalida, ou não definida, \nVocê será direcionado para a página de configuração.");
        window.location = 'index.jsp';
    }
</script>

--%>


<%

    try {
        switch (request.getParameter("functiontype")) {
            case "config_banco_test": {

                databaseConectivity.dataBaseType tipoBase = null;

                if (request.getParameter("password").contains("undefined")) {
                    broadMessage.createMessage("informe a senha do banco de dados",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                }
                if (request.getParameter("host").equals("")) {
                    broadMessage.createMessage("<strong>Erro! </strong> host nulo",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                } else if (request.getParameter("port").equals("")) {
                    broadMessage.createMessage("<strong>Erro! </strong> Porta nulo",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;

                } else if (request.getParameter("databasetype") != null) {
                    if (request.getParameter("databasetype").contains("postgres")) {
                        tipoBase = databaseConectivity.dataBaseType.Postgres;
                    } else if (request.getParameter("databasetype").contains("mysql")) {
                        tipoBase = databaseConectivity.dataBaseType.mySql;
                    }
                } else if (request.getParameter("username").equals("")) {
                    broadMessage.createMessage("<strong>Erro! </strong> Usuário nulo",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                } else if (request.getParameter("password").equals("")) {
                    broadMessage.createMessage("<strong>Erro! </strong> Senha nulo",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                }

                if (tipoBase == null) {
                    broadMessage.createMessage("<strong>Erro! </strong> Informe um tipo de base de dados.",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                }

                databaseConectivity.connect(
                        tipoBase,
                        request.getParameter("host"), request.getParameter("port"),
                        "clients_info",
                        request.getParameter("username"),
                        request.getParameter("password"));

                broadMessage.createMessage("Conexão efetuada com sucesso.",
                        messageType.successMessage);
                out.print(broadMessage.postMessage());

            }
            break;
            case "config_banco_save": {

                if (request.getParameter("password").contains("undefined")) {
                    broadMessage.createMessage("informe a senha do banco de dados",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                }

                Properties ConfigFile = new Properties();
                ConfigFile.setProperty("host", request.getParameter("host"));
                ConfigFile.setProperty("port", request.getParameter("port"));
                ConfigFile.setProperty("database", "clients_info");
                ConfigFile.setProperty("databasetype", request.getParameter("databasetype"));
                ConfigFile.setProperty("username", request.getParameter("username"));
                ConfigFile.setProperty("password", request.getParameter("password"));
                ConfigFile.setProperty("configok", Boolean.toString(true));

                File filestream = new File(getServletContext().getRealPath("/config.properties"));
                FileOutputStream outFile = new FileOutputStream(filestream);
                ConfigFile.store(outFile, "Configurações de banco de dados.");
                outFile.close();
                broadMessage.createMessage("Configuração Salva em: "
                        + getServletContext().getRealPath("/config.properties"),
                        messageType.successMessage);
                out.print(broadMessage.postMessage());

            }
            break;
            case "getmessage": {
                if (broadMessage.isMessage) {
                    out.print(broadMessage.postMessage());
                }
            }
            break;
            case "config_banco_create": {
                databaseConectivity.dataBaseType tipoBase = null;

                if (request.getParameter("password").contains("undefined")) {
                    broadMessage.createMessage("informe a senha do banco de dados",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                }

                if (request.getParameter("host").equals("")) {
                    broadMessage.createMessage("<strong>Erro! </strong> host nulo",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                } else if (request.getParameter("port").equals("")) {
                    broadMessage.createMessage("<strong>Erro! </strong> Porta nulo",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                } else if (request.getParameter("databasetype") != null
                        && request.getParameter("databasetype").equals("")) {
                    broadMessage.createMessage("<strong>Erro! </strong> Tipo de base nulo",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                } else if (request.getParameter("username").equals("")) {
                    broadMessage.createMessage("<strong>Erro! </strong> Porta nulo",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                } else if (request.getParameter("password").equals("")) {
                    broadMessage.createMessage("<strong>Erro! </strong> Porta nulo",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                }
                File filestream = null;
                if (request.getParameter("databasetype").contains("postgres")) {
                    tipoBase = databaseConectivity.dataBaseType.Postgres;
                    filestream = new File(getServletContext().getRealPath("/postgressql.sql"));
                } else if (request.getParameter("databasetype").contains("mysql")) {
                    tipoBase = databaseConectivity.dataBaseType.mySql;
                    filestream = new File(getServletContext().getRealPath("/mysql.sql"));
                }

                File logstream = new File(getServletContext().getRealPath("/log.sql.log"));
                logstream.createNewFile();
                BufferedWriter bw;

                if (filestream.exists()) {

                    try {
                        databaseConectivity.RunSqlScript(tipoBase, filestream, logstream,
                                request.getParameter("host"),
                                request.getParameter("port"),
                                request.getParameter("username"),
                                request.getParameter("password")
                        );
                        bw = new BufferedWriter(new FileWriter(logstream, true));
                        bw.newLine();
                        bw.append("<p style=\"color:red;\"> <strong>Atualizado em: " + LocalDateTime.now() + "</strong> </p>");
                        bw.close();
                        broadMessage.createMessage("Execução com sucesso, Verifique o log em: " + logstream.getPath() + " para erros relacionados ao mySql.",
                                messageType.successMessage);
                        out.print(broadMessage.postMessage());
                    } catch (Exception e) {
                        broadMessage.createMessage("<strong>Erro! </strong>"
                                + e.getMessage(),
                                messageType.errorMessage);
                        out.print(broadMessage.postMessage());
                    }
                } else { //if not goto cofig page
                    broadMessage.createMessage("Arquivo " + filestream.getPath()
                            + " não existe.",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                }
            }
            break;

           

            case "get_sqllog": {
                File logstream = new File(getServletContext().getRealPath("/log.sql.log"));

                if (logstream.exists()) {
                    Scanner lines = new Scanner(logstream);

                    out.print("<div class=\"col-md-12\">");

                    out.print("<div class=\"table-responsive\">");
                    out.print("<table id=\"table_logs\" class=\"table table-striped table-hover\">");
                    out.print("<tbody>");
                    String line;
                    while (lines.hasNextLine()) {
                        line = lines.nextLine();
                        if (line.contains("Exception") || line.contains("error")) {
                            out.print("<tr class=\"alert alert-danger\">");
                        } else {
                            out.print("<tr>");
                        }
                        out.print("<td>" + line + "</td>");
                    }
                    out.print("</tr>");
                    out.print("</tbody>");

                    out.print("</table>");
                    out.print("</div>");

                    out.print("</div");

                }
            }
            break;

            case "mail_save": {
                try {

                    if (request.getParameter("password_email").contains("undefined")) {
                        broadMessage.createMessage("informe a senha do e-mail",
                                messageType.errorMessage);
                        out.print(broadMessage.postMessage());
                        return;
                    }

                    Properties ConfigFile = new Properties();
                    ConfigFile.setProperty("host_email", request.getParameter("host_email"));
                    ConfigFile.setProperty("port_email", request.getParameter("port_email"));
                    ConfigFile.setProperty("tsl_mail", Boolean.toString(request.getParameter("tsl_mail") != null));
                    ConfigFile.setProperty("username_email", request.getParameter("username_email"));
                    ConfigFile.setProperty("password_email", request.getParameter("password_email"));
                    ConfigFile.setProperty("configok", Boolean.toString(true));

                    File filestream = new File(getServletContext().getRealPath("/mail_config.properties"));
                    FileOutputStream outFile = new FileOutputStream(filestream);
                    ConfigFile.store(outFile, "Configurações de caixa de email.");
                    outFile.close();

                    broadMessage.createMessage("Configuração Salva com Sucesso em: " + getServletContext().getRealPath("/mail_config.properties"),
                            messageType.successMessage);
                    out.print(broadMessage.postMessage());

                } catch (Exception e) {
                    broadMessage.createMessage("Error: " + e.getMessage(),
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                }
            }
            break;

            case "mail_test": {
                try {

                    if (request.getParameter("password_email").contains("undefined")) {
                        broadMessage.createMessage("informe a senha do e-mail",
                                messageType.errorMessage);
                        out.print(broadMessage.postMessage());
                        return;
                    }

                    mailSerder.testEmail(request.getParameter("host_email"),
                            request.getParameter("port_email"),
                            request.getParameter("tsl_mail") != null,
                            request.getParameter("username_email"),
                            request.getParameter("password_email"),
                            request.getParameter("username_email"),
                            "teste", "teste");

                    broadMessage.createMessage("Email enviado com sucesso, acesse sua caixa de email " + request.getParameter("username_email") + ".",
                            messageType.successMessage);
                    out.print(broadMessage.postMessage());

                } catch (Exception e) {
                    broadMessage.createMessage("Error: " + e.getMessage(),
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                }
            }
            break;

            case "Cliente_Save": {

                if (!request.getParameter("cliente_codigo_").contains("-F")) {
                    broadMessage.createMessage("Erro: Utilize um padrão de dódigo contendo a filial.\n"
                            + "Ex.: ABAD-F1,FLOR-F2",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                }

                databaseConectivity.updateCliente(request.getParameter("cliente_codigo_"),
                        request.getParameter("cliente_nome_"),
                        request.getParameter("cliente_email_"),
                        request.getParameter("cliente_endereco_"),
                        request.getParameter("cliente_cidade_"),
                        request.getParameter("cliente_estado_"),
                        request.getParameter("cliente_cep_"),
                        request.getParameter("cliente_telefone1_"),
                        request.getParameter("cliente_telefone2_"),
                        request.getParameter("cliente_ramal_"),
                        Integer.parseInt(request.getParameter("cliente_codigo_banco_"))
                );

                broadMessage.createMessage("Salvo Com Sucesso!",
                        messageType.successMessage);
                out.print(broadMessage.postMessage());

            }
            break;
            case "Cliente_New": {

                if (!request.getParameter("cliente_codigo_").contains("-F")) {
                    broadMessage.createMessage("Erro: Utilize um padrão de dódigo contendo a filial.\n"
                            + "Ex.: ABAD-F1,FLOR-F2",
                            messageType.errorMessage);
                    out.print(broadMessage.postMessage());
                    return;
                }

                databaseConectivity.newCliente(request.getParameter("cliente_codigo_"),
                        request.getParameter("cliente_nome_"),
                        request.getParameter("cliente_email_"),
                        request.getParameter("cliente_endereco_"),
                        request.getParameter("cliente_cidade_"),
                        request.getParameter("cliente_estado_"),
                        request.getParameter("cliente_cep_"),
                        request.getParameter("cliente_telefone1_"),
                        request.getParameter("cliente_telefone2_"),
                        request.getParameter("cliente_ramal_")
                );

                broadMessage.createMessage("Salvo Com Sucesso!",
                        messageType.successMessage);
                out.print(broadMessage.postMessage());

            }
            break;
            case "Modulo_Save": {
                databaseConectivity.updateCliente(request.getParameter("cliente_codigo_"),
                        request.getParameter("cliente_nome_"),
                        request.getParameter("cliente_email_"),
                        request.getParameter("cliente_endereco_"),
                        request.getParameter("cliente_cidade_"),
                        request.getParameter("cliente_estado_"),
                        request.getParameter("cliente_cep_"),
                        request.getParameter("cliente_telefone1_"),
                        request.getParameter("cliente_telefone2_"),
                        request.getParameter("cliente_ramal_"),
                        Integer.parseInt(request.getParameter("cliente_codigo_banco_"))
                );

                broadMessage.createMessage("Salvo Com Sucesso!",
                        messageType.successMessage);
                out.print(broadMessage.postMessage());

            }
            break;
            case "Modulo_New": {

                broadMessage.createMessage("Enviar para salvarModulo!",
                        messageType.errorMessage);
                out.print(broadMessage.postMessage());

            }
            break;
            case "Modulo_Consulta": {
                try {
                    if (request.getParameter("modulo_selecionado") != null) {

                        out.print(databaseConectivity.selectModulo(request.getParameter("modulo_selecionado")));

                    } else {
                        out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + "cliente_selecionado Nulo" + "\"" + "}");
                    }
                } catch (Exception e) {
                    out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + e.getMessage() + "\"" + "}");
                }

            }
            break;
            case "Consulta_clientes_por_Modulo": {
                try {
                    if (request.getParameter("modulo_codigo_banco") != null) {

                        out.print(databaseConectivity.selectClientePorModulo(Integer.parseInt(request.getParameter("modulo_codigo_banco"))));

                    } else {
                        out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + "modulo_codigo_banco Nulo" + "\"" + "}");
                    }
                } catch (Exception e) {
                    out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + e.getMessage() + "\"" + "}");
                }

            }
            break;
            case "Consulta_Modulo_por_Cliente": {
                try {
                    if (request.getParameter("cliente_codigo") != null) {

                        out.print(databaseConectivity.selectModuloPorCliente(request.getParameter("cliente_codigo")));

                    } else {
                        out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + "cliente_codigo Nulo" + "\"" + "}");
                    }
                } catch (Exception e) {
                    out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + e.getMessage() + "\"" + "}");
                }

            }
            break;
            case "Cliente_Modulo_Save": {

                databaseConectivity.updateClientesModulo(request.getParameterValues("clientes_selecionados"),
                        Integer.parseInt(request.getParameter("modulo_codigo_banco")));
                broadMessage.createMessage("Atualização de Cadastros com Sucesso.",
                        messageType.successMessage);
                out.print(broadMessage.postMessage());

            }
            break;
            case "Cliente_Consult": {
                try {
                    if (request.getParameter("cliente_selecionado") != null) {

                        out.print(databaseConectivity.selectCliente(request.getParameter("cliente_selecionado")));

                    } else {
                        out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + "cliente_selecionado Nulo" + "\"" + "}");
                    }
                } catch (Exception e) {
                    out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + e.getMessage() + "\"" + "}");
                }
            }
            break;

            case "Consulta_campos_personalizados": {
                try {
                    if (request.getParameter("modulo_selecionado") != null) {

                        out.print("{\"returnType\":\"OK\",\"campos\":[\"teste1\",\"teste2\",\"A penera do computador que sujou!\"]}");

                    } else {
                        out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + "cliente_selecionado Nulo" + "\"" + "}");
                    }
                } catch (Exception e) {
                    out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + e.getMessage() + "\"" + "}");
                }
            }
            break;

            default: {
                broadMessage.createMessage("Error: No Function Specified",
                        messageType.errorMessage);
                out.print(broadMessage.postMessage());
            }

        }

    } catch (Exception e) {
        if (request.getParameter("functiontype") == null
                || request.getParameter("functiontype").equals("")) {
            broadMessage.createMessage("<strong> Identificador functiontype nulo!!!</strong>",
                    messageType.errorMessage);
        } else {

            broadMessage.createMessage(e.getMessage(),
                    messageType.errorMessage);
        }
        out.print(broadMessage.postMessage());
    }
%>
