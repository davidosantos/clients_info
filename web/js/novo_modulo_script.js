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
        table = document.getElementById("table_clientes_modulo");
        filterTable(table, filter);

    });



    addTableEvents(document.getElementById("table_clientes_modulo"), function (element) {
        var param = $(element.target).text();
        document.getElementById("cliente_selecionado").value = param;
        carregaConfigClient();
    });

    addLoggedUser();


    modalControl("#lightbox_selecionar_cliente", "#header_modulo", "#modulo_nome", carregaModulo);
    modalControl("#lightbox_inserir_campo", "#header_campo", "#modulo_nome", carregaModulo);

    inputToUpperCase("modulo_nome");


    addTableRowEvent('#table_clientes_selecionar', addRow);

    addConfirmMessage("Tem Certeza que deseja remover o cliente? ", '#remover_cliente', removeClient, '#cliente_selecionado', 'Não há cliente selecionado!');
    addConfirmMessage("Salvar Configuração do cliente? ", '#salver_config_cliente', saveConfigClient, '#cliente_selecionado', 'Não há cliente selecionado!');

    //carrega os arquivos e adicionar os eventos e remoção
    $("#arquivo1").change(function () {
        UploadArquivo();
    });

   // consultaPerfil();
});

function UploadArquivo() {
    if (!($('#Form_modulo' + ' input[id="TableControl"]').val() === 'editing')) {
        quickErrorMessage("Primeiro Salve o Modulo");
        return;
    }
    var nome_arquivo = $("#arquivo1").val().replace(/C:\\fakepath\\/i, '');

    var form = document.createElement('form');
    form.enctype = "multipart/form-data";
    var input1 = document.createElement('input');
    var input2 = document.createElement('input');
    var input3 = document.createElement('input');
    var input4 = document.createElement('input');

    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'Upload_Arquivo');
    form.appendChild(input1);

    input2.setAttribute('type', 'text');
    input2.setAttribute('name', 'modulo_id');
    input2.setAttribute('value', $("#modulo_codigo_banco").val());
    form.appendChild(input2);

    input3.setAttribute('type', 'text');
    input3.setAttribute('name', 'nome_arquivo');
    input3.setAttribute('value', nome_arquivo);
    form.appendChild(input3);

    input4 = $("#arquivo1").clone();

    if(($(input4)[0].files[0].size / 1024 /1024) > 30){
        quickErrorMessage("O tamanho máximo é 30MB");
        return;
    }
    $(form).append(input4);

    var data = new FormData(jQuery(form)[0]);

    $.post({
        url: "getdata",
        type: "POST",
        data: data,
        processData: false,
        contentType: false,
        beforeSend: function () {

            var percentVal = '0%';
            $('#progressbar').width(percentVal);
            $('#progressbar').text(percentVal);
        },
        xhr: function () {
            var myXhr = $.ajaxSettings.xhr();
            if (myXhr.upload) {
                myXhr.upload.addEventListener('progress', progress, false);
            }
            return myXhr;
        },
        success: function (message) {
            //$('#progressbar').text(xhr.responseText);
            var ret = $.parseXML(message);

            if ($(ret).find('returnType').text() === 'OK') {

                quickMessage($(ret).find('ErrorMessage').text());
                carregaModulo();
            } else if ($(ret).find('returnType').text() === 'ERROR') {
                displayErrorMessage($(ret).find('ErrorMessage').text());
            } else {
                console.log("unknown return type in Upload_Arquivo(): " + message);
            }

        }
    });
}

function progress(e) {

    if (e.lengthComputable) {
        var max = e.total;
        var current = e.loaded;

        var Percentage = (current * 100) / max;
        $('#progressbar').width(Percentage + '%');
        $('#progressbar').text(Percentage + '%');

        if (Percentage >= 100)
        {
            $('#progressbar').text('Completo');
        }
    }
}


