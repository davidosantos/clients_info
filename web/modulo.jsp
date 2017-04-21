<%-- 
    Document   : novo_modulo
    Created on : Jan 14, 2017, 10:45:09 PM
    Author     : David Santos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.consystem.clientsInfo.databaseConectivity"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Modulo</title>       
        <!-- Bootstrap -->
        <link href="bootstrap-4/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="css/novo_modulo.css" rel="stylesheet">
        <link href="css/clientsInfo.css" rel="stylesheet">



    </head>
    <body>

        <script src="js/jquery-3.1.1.js"></script>
        <script src="js/tether.js"></script>
        <script src="bootstrap-4/js/bootstrap.min.js"></script>
        <script src="js/common_script.js"></script>
        <script src="js/novo_modulo_script.js"></script>



        <%
            if (request.getParameter("modulo_selecionado") != null && !(request.getParameter("modulo_selecionado").equals(""))) {
        %>
        <script>
            $(document).ready(function () {
                $("#modulo_nome").val("<%= request.getParameter("modulo_selecionado")%>");
                addTableControlINE("#Form_modulo", "editing");
                carregaModulo();
            });
        </script>
        <%
        } else {
        %>
        <script>
            $(document).ready(function () {
                addTableControlINE("#Form_modulo", "new");
            });
        </script>
        <%
            }
        %>



        <div id="container">

            <div id="wb_modulo" style="position:absolute;top:75px;width:1082px;height:793px;z-index:26;">
                <form name="Form_modulo" method="post" action="salvarModulo" enctype="multipart/form-data" id="Form_modulo">
                    <div id="config_modulo" style="position: absolute;width: 400px;height: 656px;overflow-y: scroll;z-index:-1;">
                        <input type="hidden" id="modulo_codigo_banco"  name="modulo_codigo_banco">
                        <label for="modulo_nome" id="Label1" style="position:absolute;left:9px;top:14px;width:154px;height:18px;line-height:18px;z-index:0;">Nome do Modulo:</label>
                        <input type="text" class="site-color-fundo" id="modulo_nome" style="position:absolute;left:181px;top:14px;width:190px;height:18px;line-height:18px;z-index:1;" name="modulo_nome" value="">
                        <label for="modulo_servidor" id="Label2" style="position:absolute;left:9px;top:47px;width:154px;height:18px;line-height:18px;z-index:2;">Servidor/IP de Instalação:</label>
                        <input type="text" class="site-color-fundo" id="modulo_servidor" style="position:absolute;left:181px;top:47px;width:190px;height:18px;line-height:18px;z-index:3;" name="modulo_servidor" value="">
                        <label for="modulo_pasta" id="Label3" style="position:absolute;left:9px;top:80px;width:154px;height:18px;line-height:18px;z-index:4;">Pasta de instalação:</label>
                        <input type="text" class="site-color-fundo" id="modulo_pasta" style="position:absolute;left:181px;top:80px;width:190px;height:18px;line-height:18px;z-index:5;" name="modulo_pasta" value="">
                        <label for="modulo_arquivos" id="Label4" style="position:absolute;left:9px;top:113px;width:154px;height:18px;line-height:18px;z-index:6;">Arquivos Necessários:</label>
                        <textarea class="site-color-fundo" id="modulo_arquivos" style="position:absolute;left:181px;top:113px;width:190px;height:80px;z-index:7;" rows="4" cols="29" name="modulo_arquivos"></textarea>
                        <label for="modulo_configs" id="Label5" style="position:absolute;left:9px;top:218px;width:154px;height:18px;line-height:18px;z-index:8;">Arquivos de Configurações:</label>
                        <textarea class="site-color-fundo" id="modulo_configs" style="position:absolute;left:181px;top:218px;width:190px;height:80px;z-index:9;" rows="4" cols="29" name="modulo_configs"></textarea>
                        <label for="modulo_prerequisitos" id="Label6" style="position:absolute;left:9px;top:323px;width:154px;height:18px;line-height:18px;z-index:10;">Pre-requsitos:</label>
                        <textarea  class="site-color-fundo" id="modulo_prerequisitos" style="position:absolute;left:181px;top:323px;width:190px;height:80px;z-index:11;" rows="4" cols="29" name="modulo_prerequisitos"></textarea>
                        <label for="modulo_crontabstring" id="Label8" style="position:absolute;left:9px;top:428px;width:154px;height:18px;line-height:18px;z-index:14;">Configuração no Crontab:</label>
                        <textarea  id="modulo_crontabstring" class="site-color-fundo" style="position:absolute;left:181px;top:428px;width:190px;height:80px;z-index:15;" rows="4" cols="29" name="modulo_crontabstring"></textarea>
                        <label for="modulo_sircp" id="Label9" style="position:absolute;left:9px;top:533px;width:154px;height:18px;line-height:18px;z-index:16;">Programas SIRCPLUS:</label>
                        <textarea id="modulo_sircp" class="site-color-fundo" style="position:absolute;left:181px;top:533px;width:190px;height:80px;z-index:17;" rows="4" cols="29" name="modulo_sircp"></textarea>
                    </div>

                    <div id="wb_Text1" style="position:absolute;left:425px;top:9px;width:250px;height:16px;z-index:0;text-align:left;">
                        <span style="color:#000000;font-family:Arial;font-size:13px;">Pesquisa:</span></div>
                    <input type="text" id="pesquisa_cliente"  style="position:absolute;left:425px;top:33px;width:137px;height:25px;line-height:18px;z-index:1;" name="username" value="">
                    <div id="wb_Text4" style="position:absolute;left:545px;top:9px;width:250px;height:16px;z-index:3;text-align:left;">
                        <span style="color:#000000;font-family:Arial;font-size:13px;">Selecionado:</span></div>
                    <input type="text" id="cliente_selecionado" class="default_inputstyle" style="position:absolute;left:545px;top:33px;width:199px;height:25px;line-height:18px;z-index:4;" name="cliente_selecionado" value="" readonly disabled autocomplete="off">



                    <div class="square col-md-8" style="overflow-y: scroll;position:absolute;left:425px;top:70px;width:318px;height:580px;z-index:24">

                        <div class="table-responsive">
                            <table id="table_clientes_modulo" class="table table-striped table-hover border1">
                                <tr>
                                    <th>Clientes:</th>
                                </tr>
                            </table>
                        </div>
                    </div>



                    <textarea name="config_cliente_text" id="config_cliente_text" class="site-color-fundo"  style="position:absolute;left:786px;top:40px;width:236px;height:300px;z-index:20;" rows="25" cols="37"></textarea>
                    <div id="wb_Text2" style="position:absolute;left:786px;top:19px;width:200px;height:16px;z-index:21;text-align:left;">
                        <span style="color:#000000;font-family:Arial;font-size:13px;">Config. especifica Cliente:</span></div>

                    <div id="arquivos" class="site-color-fundo table-responsive" style="position:absolute;left:786px;top:385px;width:236px;height:264px;z-index:27;overflow-y: scroll">

                        <table id="table_arquivos" class="table table-striped table-hover border1">

                            
                        </table>

                    </div>
                        
                    <div class="progress" style="position:absolute;left:785px;top:688px;width:280px;height:24px;line-height:21px;z-index:26;">
                        <div class="progress-bar bg-success" id="progressbar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">
                            0%
                        </div>
                    </div>

                    <label for="arquivo1" id="Label10" style="position:absolute;left:785px;top:360px;width:154px;height:18px;line-height:18px;z-index:27;">Arquivos:</label>
                    <input type="file" id="arquivo1"  style="position:absolute;left:785px;top:658px;width:280px;height:24px;line-height:21px;z-index:26;overflow: hidden;" name="arquivo">


                    <input type="button" class="button_padrao" name="" value="Novo" onclick="novoModulo();" style="position:absolute;left:24px;top:751px;width:96px;height:25px;z-index:25;">
                    <input type="button" class="button_padrao" value="Inserir Campo" onclick="mostrarModalInserirCampos();" style="position:absolute;left:24px;top:658px;width:96px;height:25px;z-index:22;">
                    <input type="button" class="button_padrao" id="remover_cliente"  value="Remover Cli." style="position:absolute;left:425px;top:658px;width:96px;height:25px;z-index:22;">
                    <input type="button" class="button_padrao" name="" onclick="mostrarModalSelecionarClientes();" value="Inserir" style="position:absolute;left:647px;top:658px;width:96px;height:25px;z-index:22;">
                    <input type="button" class="button_padrao" id="salver_config_cliente" name="" value="Salvar Config." style="position:absolute;left:928px;top:350px;width:96px;height:25px;z-index:23;">
                    <input type="button" class="button_padrao" name="" value="Salvar" onclick="salvarModulo();"  style="position:absolute;left:952px;top:751px;width:96px;height:25px;z-index:23;">

                </form>

            </div>

        </div>

        <div class="modal fade " id="lightbox_selecionar_cliente">
            <div class="modal-dialog">
                <div class="modal-content site-color"  style="height:600px;width: 700px">

                    <div class="modal-header" id="header_modulo">

                    </div>
                    <div class="modal-body" style="height: 460px;">


                        <div class="square col-md-8" style="overflow-y: scroll;position:absolute;width:318px;height:400px;">

                            <div class="table-responsive">
                                <table id="table_clientes_selecionar" class="table table-striped table-hover border1">
                                    <tr>
                                        <th>
                                            Clientes:
                                        </th>
                                    </tr>
                                    <%                                    try {
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

                        <input type="button" class="button_padrao" value=">>" onclick="copyTable();" style="position: absolute;left: 335px;top: 200px; width: 28px;height: 25px;">
                        <input type="button" class="button_padrao" value="<<"  onclick="removeTableElements('#table_clientes_selecionados');" style="position: absolute;left: 335px;top: 228px; width: 28px;height: 25px;">

                        <div class="square col-md-8" style="overflow-y: scroll;position:absolute;left: 365px;width:318px;height:400px;">
                            <div class="table-responsive">
                                <table id="table_clientes_selecionados" class="table table-striped table-hover border1">
                                    <tr>
                                        <th>
                                            Clientes Selecinados:
                                        </th>
                                    </tr>


                                </table>
                            </div>
                        </div>
                        <input type="button" class="button_padrao" value="Salvar" onclick="salvarClientesSelecionados();" style="position: absolute;left:20px ;top: 425px;">
                    </div><!-- /.modal-body -->
                    <div class="modal-footer" style="position: absolute;;width: 700px;top: 500px;">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


        <div class="modal fade " id="lightbox_inserir_campo">
            <div class="modal-dialog">
                <div class="modal-content site-color">

                    <div class="modal-header" id="header_novo_campo">

                    </div>
                    <div class="modal-body" id="novo_campo_modulo">
                        Ex.: Nome do Computador: <br>
                        <input type="text" name="nome_campo" class="default_inputstyle" placeholder="Titulo" id="inserir_campo_nome">
                        <button type="button" class="button_padrao" onclick="salvarNovoCampo();" >Salvar</button>
                    </div><!-- /.modal-body -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <div id="PageFooter">
            <div id="wb_Image1" style="position:absolute;left:19px;top:25px;width:256px;height:50px;z-index:24;">
                <img src="images/consystem.PNG" id="Image1" alt=""></div>
        </div>
    </body>
</html>