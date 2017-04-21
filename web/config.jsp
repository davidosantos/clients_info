<%-- 
    Document   : config
    Created on : 29/01/2017, 21:59:13
    Author     : david_000
--%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Config</title>
        <link href="bootstrap-4/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="css/clientsInfo.css" rel="stylesheet">
        <link href="css/config.css" rel="stylesheet">
    </head>
    <body>
        <script src="js/jquery-3.1.1.js"></script>
        <script src="js/tether.js"></script>
        <script src="bootstrap-4/js/bootstrap.min.js"></script>
        <script src="js/common_script.js"></script>
        <script src="js/config.js"></script>

        <script>
            $(document).ready(function () {
            <%

                Properties configFile;
                Properties configFile_mail;

                try {
                    configFile = new Properties();

                    File filestream = new File(getServletContext().getRealPath("/config.properties"));

                    FileInputStream inFile = new FileInputStream(filestream);

                    if (filestream.exists()) {
                        configFile.load(inFile);//Read from WEB-INF/classes folder
                        inFile.close();
                        if (configFile.getProperty("configok").equals("true")) {
                            out.print("$(\"#host\").val(\'" + configFile.getProperty("host") + "\');");
                            out.print("$(\"#port\").val(\'" + configFile.getProperty("port") + "\');");
                            out.print("$(\"#" + configFile.getProperty("databasetype") + "\").prop('checked',true);");
                            out.print("$(\"#username\").val(\'" + configFile.getProperty("username") + "\');");
                            out.print("$(\"#password\").val(\'undefined\');");
                        }

                    }
                } catch (Exception e) {
                }

                try {

                    configFile_mail = new Properties();

                    File filestream_mail = new File(getServletContext().getRealPath("/mail_config.properties"));

                    FileInputStream inFile_mail = new FileInputStream(filestream_mail);

                    if (filestream_mail.exists()) {
                        configFile_mail.load(inFile_mail);//Read from WEB-INF/classes folder
                        inFile_mail.close();
                        if (configFile_mail.getProperty("configok").equals("true")) {
                            out.print("$(\"#host_email\").val(\'" + configFile_mail.getProperty("host_email") + "\');");
                            out.print("$(\"#port_email\").val(\'" + configFile_mail.getProperty("port_email") + "\');");
                            out.print("$(\"#username_email\").val(\'" + configFile_mail.getProperty("username_email") + "\');");
                            out.print("$(\"#tsl_mail\").prop('checked'," + (configFile_mail.getProperty("tsl_mail").contains("true") ? "true" : " false") + ");");
                            out.print("$(\"#password_email\").val(\'undefined\');");
                        }
                    }
                } catch (Exception e) {
                }


            %>
            });
        </script>

        <div id="container">
            <div id="spaceheader" ></div>

            <div id="config_de_email" class="site-color">
                <p style="text-align: left;">Configurações de Email:</p>
                <form action="getdata"  method="post" id="email_form">

                    <div class="form-group row">
                        <label for="host" class="col-sm-1 col-form-label">Servidor:</label>
                        <div class="col-sm-3">
                            <input id="host_email" class="form-control" name="host_email" type="text"  required>    
                        </div>
                        <label for="port" class="col-sm-1 col-form-label">Porta:</label>
                        <div class="col-xs-1">
                            <input id="port_email" class="form-control" name="port_email" type="text"  required> 
                        </div>
                    </div>


                    <div class="form-group row">
                        <div class="col-xs-3">
                            <label><input type="checkbox" id="tsl_mail" name="tsl_mail">Usa TSL</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="username" class="col-sm-1 col-form-label">Usuário:</label>
                        <div class="col-sm-3">
                            <input id="username_email" class="form-control" name="username_email" type="text" placeholder="Email" required >
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="password_email" class="col-sm-1 col-form-label">Senha:</label>
                        <div class="col-sm-3">
                            <input id="password_email" class="form-control" name="password_email" type="password" placeholder="Password" required>
                        </div>
                        <button type="button" onclick="sendMailTest()" class="btn btn-primary" style="text-align: left;">Testar</button>
                        <button type="button" onclick="sendMailSave()" class="btn btn-primary" style="text-align: left;">Salvar</button>
                    </div>
                </form>
            </div>


            <div id="config_de_dados" class="site-color" >
                <p style="text-align: left;">Configurações do Banco de Dados:</p>
                <form action="getdata" enctype="multipart/form-data"  method="post" id="banco_form" name="banco_form">


                    <div class="form-group row">
                        <label for="host" class="col-sm-1 col-form-label">Servidor:</label>
                        <div class="col-sm-3">
                            <input id="host" class="form-control" name="host" type="text" placeholder="Host" required>    
                        </div>

                    </div>

                    <div class="form-group row">
                        <label for="port" class="col-sm-1 col-form-label">Porta:</label>
                        <div class="col-sm-3">
                            <input id="port" class="form-control" name="port" type="text" placeholder="Port" required> 
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="database" class="col-sm-1 col-form-label">Banco:</label>
                        <div class="col-sm-3">
                            <input id="database" class="form-control" name="database" type="text" value="clients_info" required disabled>
                            <label class="radio-inline">
                                <input name="databasetype" id="postgres" type="radio" value="postgres">Postgres
                            </label>
                            <label class="radio-inline">
                                <input name="databasetype" id="mysql" type="radio" value="mysql" >MySql
                            </label>
                        </div>
                        <button type="button" onclick="sendBancoDeDadosCriar()" class="btn btn-primary">Criar Banco</button>
                    </div>

                    <div class="form-group row">
                        <label for="username" class="col-sm-1 col-form-label">Usuário:</label>
                        <div class="col-sm-3">
                            <input id="username" class="form-control" name="username" type="text" placeholder="User" required>
                        </div>
                        <input type="file" name="sqlfile" class="btn btn-primary">
                        <button type="button" onclick="sendBancoDeDadosScript()" class="btn btn-primary">Executar Script</button>
                    </div>
                    <div class="form-group row">
                        <label for="password" class="col-sm-1 col-form-label">Senha:</label>
                        <div class="col-sm-3">
                            <input id="password" class="form-control" name="password" type="password" placeholder="Password" required>
                        </div>
                        <button type="button" onclick="sendBancoDeDadosTest()" class="btn btn-primary">Testar</button>
                        <button type="button" onclick="sendBancoDeDadosSalvar()" class="btn btn-primary">Salvar</button>
                    </div>
                </form>
            </div>

            <div id="config_Novo_user" class="site-color" >
                <p style="text-align: left;">Criação de Novo Usuário:</p>
                <form action="getdata"  method="post" accept-charset="UTF-8" id="user_form" name="user_form">

                    <div class="form-group row">
                        <label for="username" class="col-sm-1 col-form-label">Usuário:</label>
                        <div class="col-sm-3">
                            <input class="form-control" name="username" type="text" placeholder="User" required>
                        </div>
                        <div class="col-sm-2">
                            <label for="nome_compl" class="col-form-label">Nome e Sobre Nome:</label>
                        </div>
                        <div class="col-sm-2">
                            <input type="text" id="nome_compl" name="nome_compl" class="form-control">
                        </div>
                        <div class="col-sm-1">
                            <label for="email_user" class="col-form-label">Email:</label>
                        </div>
                        <div class="col-sm-3">
                            <input type="text" id="email_user" name="email" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="password" class="col-sm-1 col-form-label">Senha:</label>
                        <div class="col-sm-3">
                            <input class="form-control" name="password" type="password" placeholder="Password" required>
                        </div>
                        <button type="button" onclick="criarUserSalvar()" class="btn btn-primary">Salvar</button>
                    </div>
                </form>
            </div>

        </div>
        <div id="PageFooter">
            <div id="wb_Image1" style="position:absolute;left:19px;top:25px;width:256px;height:50px;z-index:24;">
                <img src="images/consystem.PNG" id="Image1" alt=""></div>
        </div>
    </body>
</html>