function removeClient() {

    var form = document.createElement('form');
    var input1 = document.createElement('input');
    var input2 = document.createElement('input');
    var input3 = document.createElement('input');
    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'Remove_Client');
    form.appendChild(input1);

    input2.setAttribute('type', 'text');
    input2.setAttribute('name', 'modulo_id');
    input2.setAttribute('value', $("#modulo_codigo_banco").val());
    form.appendChild(input2);

    input3.setAttribute('type', 'text');
    input3.setAttribute('name', 'cliente_selecionado');
    input3.setAttribute('value', $("#cliente_selecionado").val());
    form.appendChild(input3);


    $.post("getdata",
            $(form).serialize(),
            function (message) {

                var ret = $.parseXML(message);
                if ($(ret).find('returnType').text() === 'OK') {

                    quickMessage($(ret).find('ErrorMessage').text());
                    carregaModulo();
                } else if ($(ret).find('returnType').text() === 'ERROR') {
                    displayErrorMessage($(ret).find('ErrorMessage').text());
                } else {
                    console.log("unknown return type in atualizaContato(): " + ret.returnType);
                }
            }
    );

}
function saveConfigClient() {

    var form = document.createElement('form');

    var input1 = document.createElement('input');
    var input2 = document.createElement('input');
    var input3 = document.createElement('input');
    var input4 = document.createElement('textarea');

    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'save_Client_config');
    form.appendChild(input1);

    input2.setAttribute('type', 'text');
    input2.setAttribute('name', 'modulo_id');
    input2.setAttribute('value', $("#modulo_codigo_banco").val());
    form.appendChild(input2);

    input3.setAttribute('type', 'text');
    input3.setAttribute('name', 'cliente_selecionado');
    input3.setAttribute('value', $("#cliente_selecionado").val());
    form.appendChild(input3);

    input4.setAttribute('name', 'config_text');
    $(input4).text($("#config_cliente_text").val());
    form.appendChild(input4);

    var data = new FormData(jQuery(form)[0]);

    $.post({
        url: "getdata",
        type: "POST",
        data: data,
        processData: false,
        contentType: false,
        success: function (message) {

            var ret = $.parseXML(message);

            if ($(ret).find('returnType').text() === 'OK') {

                quickMessage($(ret).find('ErrorMessage').text());

            } else if ($(ret).find('returnType').text() === 'ERROR') {
                displayErrorMessage($(ret).find('ErrorMessage').text());
            } else {
                console.log("unknown return type in atualizaContato(): " + ret.returnType);
            }
        },
        error: function (jqXHR, textStatus, errorMessage) {
            console.log(errorMessage); // Optional
        }
    });


}
function carregaConfigClient() {

    var form = document.createElement('form');
    var input1 = document.createElement('input');
    var input2 = document.createElement('input');
    var input3 = document.createElement('input');

    if ($("#cliente_selecionado").val() === '') {
        return;
    }

    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'consulta_Client_config');
    form.appendChild(input1);

    input2.setAttribute('type', 'text');
    input2.setAttribute('name', 'modulo_id');
    input2.setAttribute('value', $("#modulo_codigo_banco").val());
    form.appendChild(input2);

    input3.setAttribute('type', 'text');
    input3.setAttribute('name', 'cliente_selecionado');
    input3.setAttribute('value', $("#cliente_selecionado").val());
    form.appendChild(input3);


    $.post("getdata",
            $(form).serialize(),
            function (message) {

                var ret = $.parseXML(message);
                if ($(ret).find('returnType').text() === 'OK') {

                    $("#config_cliente_text").val($(ret).find('config').text());

                } else if ($(ret).find('returnType').text() === 'ERROR') {
                    displayErrorMessage($(ret).find('ErrorMessage').text());
                } else {
                    console.log("unknown return type in atualizaContato(): " + ret.returnType);
                }
            }
    );

}

function addRow(element) {
    addTableElement("#table_clientes_selecionados", element);
    addTableRowEvent('#table_clientes_selecionados', removeRow); // necessário para poder remover
}

