/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.consystem.clientsInfo;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

@MultipartConfig(maxFileSize = 0xffffffff)

/**
 *
 * @author david_000
 */
@WebServlet(name = "getdata", urlPatterns = {"/getdata"})
public class getdata extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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
                            broadMessage.createMessage("Erro: Utilize um padrão de código contendo a filial.\n"
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
                            broadMessage.createMessage("Erro: Utilize um padrão de código contendo a filial.\n"
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

                                out.print(databaseConectivity.selectModulo(request.getParameter("modulo_selecionado"), request.getParameter("cliente_selecionado")
                                        == null ? "" : request.getParameter("cliente_selecionado")));

                            } else {
                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "modulo_selecionado Nulo" + "</ErrorMessage></xml>");
                            }
                        } catch (Exception e) {
                            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + "</ErrorMessage></xml>");
                        }

                    }
                    break;
                    case "Upload_Arquivo": {
                        try {
                            if (request.getParameter("modulo_id") == null) {

                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "modulo_id Nulo" + "</ErrorMessage></xml>");
                            }
                            if (request.getPart("arquivo") == null) {

                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "Arquivo Nulo" + "</ErrorMessage></xml>");
                            }
                            if (request.getPart("nome_arquivo") == null) {

                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "nome_arquivo Nulo" + "</ErrorMessage></xml>");
                            }

                            databaseConectivity.updateModuloUpload(Integer.parseInt(request.getParameter("modulo_id")),
                                    request.getParameter("nome_arquivo"),
                                    request.getPart("arquivo").getInputStream());
                            out.print("<xml version='2.0'><returnType>OK</returnType><ErrorMessage>Arquivo Inserido com sucesso.</ErrorMessage></xml>");

                        } catch (Exception e) {
                            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + "</ErrorMessage></xml>");
                        }

                    }
                    break;
                    case "config_create_user": {
                        try {
                            if (request.getParameter("username").equals("")) {

                                broadMessage.createMessage("Deve Ser Informado o Usuário!",
                                        messageType.errorMessage);

                                out.print(broadMessage.postMessage());
                                return;
                            }
                            if (request.getParameter("nome_compl").equals("")) {

                                broadMessage.createMessage("O Nome Completo é Obrigatório!",
                                        messageType.errorMessage);

                                out.print(broadMessage.postMessage());
                                return;
                            }
                            if (request.getParameter("password").equals("")) {

                                broadMessage.createMessage("A Senha é Obrigatória!",
                                        messageType.errorMessage);

                                out.print(broadMessage.postMessage());
                                return;
                            }
                            if (request.getParameter("email").equals("")) {

                                broadMessage.createMessage("O Email é Obrigatório!",
                                        messageType.errorMessage);

                                out.print(broadMessage.postMessage());
                                return;
                            }

                            databaseConectivity.criarUsuario(request.getParameter("username"),
                                    request.getParameter("password").hashCode(),
                                    request.getParameter("nome_compl"),
                                    request.getParameter("email"));

                            broadMessage.createMessage("Usuário Criado com Sucesso!",
                                    messageType.successMessage);

                            out.print(broadMessage.postMessage());

                        } catch (Exception e) {
                            broadMessage.createMessage("Erro: Funçao: config_create_user: " + e.getMessage(),
                                    messageType.errorMessage);

                            out.print(broadMessage.postMessage());
                        }

                    }
                    break;
                    case "Remover_Arquivo": {
                        try {
                            if (request.getParameter("modulo_id") == null) {

                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "modulo_id Nulo" + "</ErrorMessage></xml>");
                            }
                            if (request.getParameter("arquivo") == null) {

                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "Arquivo Nulo" + "</ErrorMessage></xml>");
                            }

                            databaseConectivity.updateModuloremover(Integer.parseInt(request.getParameter("modulo_id")),
                                    request.getParameter("arquivo"));
                            out.print("<xml version='2.0'><returnType>OK</returnType><ErrorMessage>Arquivo Removido com sucesso.</ErrorMessage></xml>");

                        } catch (Exception e) {
                            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + "</ErrorMessage></xml>");
                        }

                    }
                    break;
                    case "Download_Arquivo": { //corrompe os arquivo, mudado para download.java
                        try {
                            if (request.getParameter("modulo_id") == null) {

                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "modulo_id Nulo" + "</ErrorMessage></xml>");
                            }
                            if (request.getParameter("arquivo") == null) {

                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "Arquivo Nulo" + "</ErrorMessage></xml>");
                            }

                            //tell browser program going to return an application file
                            //instead of html page
                            response.setContentType("application/octet-stream");
                            response.setHeader("Content-Disposition", "attachment;filename=" + request.getParameter("arquivo"));

                            // ServletOutputStream  outstream;
                            try (InputStream in = databaseConectivity.downloadArquivo(Integer.parseInt(request.getParameter("modulo_id")), request.getParameter("arquivo"))) {
                                //outstream = response.getOutputStream();
                                byte[] outputByte = new byte[4096];

                                //copy binary contect to output stream
                                while (in.read(outputByte, 0, 4096) != -1) {
                                    response.getOutputStream().write(outputByte, 0, 4096);
                                    response.getOutputStream().flush();
                                }
                                in.close();
                            }

                        } catch (Exception e) {
                            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + "</ErrorMessage></xml>");
                        }

                    }
                    break;
                    case "Consulta_clientes_por_Modulo": {
                        try {
                            if (request.getParameter("modulo_nome") != null) {

                                out.print(databaseConectivity.selectClientePorModulo(request.getParameter("modulo_nome")));

                            } else {
                                out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + "modulo_nome Nulo" + "\"" + "}");
                            }
                        } catch (Exception e) {
                            out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + e.getMessage() + "\"" + "}");
                        }

                    }
                    break;
                    case "Consulta_clientes_por_Modulo_id": {
                        try {
                            if (request.getParameter("modulo_codigo_banco") != null) {

                                out.print(databaseConectivity.selectClientePorModulo(Integer.parseInt(request.getParameter("modulo_codigo_banco"))));

                            } else {
                                out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + "modulo_nome Nulo" + "\"" + "}");
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
                    case "Perfil_Consult": {
                        try {
                            out.print(databaseConectivity.selectLogin(Integer.parseInt(request.getParameter("login_id"))));

                        } catch (Exception e) {
                            out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"Error: Perfil_Consult= " + request.getParameter("login_id") + " " + e.getMessage() + "\"" + "}");
                        }
                    }
                    break;

                    case "Perfil_Save": {
                        try {
                            if (request.getParameter("perfil_login") == null && request.getParameter("perfil_login").equals("")) {
                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "Erro Função: Perfil_Save 'perfil_login' Deve Ser Informado</ErrorMessage></xml>");
                                return;
                            }
                            if (request.getParameter("perfil_nome_compl") == null || request.getParameter("perfil_nome_compl").equals("")) {
                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "Erro Função: Perfil_Save 'perfil_nome_compl' Deve Ser Informado</ErrorMessage></xml>");
                                return;
                            }
                            if (request.getParameter("perfil_email") == null || request.getParameter("perfil_email").equals("")) {
                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "Erro Função: Perfil_Save 'perfil_email' Deve Ser Informado</ErrorMessage></xml>");
                                return;
                            }
                            if (request.getParameter("perfil_codigo_banco") == null || request.getParameter("perfil_codigo_banco").equals("")) {
                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "Erro Função: Perfil_Save 'perfil_codigo_banco' Deve Ser Informado</ErrorMessage></xml>");
                                return;
                            }

                            databaseConectivity.updatePerfil(request.getParameter("perfil_login"),
                                    request.getParameter("perfil_nome_compl"),
                                    request.getParameter("perfil_email"),
                                    Integer.parseInt(request.getParameter("perfil_codigo_banco")));

                            if (!request.getParameter("perfil_senha_nova").equals("")) {
                                if (request.getParameter("perfil_senha").equals("")) {
                                    out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>Para a Atualização da Senha, Deve Informar a Senha Atual.</ErrorMessage></xml>");
                                    return;
                                }

                                try {
                                    Map MapDados = databaseConectivity.validaLogin(Integer.parseInt(request.getParameter("perfil_codigo_banco")),
                                            request.getParameter("perfil_senha").hashCode());
                                    if (MapDados.isEmpty()) {
                                        out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>Senha Atual Inválido.</ErrorMessage></xml>");
                                    } else {
                                        
                                        databaseConectivity.updateSenha(Integer.parseInt(request.getParameter("perfil_codigo_banco")),
                                                request.getParameter("perfil_senha_nova").hashCode());
                                        
                                        out.print("<xml version='2.0'><returnType>OK</returnType><ErrorMessage>Perfil Salvo e Senha Atualizada.</ErrorMessage></xml>");
                                    }
                                    
                                } catch (Exception e) {
                                    out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "Erro Função: Perfil_Save " + e.getMessage() + "</ErrorMessage></xml>");
                                }

                            } else {

                                out.print("<xml version='1.0'><returnType>OK</returnType><ErrorMessage>Perfil Salvo Com Sucesso.</ErrorMessage></xml>");
                            }
                        } catch (Exception e) {
                            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "Erro Função: Perfil_Save " + e.getMessage() + "</ErrorMessage></xml>");
                        }
                    }
                    break;

                    case "Consulta_clientes": {
                        try {
                            out.print(databaseConectivity.selectClientes());
                        } catch (Exception e) {
                            out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + e.getMessage() + "\"" + "}");
                        }
                    }
                    break;
                    case "Consulta_Modulos": {
                        try {
                            out.print(databaseConectivity.selectModulos());
                        } catch (Exception e) {
                            out.print("{\"returnType\":\"ERROR\",\"ErrorMessage\":" + "\"" + e.getMessage() + "\"" + "}");
                        }
                    }
                    break;

                    case "Consulta_campos_personalizados": {
                        try {
                            if (request.getParameter("modulo_id") != null) {

                                out.print(databaseConectivity.selectCampoPersonalizados(Integer.parseInt(request.getParameter("modulo_id"))));

                            } else {

                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "modulo_codigo_banco Nulo, Função: Consulta_campos_personalizados" + "</ErrorMessage></xml>");
                            }
                        } catch (Exception e) {
                            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + " Função: Consulta_campos_personalizados, modulo_id =" + request.getParameter("modulo_id") + "</ErrorMessage></xml>");
                        }
                    }
                    break;
                    case "Remove_Client": {
                        try {
                            if (request.getParameter("modulo_id") != null || request.getParameter("cliente_selecionado") != null) {

                                databaseConectivity.deleteClienteFromModulo(request.getParameter("cliente_selecionado"), Integer.parseInt(request.getParameter("modulo_id")));
                                out.print("<xml version='2.0'><returnType>OK</returnType><ErrorMessage>Removido com sucesso</ErrorMessage></xml>");
                            } else {

                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>modulo_codigo_banco ou cliente_selecionado Nulo, Função: Remove_Client</ErrorMessage></xml>");
                            }
                        } catch (Exception e) {
                            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + " Função: Remove_Client, modulo_id =" + request.getParameter("modulo_id") + ""
                                    + "cliente_selecionado =" + request.getParameter("cliente_selecionado") + "</ErrorMessage></xml>");
                        }
                    }
                    break;
                    case "Save_campos_personalizados": {
                        try {
                            if (request.getParameter("inserir_campo_nome") != null) {
                                if (request.getParameter("inserir_campo_nome").contains(":")
                                        || request.getParameter("inserir_campo_nome").contains(" ")
                                        || request.getParameter("inserir_campo_nome").contains("ç")
                                        || request.getParameter("inserir_campo_nome").contains("é")
                                        || request.getParameter("inserir_campo_nome").contains("õ")
                                        || request.getParameter("inserir_campo_nome").contains("ã")
                                        || request.getParameter("inserir_campo_nome").contains("ô")) {
                                    out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "O Nome do Campos deve segur o padrão: Titulo. Sem espaço,ç,ã,õ,ô,é." + "</ErrorMessage></xml>");
                                } else {
                                    databaseConectivity.newCampoPersonalizado(request.getParameter("inserir_campo_nome"), Integer.parseInt(request.getParameter("modulo_id")));
                                    out.print("<xml version='2.0'><returnType>OK</returnType><ErrorMessage>Campo " + request.getParameter("inserir_campo_nome") + " Inserido com sucesso.</ErrorMessage></xml>");
                                }

                            } else {

                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + "inserir_campo_nome Nulo, Função: inserir_campo_nome" + "</ErrorMessage></xml>");
                            }
                        } catch (Exception e) {
                            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + " Função: inserir_campo_nome, inserir_campo_nome =" + request.getParameter("inserir_campo_nome") + "</ErrorMessage></xml>");
                        }
                    }
                    break;

                    case "save_Client_config": {
                        try {
                            if (request.getParameter("modulo_id") == null) {
                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage> Função: save_Client_config, modulo_id = nulo </ErrorMessage></xml>");
                                return;
                            }
                            if (request.getParameter("cliente_selecionado") == null) {
                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage> Função: save_Client_config, cliente_selecionado = nulo </ErrorMessage></xml>");
                                return;
                            }
                            if (request.getParameter("config_text") == null) {
                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage> Função: save_Client_config, config_text = nulo </ErrorMessage></xml>");
                                return;
                            }

                            databaseConectivity.updateConfigClient(request.getParameter("cliente_selecionado"), Integer.parseInt(request.getParameter("modulo_id")), request.getParameter("config_text"));
                            out.print("<xml version='2.0'><returnType>OK</returnType><ErrorMessage>Config. Salva com sucesso para o cliente " + request.getParameter("cliente_selecionado") + ".</ErrorMessage></xml>");
                        } catch (Exception e) {
                            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + " Função: save_Client_config, config_text =" + request.getParameter("config_text") + "</ErrorMessage></xml>");
                        }
                    }
                    break;
                    case "consulta_Client_config": {
                        try {
                            if (request.getParameter("modulo_id") == null) {
                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage> Função: consulta_Client_config, modulo_id = nulo </ErrorMessage></xml>");
                                return;
                            }
                            if (request.getParameter("cliente_selecionado") == null) {
                                out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage> Função: consulta_Client_config, cliente_selecionado = nulo </ErrorMessage></xml>");
                                return;
                            }

                            out.print(databaseConectivity.selectConfigClient(request.getParameter("cliente_selecionado"), Integer.parseInt(request.getParameter("modulo_id"))));

                        } catch (Exception e) {
                            out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + " Função: consulta_Client_config, cliente_selecionado =" + request.getParameter("cliente_selecionado") + "</ErrorMessage></xml>");
                        }
                    }
                    break;

                    case "envia_senha": {
                        try {
                            if (request.getParameter("email").equals("")) {
                                throw new Exception("O Email deve ser informado!");
                            }

                            Map login = databaseConectivity.getLogin_id(request.getParameter("email"));

                            if (!login.isEmpty()) {

                                Random randNumber = new Random();

                                String novaSenha = " ";
                                char abc[] = "bcdfghjlmnpqrstvxzkwy".toCharArray();

                                for (int i = 0; i < 5; i++) {
                                    novaSenha = novaSenha.concat(String.valueOf(abc[randNumber.nextInt(abc.length)]));
                                }
                                novaSenha = novaSenha.trim();

                                Properties configFile;

                                configFile = new Properties();

                                File filestream = new File(getServletContext().getRealPath("/mail_config.properties"));
                                FileInputStream inFile = new FileInputStream(filestream);

                                if (filestream.exists()) {
                                    configFile.load(inFile);//Read from WEB-INF/classes folder

                                    if (!configFile.getProperty("configok").equals("true")) {
                                        throw new Exception("Arquivo de configurações de email não configurado corretamente, entre em contato com o administrador.");
                                    }

                                    inFile.close();

                                    mailSerder.testEmail(configFile.getProperty("host_email"),
                                            configFile.getProperty("port_email"),
                                            configFile.getProperty("tsl_mail").equals("true"),
                                            configFile.getProperty("username_email"),
                                            configFile.getProperty("password_email"),
                                            request.getParameter("email"), "Clients Info - Nova Senha",
                                            "Prezado, " + login.get("nome_compl").toString() + ", \n"
                                            + "Conforme solicitado, estamos lhe enviando uma nova senha para acesso ao site Clients Info. \n\n"
                                            + "Login: " + login.get("nome").toString() + "\n"
                                            + "Senha: " + novaSenha + "\n\n"
                                            + "Att. Consystem \n");

                                } else { //if not goto cofig page
                                    throw new Exception("Arquivo de configurações não en contrado! Entre em contaot com o administrador do site!");
                                }
                                databaseConectivity.updateSenha(Integer.parseInt(login.get("login_id").toString()), novaSenha.hashCode());
                                broadMessage.createMessage("Solicitação de senha con sucesso para " + request.getParameter("email"),
                                        messageType.successMessage);
                                out.print(broadMessage.postMessage());
                            } else {
                                throw new Exception("Email informado " + request.getParameter("email") + " Não Cadastrado.");
                            }

                        } catch (Exception e) {

                            broadMessage.createMessage("Erro na Função envia_senha: " + e.getMessage(),
                                    messageType.errorMessage);
                            out.print(broadMessage.postMessage());
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
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
