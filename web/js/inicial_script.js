/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {

    document.getElementById("pesquisa_cliente").addEventListener("keyup", function () {

// Declare variables 
        var filter, table;
        filter = document.getElementById("pesquisa_cliente");
        table = document.getElementById("table_clientes");
        filterTable(table, filter);
    });
    addTableEvents(document.getElementById("table_clientes"), function (element) {
        var clienteClicked = $(element.target).text();
        document.getElementById("cliente_selecionado").value = clienteClicked;
        consultaContato();
        removeTableElements("#table_modulos");
        consultaTableModuloPorCliente("#table_modulos", $("#cliente_selecionado").val());
        if ($('#modulo_selecionado').val()) {
            carregaModulo_info();
            console.log('wrong' + $('#modulo_selecionado').val());
        }
    });
    document.getElementById("pesquisa_modulo").addEventListener("keyup", function () {

// Declare variables 
        var filter, table;
        filter = document.getElementById("pesquisa_modulo");
        table = document.getElementById("table_modulos");
        filterTable(table, filter);
    });
    addTableEvents(document.getElementById("table_modulos"), function (element) {
        var moduloClicked = $(element.target).text();
        document.getElementById("modulo_selecionado").value = moduloClicked;
        carregaModulo_info();
        removeTableElements("#table_clientes");
        consultaTableClientesPorModulo("#table_clientes", $("#modulo_selecionado").val());
    });
    addLoggedUser();
    modalControl("#lightbox_InserirEdit_Cliente", "#modal_header_cliente", "#cliente_selecionado", function () {
        consultaTableClientes('#table_clientes');
    });
    // modalControl("#lightbox_EdittarPerfil", "#modal_header_perfil");
    //consultaPerfil();
    inputToUpperCase('cliente_codigo_');
});


function consultaContato() {


    var form = document.createElement('form');
    var input1 = document.createElement('input');
    var input2 = document.createElement('input');
    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'Cliente_Consult');
    input2.setAttribute('type', 'text');
    input2.setAttribute('name', 'cliente_selecionado');
    input2.setAttribute('value', $('#cliente_selecionado').val());
    form.appendChild(input1);
    form.appendChild(input2);
    $.post("getdata",
            $(form).serialize(),
            function (message) {
                var ret = $.parseJSON(message);
                if (ret.returnType === 'OK') {
                    $("#cliente_codigo").val(ret.codigo);
                    $("#cliente_nome").val(ret.nome);
                    $("#cliente_email").val(ret.email);
                    $("#cliente_endereco").val(ret.endereco);
                    $("#cliente_cidade").val(ret.cidade);
                    $("#cliente_estado").val(ret.estado);
                    $("#cliente_cep").val(ret.cep);
                    $("#cliente_telefone1").val(ret.telefone1);
                    $("#cliente_telefone2").val(ret.telefone2);
                    $("#cliente_ramal").val(ret.ramal);
                } else if (ret.returnType === 'ERROR') {
                    $('#defaultmessage').remove();
                    $('#container').append(
                            "<div id=\"defaultmessage\" class=\"alert alert-danger\" role=\"alert\">"
                            + ret.ErrorMessage
                            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                            + "<span aria-hidden=\"true\">&times;</span>"
                            + "</button></div>");
                } else {
                    console.log("unknown return type in atualizaContato(): " + ret.returnType);
                }
            }
    );
}

