<%-- 
    Document   : inicial
    Created on : Jan 9, 2017, 10:10:35 PM
    Author     : David Santos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.consystem.clientsInfo.databaseConectivity"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Clients Info</title>
        <!-- Bootstrap -->
        <link href="bootstrap-4/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="css/inicial.css" rel="stylesheet">
        <link href="css/clientsInfo.css" rel="stylesheet">

    </head>
    <body>
        <script src="js/jquery-3.1.1.js"></script>
        <script src="js/tether.js"></script>
        <script src="bootstrap-4/js/bootstrap.min.js"></script>
        <script src="js/common_script.js"></script>
        <script src="js/inicial_script.js"></script>
       
        <div id="container">
            <div id="div_cliente_modulo" class="site-color border1" style="position:absolute;top:95px;width:1082px;height:318px;z-index:28;">
                <div id="wb_cliente_form" style="position:absolute;left:0px;top:0px;width:541px;height:312px;z-index:27;">
                    <form name="loginform" method="post" action="" accept-charset="UTF-8" id="cliente_form">
                        <input type="hidden" name="form_name" value="loginform">
                        <div id="wb_Text1" style="position:absolute;left:30px;top:9px;width:250px;height:16px;z-index:0;text-align:left;">
                            <span style="color:#000000;font-family:Arial;font-size:13px;">Pesquisa:</span></div>
                        <input type="text" id="pesquisa_cliente"  style="position:absolute;left:30px;top:33px;width:137px;height:25px;line-height:18px;z-index:1;" name="username" value="">
                        <input type="button" class="button_padrao" value="Editar" data-toggle="modal" data-backdrop="static" data-keyboard="false" data-target="#lightbox_InserirEdit_Cliente" onclick="consultaContato_();"
                               style="position:absolute;left:372px;top:33px;width:50px;height:25px;z-index:2;">
                        <input type="button" class="button_padrao" value="Mostrar Todos" onclick="consultaTableClientes('#table_clientes');"
                               style="position:absolute;left:424px;top:33px;width:98px;height:25px;z-index:2;">
                        <div id="wb_Text4" style="position:absolute;left:162px;top:9px;width:250px;height:16px;z-index:3;text-align:left;">
                            <span style="color:#000000;font-family:Arial;font-size:13px;">Selecionado:</span></div>
                        <input type="text" id="cliente_selecionado" class="default_inputstyle" style="position:absolute;left:163px;top:33px;width:204px;height:25px;line-height:18px;z-index:4;" name="cliente_selecionado" value="" readonly disabled autocomplete="off">

                        <div id="Html_cleintes" style="position:absolute;overflow-y:scroll;left:19px;top:65px;width:520px;height:236px;z-index:31">
                            <div class="square col-md-6">

                                <div class="table-responsive">
                                    <table id="table_clientes" class="table table-striped table-hover border1">

                                        <%
                                            try {
                                                for (String list : databaseConectivity.consultaClientesTodos()) {
                                                    out.print("<tr>");
                                                    out.print("<td><strong>" + list + "</strong></td>");
                                                    out.print("</tr>");
                                                }

                                            } catch (Exception e) {
                                                out.print("<tr>");
                                                out.print("<td><strong class=\"alert alert-danger\">" + e.getMessage() + "</strong></td>");
                                                out.print("</tr>");
                                            }

                                        %>

                                    </table>
                                </div>

                            </div>
                        </div>

                    </form>
                </div>

                <div id="wb_modulo_form" style="position:absolute;left:541px;top:0px;width:541px;height:312px;z-index:29;">
                    <form name="Form_modulo" method="post" action="modulo.jsp" accept-charset="UTF-8" id="Form_modulo">

                        <div id="wb_Text2" style="position:absolute;left:13px;top:9px;width:250px;height:16px;z-index:2;text-align:left;">
                            <span style="color:#000000;font-family:Arial;font-size:13px;">Pesquisa:</span></div>
                        <input type="text" id="pesquisa_modulo" style="position:absolute;left:13px;top:33px;width:137px;height:25px;line-height:18px;z-index:3;" value="">
                        
                        <input type="submit" class="button_padrao"
                               id="novo_modulo" name="" value="Editar"
                               style="position:absolute;left:370px;top:33px;width:50px;height:25px;z-index:5; ">
                        
                        <input type="button" class="button_padrao"
                               id="modulo_motrar_todos" name="modulo_motrar_todos" value="Mostrar Todos" 
                               onclick="consultaTableModulos('#table_modulos')"
                               style="position:absolute;left:422px;top:33px;width:98px;height:25px;z-index:5; ">
                        
                        <div id="wb_Text5" style="position:absolute;left:164px;top:9px;width:250px;height:16px;z-index:8;text-align:left;">
                            <span style="color:#000000;font-family:Arial;font-size:13px;">Selecionado:</span></div>
                        <input type="text" id="modulo_selecionado" class="default_inputstyle" style="position:absolute;left:145px;top:33px;width:220px;height:25px;line-height:18px;z-index:9;" name="modulo_selecionado" value="" readonly autocomplete="off">


                        <div id="Html_modulos" style="position:absolute;overflow-y:scroll;left:0px;top:65px;width:520px;height:236px;z-index:32">
                            <div class="square col-md-6">

                                <div class="table-responsive">
                                    <table id="table_modulos" class="table table-striped table-hover border1">
                                        <%                                            try {
                                                for (String list : databaseConectivity.consultaModulosTodos()) {
                                                    out.print("<tr>");
                                                    out.print("<td><strong>" + list + "</strong></td>");
                                                    out.print("</tr>");
                                                }

                                            } catch (Exception e) {
                                                out.print("<tr>");
                                                out.print("<td><strong class=\"alert alert-danger\">" + e.getMessage() + "</strong></td>");
                                                out.print("</tr>");
                                            }
                                        %>
                                    </table>
                                </div>

                            </div>
                        </div>

                    </form>
                </div>
            </div>

            <div id="wb_TextArt3" style="position:absolute;left:33px;top:65px;width:141px;height:22px;z-index:30;">
                <img src="images/img0003.png" id="TextArt3" alt="Clientes:" title="Clientes:" style="width:141px;height:22px;"></div>
            <div id="wb_TextArt2" style="position:absolute;left:593px;top:65px;width:141px;height:22px;z-index:28;">
                <img src="images/img0002.png" id="TextArt2" alt="Sistemas:" title="Sistemas:" style="width:141px;height:22px;"></div>




            <div id="wb_TextArt1" style="position:absolute;left:30px;top:415px;width:90px;height:22px;z-index:33;">
                <img src="images/img0004.png" id="TextArt1" alt="Info:" title="Info:" style="width:90px;height:22px;"></div>

            <div id="div_contato" class="site-color border1" style="position:absolute;top:438px;width:1082px;height:430px;z-index:34;">
                <form name="contato" method="post" action="" id="Form_contato">
                    <label for="cliente_codigo" id="Label1" style="position:absolute;left:16px;top:14px;width:76px;height:18px;line-height:18px;z-index:6;">Código</label>
                    <input type="text" id="cliente_codigo"  class="default_inputstyle" style="position:absolute;left:110px;top:14px;width:190px;height:18px;line-height:18px;z-index:7;" name="Editbox2" value="" readonly disabled>
                    <label for="cliente_nome" id="Label2" style="position:absolute;left:16px;top:47px;width:76px;height:18px;line-height:18px;z-index:8;">Nome:</label>
                    <input type="text" id="cliente_nome" class="default_inputstyle" style="position:absolute;left:110px;top:47px;width:190px;height:18px;line-height:18px;z-index:9;" name="Nome" value="" readonly disabled>
                    <label for="cliente_email" id="Label3" style="position:absolute;left:16px;top:80px;width:76px;height:18px;line-height:18px;z-index:10;">Email:</label>
                    <input type="text" id="cliente_email" class="default_inputstyle" style="position:absolute;left:110px;top:80px;width:190px;height:18px;line-height:18px;z-index:11;" name="email" value="" readonly disabled>
                    <label for="cliente_endereco" id="Label4" style="position:absolute;left:16px;top:113px;width:76px;height:18px;line-height:18px;z-index:12;">Endereço:</label>
                    <textarea name="Address" id="cliente_endereco" class="default_inputstyle" style="position:absolute;left:110px;top:113px;width:190px;height:90px;z-index:13;" rows="4" cols="29" readonly disabled></textarea>
                    <label for="cliente_cidade" id="Label5" style="position:absolute;left:16px;top:218px;width:76px;height:18px;line-height:18px;z-index:14;">Cidade:</label>
                    <input type="text" id="cliente_cidade" class="default_inputstyle" style="position:absolute;left:110px;top:218px;width:190px;height:18px;line-height:18px;z-index:15;" name="city" value="" readonly disabled>
                    <label for="cliente_estado" id="Label6" style="position:absolute;left:16px;top:251px;width:76px;height:18px;line-height:18px;z-index:16;">Estado:</label>
                    <input type="text" id="cliente_estado" class="default_inputstyle" style="position:absolute;left:110px;top:251px;width:190px;height:18px;line-height:18px;z-index:17;" name="state" value="" readonly disabled>
                    <label for="cliente_cep" id="Label7" style="position:absolute;left:16px;top:284px;width:76px;height:18px;line-height:18px;z-index:18;">Cep:</label>
                    <input type="text" id="cliente_cep" class="default_inputstyle" style="position:absolute;left:110px;top:284px;width:190px;height:18px;line-height:18px;z-index:19;" name="zip" value="" readonly disabled>
                    <label for="cliente_telefone1" id="Label8" style="position:absolute;left:16px;top:317px;width:76px;height:18px;line-height:18px;z-index:20;">Telefone:</label>
                    <input type="text" id="cliente_telefone1" class="default_inputstyle" style="position:absolute;left:110px;top:317px;width:190px;height:18px;line-height:18px;z-index:21;" name="cliente_telefone1" value="" readonly disabled>
                    <label for="cliente_telefone2" id="Label9" style="position:absolute;left:16px;top:350px;width:76px;height:18px;line-height:18px;z-index:22;">Telefone 2:</label>
                    <input type="text" id="cliente_telefone2" class="default_inputstyle" style="position:absolute;left:110px;top:350px;width:190px;height:18px;line-height:18px;z-index:23;" name="cliente_telefone2" value="" readonly disabled>
                    <label for="cliente_ramal" id="Label10" style="position:absolute;left:16px;top:383px;width:76px;height:18px;line-height:18px;z-index:24;">Ramal:</label>
                    <input type="text" id="cliente_ramal" class="default_inputstyle" style="position:absolute;left:110px;top:383px;width:190px;height:18px;line-height:18px;z-index:25;" name="cliente_ramal" value="" readonly disabled>
                    <div id="Modulo_info" class="border1" style="position:absolute;overflow:scroll; text-align: left; left:359px;top:15px;width:699px;height:396px;z-index:26;background-color:#BFE1F0;">
                    </div>
                </form>
            </div>
        </div>


        <div class="modal fade " id="lightbox_InserirEdit_Cliente">
            <div class="modal-dialog">
                <div class="modal-content site-color">

                    <div class="modal-header" id="modal_header_cliente">
                      
                    </div>
                    <div class="modal-body" style="height: 460px;" >
                        <div id="div_contato_" class="site-color border1" style="position:absolute;width:400px;height:430px;z-index:34;left: 50%;transform: translateX(-50%)">
                            <form name="contato" method="post" action="" id="Form_contato_">
                                <label for="cliente_codigo_" id="Label1_" style="position:absolute;left:16px;top:14px;width:76px;height:18px;line-height:18px;z-index:6;">Código</label>
                                <input type="hidden" id="cliente_codigo_banco_"  name="cliente_codigo_banco_">
                                <input type="text" id="cliente_codigo_" class="default_inputstyle" style="position:absolute;left:110px;top:14px;width:190px;height:18px;line-height:18px;z-index:7;" name="cliente_codigo_" value="" >
                                <label for="cliente_nome_" id="Label2_" style="position:absolute;left:16px;top:47px;width:76px;height:18px;line-height:18px;z-index:8;">Nome:</label>
                                <input type="text" id="cliente_nome_" class="default_inputstyle" style="position:absolute;left:110px;top:47px;width:190px;height:18px;line-height:18px;z-index:9;" name="cliente_nome_" value="" >
                                <label for="cliente_email_" id="Label3_" style="position:absolute;left:16px;top:80px;width:76px;height:18px;line-height:18px;z-index:10;">Email:</label>
                                <input type="text" id="cliente_email_" class="default_inputstyle" style="position:absolute;left:110px;top:80px;width:190px;height:18px;line-height:18px;z-index:11;" name="cliente_email_" value="" >
                                <label for="cliente_endereco_" id="Label4_" style="position:absolute;left:16px;top:113px;width:76px;height:18px;line-height:18px;z-index:12;">Endereço:</label>
                                <textarea id="cliente_endereco_" class="default_inputstyle" style="position:absolute;left:110px;top:113px;width:190px;height:90px;z-index:13;" rows="4" cols="29" name="cliente_endereco_" ></textarea>
                                <label for="cliente_cidade_" id="Label5_" style="position:absolute;left:16px;top:218px;width:76px;height:18px;line-height:18px;z-index:14;">Cidade:</label>
                                <input type="text" id="cliente_cidade_" class="default_inputstyle" style="position:absolute;left:110px;top:218px;width:190px;height:18px;line-height:18px;z-index:15;" name="cliente_cidade_" value="" >
                                <label for="cliente_estado_" id="Label6_" style="position:absolute;left:16px;top:251px;width:76px;height:18px;line-height:18px;z-index:16;">Estado:</label>
                                <input type="text" id="cliente_estado_" class="default_inputstyle" style="position:absolute;left:110px;top:251px;width:190px;height:18px;line-height:18px;z-index:17;" name="cliente_estado_" value="" >
                                <label for="cliente_cep_" id="Label7_" style="position:absolute;left:16px;top:284px;width:76px;height:18px;line-height:18px;z-index:18;">Cep:</label>
                                <input type="text" id="cliente_cep_" class="default_inputstyle" style="position:absolute;left:110px;top:284px;width:190px;height:18px;line-height:18px;z-index:19;" name="cliente_cep_" value="" >
                                <label for="cliente_telefone1_" id="Label8_" style="position:absolute;left:16px;top:317px;width:76px;height:18px;line-height:18px;z-index:20;">Telefone:</label>
                                <input type="text" id="cliente_telefone1_" class="default_inputstyle" style="position:absolute;left:110px;top:317px;width:190px;height:18px;line-height:18px;z-index:21;" name="cliente_telefone1_" value="" >
                                <label for="cliente_telefone2_" id="Label9_" style="position:absolute;left:16px;top:350px;width:76px;height:18px;line-height:18px;z-index:22;">Telefone 2:</label>
                                <input type="text" id="cliente_telefone2_" class="default_inputstyle" style="position:absolute;left:110px;top:350px;width:190px;height:18px;line-height:18px;z-index:23;" name="cliente_telefone2_" value="" >
                                <label for="cliente_ramal_" id="Label10_" style="position:absolute;left:16px;top:383px;width:76px;height:18px;line-height:18px;z-index:24;">Ramal:</label>
                                <input type="text" id="cliente_ramal_" class="default_inputstyle" style="position:absolute;left:110px;top:383px;width:190px;height:18px;line-height:18px;z-index:25;" name="cliente_ramal_" value="" >
                                <input type="button" class="button_padrao" value="Salvar" style="position:absolute;left:20px;top:420px;" onclick="salvarCliente();">
                            </form>
                        </div>

                    </div><!-- /.modal-body -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


        <div id="PageFooter">
            <div id="wb_Image1" style="position:absolute;left:19px;top:25px;width:256px;height:50px;z-index:25;">
                <img src="images/img0005.png" id="Image1" alt=""></div>
        </div>
    </body>
</html>