function removeRow(element) {
    removeTableElement("#table_clientes_selecionados", element);
}

function removerArquivo(arquivo) {
    ConfirmMessage('Remover o arquivo ' + arquivo + ' do modulo ' + $("#modulo_nome").val() + '?', removerArquivo_Confirmed, arquivo);
}

function removerArquivo_Confirmed(arquivo) {

    var form = document.createElement('form');
    var input1 = document.createElement('input');
    var input2 = document.createElement('input');
    var input3 = document.createElement('input');
    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'Remover_Arquivo');
    form.appendChild(input1);

    input2.setAttribute('type', 'text');
    input2.setAttribute('name', 'modulo_id');
    input2.setAttribute('value', $("#modulo_codigo_banco").val());
    form.appendChild(input2);

    input3.setAttribute('type', 'text');
    input3.setAttribute('name', 'arquivo');
    input3.setAttribute('value', arquivo);
    form.appendChild(input3);


    $.post("getdata",
            $(form).serialize(),
            function (message) {

                var ret = $.parseXML(message);
                if ($(ret).find('returnType').text() === 'OK') {

                    quickMessage($(ret).find('ErrorMessage').text());
                    carregaModulo();
                } else if ($(ret).find('returnType').text() === 'ERROR') {
                    displayErrorMessage($(ret).find('ErrorMessage').text());
                } else {
                    console.log("unknown return type in atualizaContato(): " + ret.returnType);
                }
            }
    );

}

function copyTable() {
    copyTableElements('#table_clientes_selecionar', '#table_clientes_selecionados');
    addTableRowEvent('#table_clientes_selecionados', removeRow); // necessário para poder remover
}


function salvarNovoCampo() {

    var form = document.createElement('form');
    var input1 = document.createElement('input');
    var input2 = document.createElement('input');
    var input3 = document.createElement('input');
    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'Save_campos_personalizados');
    form.appendChild(input1);

    input2.setAttribute('type', 'text');
    input2.setAttribute('name', 'modulo_id');
    input2.setAttribute('value', $("#modulo_codigo_banco").val());
    form.appendChild(input2);

    input3.setAttribute('type', 'text');
    input3.setAttribute('name', 'inserir_campo_nome');
    input3.setAttribute('value', $("#inserir_campo_nome").val());
    form.appendChild(input3);


    $.post("getdata",
            $(form).serialize(),
            function (message) {

                var ret = $.parseXML(message);
                if ($(ret).find('returnType').text() === 'OK') {

                    quickMessage($(ret).find('ErrorMessage').text(), '#header_novo_campo');

                } else if ($(ret).find('returnType').text() === 'ERROR') {
                    displayErrorMessage($(ret).find('ErrorMessage').text(), '#header_novo_campo');
                } else {
                    console.log("unknown return type in atualizaContato(): " + ret.returnType);
                }
            }
    );

    modalSetSaved('#lightbox_inserir_campo');
}

function mostrarModalSelecionarClientes() {

    if ($('#Form_modulo' + ' input[id="TableControl"]').val() === 'editing') {
        addTableFunctionTypeINE("#table_clientes_selecionados", "Cliente_Modulo_Save");
    } else {
        quickErrorMessage("Primeiro Salve o Modulo");
        return;
    }

    $('#lightbox_selecionar_cliente').modal({
        backdrop: 'static',
        keyboard: false

    });
}

function mostrarModalInserirCampos() {

    if ($('#Form_modulo' + ' input[id="TableControl"]').val() === 'editing') {
        addTableFunctionTypeINE("#table_clientes_selecionados", "Cliente_Modulo_Save");
    } else {
        quickErrorMessage("Primeiro Salve o Modulo");
        return;
    }

    $('#lightbox_inserir_campo').modal({
        backdrop: 'static',
        keyboard: false

    });
}

