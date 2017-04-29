<%-- 
    Document   : index
    Created on : 29/01/2017, 18:48:29
    Author     : david_000
--%>

<%@page import="java.net.URL"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="com.consystem.clientsInfo.databaseConectivity"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Clients Info</title>
        <link href="bootstrap-4/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="css/index.css" rel="stylesheet">
        <link href="css/clientsInfo.css" rel="stylesheet">
    </head>
    <body>
        <script src="js/jquery-3.1.1.js"></script>
        <script src="js/tether.js"></script>
        <script src="bootstrap-4/js/bootstrap.min.js"></script>
        <script src="js/common_script.js"></script>
        <script>

            $(document).ready(function () {
                $(document).keypress(function (e) {
                    if (e.which === 13) {
                        // enter pressed
                        efetuaLogin('#loginform');
                    }
                });
            });


            function configerror() {
                alert("Configuração Invalida, ou não definida, \nVocê será direcionado para a página de configuração.");
               efetuaLoginGererico();
            }
        </script>
        <%
            if (request.getParameter("message") != null) {
                out.print("<script>$(document).ready(function () { quickErrorMessage('" + request.getParameter("message") + "')});</script>");
            }

            Properties configFile;
            databaseConectivity.dataBaseType tipoBase;
            tipoBase = null;
            try {
                configFile = new Properties();

                File filestream = new File(getServletContext().getRealPath("/config.properties"));
                FileInputStream inFile = new FileInputStream(filestream);

                if (filestream.exists()) {
                    configFile.load(inFile);//Read from WEB-INF/classes folder

                    if (!configFile.getProperty("configok").equals("true")) {
                        out.print("<script>configerror();</script>");
                    }
                    if (configFile.getProperty("databasetype") != null) {
                        if (configFile.getProperty("databasetype").contains("postgres")) {
                            tipoBase = databaseConectivity.dataBaseType.Postgres;
                        } else if (configFile.getProperty("databasetype").contains("mysql")) {
                            tipoBase = databaseConectivity.dataBaseType.mySql;
                        }
                    }
                    inFile.close();
                    databaseConectivity.connect(tipoBase,
                            configFile.getProperty("host"),
                            configFile.getProperty("port"),
                            configFile.getProperty("database"),
                            configFile.getProperty("username"),
                            configFile.getProperty("password"));

                } else { //if not goto cofig page
                    out.print("<script>configerror();</script>");
                }

            } catch (Exception e) {
        %> 
        <div class="alert alert-danger" role="alert">
            <strong>Erro! </strong> <%= e.getMessage()%> 
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
            }
        %>



        <div id="container">
            <div id="wb_TextArt1" style="position:absolute;left:66px;top:141px;width:839px;height:204px;z-index:14;">
                <img src="images/img0001.png" id="TextArt1" alt="Clients Info" title="Clients Info" style="width:839px;height:204px;"></div>
            <div id="wb_loginform" style="position:absolute;left:129px;top:401px;width:480px;height:212px;z-index:15;">
                <form name="loginform" method="post" action="logado.jsp" accept-charset="UTF-8" id="loginform">
                    <input type="hidden" name="novo_login" value="yes">
                    <label for="username" id="Label1" style="position:absolute;left:6px;top:6px;width:460px;height:18px;line-height:18px;z-index:0;">Log In</label>
                    <label for="username" id="Label2" style="position:absolute;left:6px;top:40px;width:460px;height:18px;line-height:18px;z-index:1;">User Name</label>
                    <input type="text" id="username" style="position:absolute;left:7px;top:59px;width:456px;height:18px;line-height:18px;z-index:2;" name="username" required>
                    <label for="password" id="Label3" style="position:absolute;left:6px;top:98px;width:460px;height:18px;line-height:18px;z-index:3;">Password</label>
                    <input type="password" id="password" style="position:absolute;left:7px;top:117px;width:456px;height:18px;line-height:18px;z-index:4;" name="password" required>

                    <input type="button" id="login" class="button_padrao" name="login" onclick="efetuaLogin('#loginform');" value="Log In" style="position:absolute;left:209px;top:182px;width:63px;height:24px;z-index:7;">
                </form>
            </div>
            <div id="wb_forgotpassword" style="position:absolute;left:631px;top:401px;width:208px;height:212px;z-index:16;">
                <form name="forgotpassword" method="post" action="" accept-charset="UTF-8" id="forgotpassword">
                    <input type="hidden" name="form_name" value="forgotpasswordform">
                    <label for="email" id="Label5" style="position:absolute;left:6px;top:6px;width:188px;height:18px;line-height:18px;z-index:8;">Esqueceu a senha?</label>
                    <label for="email" id="Label6" style="position:absolute;left:6px;top:40px;width:188px;height:18px;line-height:18px;z-index:9;">Email</label>
                    <input type="text" id="email" style="position:absolute;left:7px;top:59px;width:184px;height:18px;line-height:18px;z-index:10;" name="email" value="">
                    <input type="button" class="button_padrao" onclick="enviaSenha('#forgotpassword');" value="Enviar" style="position:absolute;left:70px;top:182px;width:69px;height:24px;z-index:11;">
                </form>
            </div>
        </div>
        <div id="PageFooter">
            <div id="wb_Image1" style="position:absolute;left:19px;top:25px;width:256px;height:50px;z-index:12;">
                <img src="images/img0006.png" id="Image1" alt=""></div>
        </div>
    </body>
</html>
