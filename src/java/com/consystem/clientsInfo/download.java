/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.consystem.clientsInfo;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author david_000
 */
@WebServlet(name = "download", urlPatterns = {"/download"})
public class download extends HttpServlet {

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

        try {

            //tell browser program going to return an application file
            //instead of html page
            // ServletOutputStream  outstream;
            try (InputStream in = databaseConectivity.downloadArquivo(Integer.parseInt(request.getParameter("modulo_id")), request.getParameter("arquivo"))) {
                if (request.getParameter("arquivo").endsWith(".pdf")) {
                    response.setContentType("application/pdf");

                } else {

                    response.setContentType("application/octet-stream");
                }
                response.setHeader("Content-Disposition", "attachment;filename=" + request.getParameter("arquivo"));
                response.setContentLength(in.available());
                //outstream = response.getOutputStream();
                byte[] outputByte = new byte[1];

                //copy binary contect to output stream
                while (in.read(outputByte, 0, 1) != -1) {
                    response.getOutputStream().write(outputByte, 0, 1);
                }
                in.close();
                response.getOutputStream().flush();
            }

        } catch (Exception e) {
            //out.print("<xml version='2.0'><returnType>ERROR</returnType><ErrorMessage>" + e.getMessage() + "</ErrorMessage></xml>");
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