function salvarClientesSelecionados() {

    var form = document.createElement('form');
    var input1 = document.createElement('input');
    var input3 = document.createElement('input');
    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'Cliente_Modulo_Save');
    form.appendChild(input1);
    input3.setAttribute('type', 'text');
    input3.setAttribute('name', 'modulo_codigo_banco');
    input3.setAttribute('value', $("#modulo_codigo_banco").val());
    form.appendChild(input3);

    $('#table_clientes_selecionados').find('td').each(function (i, td) {
        var input2 = document.createElement('input');
        input2.setAttribute('type', 'text');
        input2.setAttribute('name', 'clientes_selecionados');
        input2.setAttribute('value', $(td).text());
        form.appendChild(input2);

    });


    $.post("getdata",
            $(form).serialize(),
            function (message) {
                $('#defaultmessage').remove();
                $('#header_modulo').append(message);

            }
    );

    modalSetSaved('#lightbox_selecionar_cliente');
}


function salvarModulo() {
    if ($('#Form_modulo' + ' input[id="TableControl"]').val() === 'editing') {
        addTableFunctionTypeINE("#Form_modulo", "Modulo_Save");
    } else if ($('#Form_modulo' + ' input[id="TableControl"]').val() === 'new') {
        addTableFunctionTypeINE("#Form_modulo", "Modulo_New");
    } else {
        console.log("unknown table TableControl Form_modulo " + $('#Form_modulo' + ' input[id="TableControl"]').val());
        return;
    }

    var data = new FormData(jQuery('#Form_modulo')[0]);
    $.post({
        url: "salvarModulo",
        type: "POST",
        data: data,
        processData: false,
        contentType: false,
        success: function (message) {
            $('#defaultmessage').remove();
            $('#container').append(message);
            if (message.indexOf('Salvo Com Sucesso') > -1) {
                addTableControlINE("#Form_modulo", "editing"); //muda o controle para edição
                carregaModulo();
            }
        },
        error: function (jqXHR, textStatus, errorMessage) {
            console.log(errorMessage); // Optional
        }
    });
}

function carregaModulo() {

    var form = document.createElement('form');
    var input1 = document.createElement('input');
    var input2 = document.createElement('input');

    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'functiontype');
    input1.setAttribute('value', 'Modulo_Consulta');

    input2.setAttribute('type', 'text');
    input2.setAttribute('name', 'modulo_selecionado');
    input2.setAttribute('value', $('#modulo_nome').val());

    form.appendChild(input1);
    form.appendChild(input2);

    $.post("getdata",
            $(form).serialize(),
            function (message) {
                //  console.log(message);
                var ret = $.parseXML(message);
                if ($(ret).find('returnType').text() === 'OK') {
                    $("#modulo_codigo_banco").val($(ret).find('modulo_id').text());
                    $("#modulo_servidor").val($(ret).find('servidor').text());
                    $("#modulo_pasta").val($(ret).find('pasta').text());
                    $("#modulo_arquivos").val($(ret).find('arquivos').text());
                    $("#modulo_configs").val($(ret).find('config').text());
                    $("#modulo_prerequisitos").val($(ret).find('prerequisitos').text());
                    $("#modulo_crontabstring").val($(ret).find('crontab').text()); //necessário fazer a consistencia ret.iscron === '1' || ret.iscron === 't' ), pois o banco de dados postgres retorno f/t e o mysql 0/1
                    $("#modulo_sircp").val($(ret).find('psirc').text());

                    carregaModuloCamposPersonalizados($(ret).find('modulo_id').text());

                    removeTableElements("#table_clientes_modulo");
                    removeTableElements("#table_clientes_selecionados");
                    consultaTableClientesPorModulo_id("#table_clientes_modulo", $(ret).find('modulo_id').text());
                    consultaTableClientesPorModulo_id("#table_clientes_selecionados", $(ret).find('modulo_id').text(), removeRow);
                    removeTableElements('#table_arquivos');
                    $(ret).find('arquivos_anexados').each(function (index, element) {
                        $('#table_arquivos').append('<tr><td>' + $(element).text() + '</td></tr>');
                        //evento para remover os arquivos
                        addTableRowEvent('#table_arquivos', removerArquivo);
                    });

                } else if ($(ret).find('returnType').text() === 'ERROR') {
                    $('#defaultmessage').remove();
                    $('#container').append(
                            "<div id=\"defaultmessage\" class=\"alert alert-danger\" role=\"alert\">"
                            + ret.ErrorMessage
                            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                            + "<span aria-hidden=\"true\">&times;</span>"
                            + "</button></div>");
                } else {
                    console.log("unknown return type in atualizaContato(): " + $(ret).find('returnType').text());
                }
            }
    );

}

