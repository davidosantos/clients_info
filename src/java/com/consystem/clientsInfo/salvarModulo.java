/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.consystem.clientsInfo;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@MultipartConfig(maxFileSize = 16177215)

/**
 *
 * @author david_000
 */
public class salvarModulo extends HttpServlet {

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
                    case "Modulo_New":
                        if (request.getParameter("modulo_nome").equals("")) {
                            broadMessage.createMessage("Informe um Nome para o Modulo!",
                                    messageType.errorMessage);
                            out.print(broadMessage.postMessage(true));
                            return;
                        }
                        databaseConectivity.newModulo(
                                request.getParameter("modulo_nome"),
                                request.getParameter("modulo_servidor"),
                                request.getParameter("modulo_pasta"),
                                request.getParameter("modulo_arquivos"),
                                request.getParameter("modulo_configs"),
                                request.getParameter("modulo_prerequisitos"),
                                request.getParameter("modulo_crontabstring"),
                                request.getParameter("modulo_sircp")
                        );
                        broadMessage.createMessage("Salvo Com Sucesso!",
                                messageType.successMessage);
                        out.print(broadMessage.postMessage());
                        break;
                    case "Modulo_Save":
                        if (request.getParameter("modulo_nome").equals("")) {
                            broadMessage.createMessage("Informe um Nome para o Modulo!",
                                    messageType.errorMessage);
                            out.print(broadMessage.postMessage(true));
                            return;
                        }
                        databaseConectivity.updateModulo(
                                request.getParameter("modulo_nome"),
                                request.getParameter("modulo_servidor"),
                                request.getParameter("modulo_pasta"),
                                request.getParameter("modulo_arquivos"),
                                request.getParameter("modulo_configs"),
                                request.getParameter("modulo_prerequisitos"),
                                request.getParameter("modulo_crontabstring"),
                                request.getParameter("modulo_sircp"),
                                Integer.parseInt(request.getParameter("modulo_codigo_banco"))
                        );

                        if (request.getParameterValues("arrayNomesCampos") != null) {
                            // $(textarea).text($(ret).find($(nome).text() + '_data').text());
                            for (String campo : request.getParameterValues("arrayNomesCampos")) {
                                databaseConectivity.updateCampoPersonalizado(campo,
                                        Integer.parseInt(request.getParameter("modulo_codigo_banco")),
                                        request.getParameter(campo));
                            }
                        }

                        broadMessage.createMessage("Salvo Com Sucesso!",
                                messageType.successMessage);
                        out.print(broadMessage.postMessage());
                        break;
                    case "config_banco_script": {
                        //<editor-fold defaultstate="collapsed" desc="config_banco_script">
                        databaseConectivity.dataBaseType tipoBase = null;
                        //request.getPart("layout1") == null ? null : request.getPart("layout1").getInputStream()
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
                        if (request.getPart("sqlfile") == null) {
                            broadMessage.createMessage("<strong>Erro! </strong> Arquivo SQL nao anexado!",
                                    messageType.errorMessage);
                            out.print(broadMessage.postMessage());
                            return;
                        }
                        Random rand = new Random();
                        File filestream = new File(getServletContext().getRealPath("/sqltmp" + rand.nextInt() + ".sql"));
                        filestream.createNewFile();
                        if (request.getPart("sqlfile").getInputStream().available() > 0) {
                            FileOutputStream writeToFile = new FileOutputStream(filestream);
                            InputStream input = request.getPart("sqlfile").getInputStream();

                            byte[] buffer = new byte[1];

                            //read from is to buffer
                            while ((input.read(buffer)) != -1) {
                                writeToFile.write(buffer);
                            }
                            writeToFile.close();
                        }
                        if (request.getParameter("databasetype").contains("postgres")) {
                            tipoBase = databaseConectivity.dataBaseType.Postgres;
                        } else if (request.getParameter("databasetype").contains("mysql")) {
                            tipoBase = databaseConectivity.dataBaseType.mySql;
                        }

                        File logstream = new File(getServletContext().getRealPath("/log.sql.log"));
                        logstream.createNewFile();
                        BufferedWriter bw;

                        if (filestream.exists()) {

                            try {
                                databaseConectivity.RunSqlScript_updateDatabase(tipoBase, filestream, logstream,
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
//</editor-fold>
                    break;
                    default:
                        throw new Exception("Unknown functiontype: " + request.getParameter("functiontype"));
                }

            } catch (Exception ex) {
                if (request.getParameter("functiontype") == null
                        || request.getParameter("functiontype").equals("")) {
                    broadMessage.createMessage("<strong> Identificador functiontype nulo!!!</strong>",
                            messageType.errorMessage);
                } else {

                    broadMessage.createMessage(ex.getMessage() + " Function:  " + request.getParameter("functiontype"),
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
        return "This page were necessary in oroder to save modulo, because is has files in it.";
    }// </editor-fold>

}
