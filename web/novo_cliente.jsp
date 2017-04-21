<%-- 
    Document   : novo_cliente
    Created on : Jan 14, 2017, 10:44:48 PM
    Author     : David Santos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Novo Cliente</title>
        <meta name="generator" content="WYSIWYG Web Builder 11 Trial Version - http://www.wysiwygwebbuilder.com">
        <link href="clientsInfo.css" rel="stylesheet">
        <link href="novo_cliente.css" rel="stylesheet">
    </head>
    <body>
        <div id="container">
            <a href="http://www.wysiwygwebbuilder.com" target="_blank"><img src="images/builtwithwwb11.png" alt="WYSIWYG Web Builder" style="position:absolute;left:10px;top:808px;border-width:0;z-index:250"></a>
            <div id="wb_Form1" style="position:absolute;left:128px;top:119px;width:486px;height:623px;z-index:23;">
                <form name="Form1" method="post" action="mailto:yourname@yourdomain.com" enctype="text/plain" id="Form1">
                    <label  id="Label2" style="position:absolute;left:52px;top:104px;width:76px;height:18px;line-height:18px;z-index:0;">Nome:</label>
                    <label  id="Label3" style="position:absolute;left:52px;top:137px;width:76px;height:18px;line-height:18px;z-index:1;">Email:</label>
                    <label  id="Label4" style="position:absolute;left:52px;top:170px;width:76px;height:18px;line-height:18px;z-index:2;">Endereço:</label>
                    <label  id="Label5" style="position:absolute;left:52px;top:275px;width:76px;height:18px;line-height:18px;z-index:3;">Cidade:</label>
                    <label id="Label6" style="position:absolute;left:52px;top:308px;width:76px;height:18px;line-height:18px;z-index:4;">Estado:</label>
                    <label  id="Label7" style="position:absolute;left:52px;top:341px;width:76px;height:18px;line-height:18px;z-index:5;">Cep:</label>
                    <label  id="Label8" style="position:absolute;left:52px;top:374px;width:76px;height:18px;line-height:18px;z-index:6;">Telefone:</label>
                    <label  id="Label9" style="position:absolute;left:52px;top:407px;width:76px;height:18px;line-height:18px;z-index:7;">Telefone 2:</label>
                    <label id="Label10" style="position:absolute;left:52px;top:440px;width:76px;height:18px;line-height:18px;z-index:8;">Fax:</label>
                    <label for="cliente_cep" id="Label1" style="position:absolute;left:52px;top:71px;width:76px;height:18px;line-height:18px;z-index:9;">Código</label>
                    <input type="text" id="cliente_codigo" style="position:absolute;left:146px;top:71px;width:190px;height:18px;line-height:18px;z-index:10;" name="condigo" value="" readonly disabled>
                    <input type="text" id="cliente__name" style="position:absolute;left:146px;top:104px;width:190px;height:18px;line-height:18px;z-index:11;" name="Nome" value="" readonly disabled>
                    <input type="text" id="cliente_email" style="position:absolute;left:146px;top:137px;width:190px;height:18px;line-height:18px;z-index:12;" name="email" value="" readonly>
                    <textarea name="Address" id="cliente_endereco" style="position:absolute;left:146px;top:170px;width:190px;height:90px;z-index:13;" rows="4" cols="29" readonly></textarea>
                    <input type="text" id="cliente_cidade" style="position:absolute;left:146px;top:275px;width:190px;height:18px;line-height:18px;z-index:14;" name="city" value="" readonly>
                    <input type="text" id="cliente_estado" style="position:absolute;left:146px;top:308px;width:190px;height:18px;line-height:18px;z-index:15;" name="state" value="" readonly>
                    <input type="text" id="cliente_cep" style="position:absolute;left:146px;top:341px;width:190px;height:18px;line-height:18px;z-index:16;" name="zip" value="" readonly>
                    <input type="text" id="cliente_telefone" style="position:absolute;left:146px;top:374px;width:190px;height:18px;line-height:18px;z-index:17;" name="Home Phone" value="" readonly>
                    <input type="text" id="cliente_tel_trab" style="position:absolute;left:146px;top:407px;width:190px;height:18px;line-height:18px;z-index:18;" name="Work Phone" value="" readonly>
                    <input type="text" id="cliente_fax" style="position:absolute;left:146px;top:440px;width:190px;height:18px;line-height:18px;z-index:19;" name="Fax Number" value="" readonly>
                    <input type="button" id="salvar" name="" value="Salvar" style="position:absolute;left:366px;top:573px;width:96px;height:25px;z-index:20;">
                </form>
            </div>
        </div>
        <div id="PageFooter1" style="position:absolute;overflow:hidden;text-align:left;left:0px;top:853px;width:100%;height:100px;z-index:24;">
            <div id="wb_Image1" style="position:absolute;left:19px;top:25px;width:256px;height:50px;z-index:21;">
                <img src="images/img0007.png" id="Image1" alt=""></div>
        </div>
    </body>
</html>