function carregaModuloCamposPersonalizados(modulo_id) {
    var form_campos = document.createElement('form');
    var input1_campos = document.createElement('input');
    var input2_campos = document.createElement('input');

    input1_campos.setAttribute('type', 'text');
    input1_campos.setAttribute('name', 'functiontype');
    input1_campos.setAttribute('value', 'Consulta_campos_personalizados');

    input2_campos.setAttribute('type', 'text');
    input2_campos.setAttribute('name', 'modulo_id');
    input2_campos.setAttribute('value', modulo_id);

    form_campos.appendChild(input1_campos);
    form_campos.appendChild(input2_campos);

    $.post("getdata",
            $(form_campos).serialize(),
            function (message) {

                var ret = $.parseXML(message);
                if ($(ret).find('returnType').text() === 'OK') {
                    var distance = 105;
                    var startingTop = 533; //last texterea
                    $(ret).find('campos').each(function (index, nome) {
                        var textarea = document.createElement('textarea');
                        var label = document.createElement('label');
                        var arrayNomesCampos = document.createElement('input');//-> Necessário para enviar na hora de salvar os campos porsonalizados
                        startingTop = (startingTop + distance);

                        textarea.setAttribute('id', $(nome).text());
                        textarea.setAttribute('name', $(nome).text());
                        textarea.setAttribute('class', 'site-color-fundo');
                        textarea.setAttribute('style', 'position:absolute;left:181px;top:' + (startingTop) + 'px;width:190px;height:80px;z-index:17;');
                        textarea.setAttribute('rows', '4');
                        textarea.setAttribute('cols', '29');
                        $(textarea).text($(ret).find('data_' + $(nome).text()).text());

                        label.setAttribute('id', 'Label_' + $(nome).text());
                        label.setAttribute('for', $(nome).text());
                        label.setAttribute('style', 'position:absolute;left:9px;top:' + (startingTop) + 'px;width:154px;height:18px;line-height:18px;text-align: left;z-index:16;');
                        $(label).text($(nome).text() + ':');

                        arrayNomesCampos.setAttribute('type', 'hidden');
                        arrayNomesCampos.setAttribute('name', 'arrayNomesCampos');
                        arrayNomesCampos.setAttribute('value', $(nome).text());

                        var form_modulo = document.getElementById("config_modulo");

                        removeTextAreaForm('#config_modulo', $(nome).text());
                        removeLabelForm('#config_modulo', 'Label_' + $(nome).text());
                        form_modulo.appendChild(textarea);
                        form_modulo.appendChild(label);
                        form_modulo.appendChild(arrayNomesCampos);

                    });

                } else if ($(ret).find('returnType').text() === 'ERROR') {
                    displayErrorMessage($(ret).find('ErrorMessage').text());
                } else {
                    console.log("unknown return type in atualizaContato(): " + ret.returnType);
                }
            }
    );
}

function novoModulo() {
    addTableControlINE("#Form_modulo", "new");
    clearForm('#Form_modulo');
    removeTableElements("#table_clientes_modulo");
    removeTableElements("#table_clientes_selecionados");
}