function consultaContato_() {

    if ($('#cliente_selecionado').val() === undefined || $('#cliente_selecionado').val() === "") {
        return;
    }

    var form = document.createElement('form');
    var input1 = document.createElement('input');
    var input2 = document.createElement('input');
    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'Cliente_Consult');
    input2.setAttribute('type', 'text');
    input2.setAttribute('name', 'cliente_selecionado');
    input2.setAttribute('value', $('#cliente_selecionado').val());
    form.appendChild(input1);
    form.appendChild(input2);
    $.post("getdata",
            $(form).serialize(),
            function (message) {
                var ret = $.parseJSON(message);
                if (ret.returnType === 'OK') {
                    $("#cliente_codigo_").val(ret.codigo);
                    $("#cliente_nome_").val(ret.nome);
                    $("#cliente_email_").val(ret.email);
                    $("#cliente_endereco_").val(ret.endereco);
                    $("#cliente_cidade_").val(ret.cidade);
                    $("#cliente_estado_").val(ret.estado);
                    $("#cliente_cep_").val(ret.cep);
                    $("#cliente_telefone1_").val(ret.telefone1);
                    $("#cliente_telefone2_").val(ret.telefone2);
                    $("#cliente_ramal_").val(ret.ramal);
                    $("#cliente_codigo_banco_").val(ret.cliente_id);
                } else if (ret.returnType === 'ERROR') {
                    $('#defaultmessage').remove();
                    $('#modal_header_cliente').append(
                            "<div id=\"defaultmessage\" class=\"alert alert-danger\" role=\"alert\">"
                            + ret.ErrorMessage
                            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                            + "<span aria-hidden=\"true\">&times;</span>"
                            + "</button></div>");
                } else {
                    console.log("unknown return type in atualizaContato(): " + ret.returnType);
                }
            }
    );
}



function salvarCliente() {
    if ($('#lightbox_InserirEdit_Cliente' + ' input[id="modal_control"]').val() === 'editing') {
        addTableFunctionTypeINE("#Form_contato_", "Cliente_Save");
    } else if ($('#lightbox_InserirEdit_Cliente' + ' input[id="modal_control"]').val() === 'new') {
        addTableFunctionTypeINE("#Form_contato_", "Cliente_New");
    } else {
        console.log("unknown table function lightbox_InserirEdit_Cliente");
        return;
    }

    var data = $("#Form_contato_");
    $.post("getdata",
            $(data).serialize(),
            function (message) {
                $('#defaultmessage').remove();
                $('#modal_header_cliente').append(message);
            }
    );
    modalSetSaved("#lightbox_InserirEdit_Cliente");
}

function carregaModulo_info() {
    $('#Modulo_info').html(""); //limpa a tela

    var form = document.createElement('form');
    var input1 = document.createElement('input');
    var input2 = document.createElement('input');
    var input3 = document.createElement('input');
    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'Modulo_Consulta');
    input2.setAttribute('type', 'text');
    input2.setAttribute('name', 'modulo_selecionado');
    input2.setAttribute('value', $('#modulo_selecionado').val());
    input3.setAttribute('type', 'text');
    input3.setAttribute('name', 'cliente_selecionado');
    input3.setAttribute('value', $('#cliente_selecionado').val());
    form.appendChild(input1);
    form.appendChild(input2);
    form.appendChild(input3);

    $.post("getdata",
            $(form).serialize(),
            function (message) {
                // console.log(message);
                var ret = $.parseXML(message);
                if ($(ret).find('returnType').text() === 'OK') {
                    //$("#modulo_codigo_banco").val($(ret).find('modulo_id);

                    $('#Modulo_info').append("<div class=\"col-md-6\"></div>");
                    $('#Modulo_info').append("<div class=\"table-responsive\"></div>");
                    $('#Modulo_info').append("<table id= \"Modulo_info_table\" class=\"table table-bordered\"></table>");

                    if ($(ret).find('servidor').text()) {

                        $('#Modulo_info_table').append("<tr style='padding:3px;'><td><p style='text-align:center;'><strong>Servidor:</strong></p><br>" + compatilizeText($(ret).find('servidor').text()) + "<br><br></td></tr>");

                    }
                    if ($(ret).find('pasta').text()) {

                        $('#Modulo_info_table').append("<tr><td><p style='text-align:center;'><strong>Pasta:</strong></p><br>" + compatilizeText($(ret).find('pasta').text()) + "<br><br></td></tr>");

                    }
                    if ($(ret).find('arquivos').text()) {

                        $('#Modulo_info_table').append("<tr><td><p style='text-align:center;'><strong>Arquivos:</strong></p><br>" + compatilizeText($(ret).find('arquivos').text()) + "<br><br></td></tr>");

                    }
                    if ($(ret).find('config').text()) {

                        $('#Modulo_info_table').append("<tr><td><p style='text-align:center;'><strong>Config:</strong></p><br>" + compatilizeText($(ret).find('config').text()) + "<br><br></td></tr>");

                    }
                    if ($(ret).find('prerequisitos').text()) {

                        $('#Modulo_info_table').append("<p style='text-align:center;'><strong>Pre-requisitos:</strong></p><br>" + compatilizeText($(ret).find('prerequisitos').text()) + "<br><br></td></tr>");

                    }
                    if ($(ret).find('crontab').text()) {

                        $('#Modulo_info_table').append("<tr><td><p style='text-align:center;'><strong>Linhas Crontab:</strong></p><br>" + compatilizeText($(ret).find('crontab').text()) + "<br><br></td></tr>");

                    }
                    if ($(ret).find('psirc').text()) {

                        $('#Modulo_info_table').append("<tr><td><p style='text-align:center;'><strong>Programas Sircplus:</strong></p><br>" + compatilizeText($(ret).find('psirc').text()) + "<br><br></td></tr>");

                    }

                    $(ret).find('campos').each(function (index, nome) {

                        $('#Modulo_info_table').append("<tr><td><p style='text-align:center;'><strong>" + $(nome).text() + ":</strong></p><br>"
                                + compatilizeText($(ret).find('data_' + $(nome).text()).text()) + "<br><br></td></tr>");

                    });

                    if ($(ret).find('arquivos_anexados').length > 0) {
                        var html = "<tr><td><p style='text-align:center;'><strong>Arquivos Anexados:</strong></p><br>";

                        $(ret).find('arquivos_anexados').each(function (index, nome) {
                            //<a href="https://www.w3schools.com" target="_blank">Visit W3Schools.com!</a> 
                            html = html + "<a href=\"download?functiontype=Download_Arquivo&modulo_id=" + $(ret).find('modulo_id').text() + "&arquivo=" + $(nome).text() + "\" target=\"_blank\">" + $(nome).text() + "</a><br>";

                        });

                        html = (html + "<br><br></td></tr>");

                        $('#Modulo_info_table').append(html);
                    }
                    if ($(ret).find('config_cliente').text()) {

                        $('#Modulo_info_table').append("<tr><td><p style='text-align:center;'><strong>Config. Específica do cliente: " + $('#cliente_selecionado').val() + "</strong></p><br>" + compatilizeText($(ret).find('config_cliente').text()) + "<br><br></td></tr>");

                    }

                } else if ($(ret).find('returnType').text() === 'ERROR') {
                    $('#defaultmessage').remove();
                    $('#container').append(
                            "<div id=\"defaultmessage\" class=\"alert alert-danger\" role=\"alert\">"
                            + $(ret).find('ErrorMessage').text()
                            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                            + "<span aria-hidden=\"true\">&times;</span>"
                            + "</button></div>");
                } else {
                    console.log("unknown return type in atualizaContato(): " + $(ret).find('returnType').text());
                }
            }
    );
}


function novoCliente() {
    if ($('#lightbox_InserirEdit_Cliente input[id="modal_control"]').val() === undefined) {
        $('#lightbox_InserirEdit_Cliente').append("<input id=\"modal_control\"  type=\"hidden\" value='new'>");

    } else {
        $('#lightbox_InserirEdit_Cliente input[id="modal_control"]').remove();
        $('#lightbox_InserirEdit_Cliente').append("<input id=\"modal_control\"  type=\"hidden\" value='new'>");
    }
    $('#modal_header_cliente').text('Criando Novo Cadastro');
    clearForm('#Form_contato_');
}