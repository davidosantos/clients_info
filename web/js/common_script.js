/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function filterTable(table, filter) {
    var tmpFilter = filter.value.toUpperCase();
    var tr = table.getElementsByTagName("tr");
    var i, td;

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0];
        if (td) {
            if (td.innerHTML.toUpperCase().indexOf(tmpFilter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

function addTableRowEvent(table, func) {
    $(table).find('tr').click(function () {
        func($(this).find('td:first').text());
    });
}


function addTableEvents(table, func) {
    table.addEventListener("click", func);
}

function addTableElement(table, element) {
    var exists = $(table + " td:contains(" + element + ")").length === 1;
    if (!exists) {
        $(table + " tr:last").after('<tr><td><strong>' + element + '<strong/></td></tr>');
    }
}

function removeTableElement(table, element) {
    $(table).find('tr').each(function (i, td) {
        $(td).text();
        if ($(td).text() === element) {
            $(td).remove();
            return;
        }
    });
}
function copyTableElements(tableFrom, tableTo) {
    $(tableFrom).find('td').each(function (i, td) {
        var exists = $(tableTo + " td:contains(" + $(td).text() + ")").length === 1;
        if (!exists) {
            $(tableTo + " tr:last").after('<tr><td><strong>' + $(td).text() + '<strong/></td></tr>');
        }
    });

}
function removeTableElements(table) {
    $(table).find('td').each(function (i, td) {
        $(td).remove();
    });
}

function addLoggedUser(first) {

    var form = document.createElement('form');
    var input1 = document.createElement('input');

    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'getlogged');
    input1.setAttribute('value', 'getlogged');
    form.appendChild(input1);

    $.get("logado.jsp",
            $(form).serialize(),
            function (message) {

                var ret = $.parseXML(message);
                if ($(ret).find('returnType').text() === 'OK') {

                    if (first) {
                         window.location = "inicial.jsp"; //goto inicial
                    } else {


                        $.get("logado.jsp",
                                function (data) {
                                    $('#container').append(data);
                                }
                        );
                    }

                } else if ($(ret).find('returnType').text() === 'ERROR') {
                    displayErrorMessage($(ret).find('ErrorMessage').text());

                } else if ($(ret).find('returnType').text() === 'REDIRECT') {
                    displayErrorMessage($(ret).find('ErrorMessage').text());
                    setTimeout(
                            function ()
                            {
                                window.location = "."; //goto home

                            }, 5000);
                } else {
                    console.log("unknown return type in addLoggedUser(): " + message);
                }
            }
    );


}



function sleep(milliseconds) {
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
        if ((new Date().getTime() - start) > milliseconds) {
            break;
        }
    }
}



function getHttpObject() {
    try {
        return new XMLHttpRequest();
    }
    catch (error) {
    }
    try {
        return new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (error) {
    }
    try {
        return new ActiveXObject("Microsoft.XMLHTTP");
    }
    catch (error) {
    }

    throw new Error("Could not create HTTP request object.");
}

function getDefaultMessage() {
    $.get("getdata",
            {functiontype: "getmessage"},
    function (message) {
        $('#container').append(message);
    }
    );
}

function addTableFunctionTypeINE(table, functiontypeval) {

    if ($(table + ' input[id="functiontype"]').val() === undefined) {
        $(table).append("<input id=\"functiontype\" name=\"functiontype\" type=\"hidden\" value=\"" + functiontypeval + "\">");
    } else {
        if ($(table + ' input[id="functiontype"]').val() !== functiontypeval) {
            $(table + ' input[id="functiontype"]').remove();
            $(table).append("<input id=\"functiontype\" name=\"functiontype\" type=\"hidden\" value=\"" + functiontypeval + "\">");
        }
    }
}


function addTableControlINE(table, TableControlval) {

    if ($(table + ' input[id="TableControl"]').val() === undefined) {
        $(table).append("<input id=\"TableControl\" name=\"TableControl\" type=\"hidden\" value=\"" + TableControlval + "\">");
    } else {
        if ($(table + ' input[id="TableControl"]').val() !== TableControlval) {
            $(table + ' input[id="TableControl"]').remove();
            $(table).append("<input id=\"TableControl\" name=\"TableControl\" type=\"hidden\" value=\"" + TableControlval + "\">");
        }
    }
}


function modalSetSaved(modal) {
    if ($(modal + ' input[id="modal_status"]').val() === undefined) {
        console.log('Cannot set ' + modal + 'Saved, no modal_status element');
    } else {
        $(modal + ' input[id="modal_status"]').val('saved');
    }
}

function modalControl(modal, header_id, reference_id, extraExitFunction) {
    $(modal).on('hidden.bs.modal', function () {
        if ($(modal + ' input[id="modal_status"]').val() === undefined
                || $(modal + ' input[id="modal_status"]').val() === "open") {
            quickErrorMessage('Fechando sem salvar!!');
        } else {
            $(modal + ' input[id="modal_status"]').remove();
            if (extraExitFunction) {
                extraExitFunction();
            }
        }
        //location.reload();
    });

    $(modal).on('shown.bs.modal', function () {
        if ($(modal + ' input[id="modal_status"]').val() === undefined) {
            $(modal).append("<input id=\"modal_status\"  type=\"hidden\" value='open'>");
        }
        if ($(reference_id).val() === "") {
            if ($(modal + ' input[id="modal_control"]').val() === undefined) {
                $(modal).append("<input id=\"modal_control\"  type=\"hidden\" value='new'>");

            } else {
                $(modal + ' input[id="modal_control"]').remove();
                $(modal).append("<input id=\"modal_control\"  type=\"hidden\" value='new'>");
            }
            $(header_id).text('Criando Novo Cadastro');
        } else {
            if ($(modal + ' input[id="modal_control"]').val() === undefined) {
                $(modal).append("<input id=\"modal_control\"  type=\"hidden\" value='editing'>");

            } else {
                $(modal + ' input[id="modal_control"]').remove();
                $(modal).append("<input id=\"modal_control\"  type=\"hidden\" value='editing'>");
            }
            $(header_id).text('Editando Cadastro ' + $(reference_id).val());
        }
    });
}

function consultaTableClientes(table) {
    removeTableElements(table);
    var form_consulta_cliente = document.createElement('form');
    var input1_consulta = document.createElement('input');
    var input2_consulta = document.createElement('input');

    input1_consulta.setAttribute('type', 'text');
    input1_consulta.setAttribute('name', 'functiontype');
    input1_consulta.setAttribute('value', 'Consulta_clientes');

    form_consulta_cliente.appendChild(input1_consulta);
    form_consulta_cliente.appendChild(input2_consulta);

    $.post("getdata",
            $(form_consulta_cliente).serialize(),
            function (message_consulta) {
                var ret_consulta = $.parseJSON(message_consulta);
                if (ret_consulta.returnType === 'OK') {
                    $(ret_consulta.codigo).each(function (index, cod) {
                        addTableElement(table, cod);
                    });
                } else if (ret_consulta.returnType === 'ERROR') {
                    $('#defaultmessage').remove();
                    $('#container').append(
                            "<div id=\"defaultmessage\" class=\"alert alert-danger\" role=\"alert\">"
                            + ret_consulta.ErrorMessage
                            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                            + "<span aria-hidden=\"true\">&times;</span>"
                            + "</button></div>");
                } else {
                    console.log("unknown return type in consultaTableClientes(): " + message_consulta);
                }
            }
    );
}
function consultaTableModulos(table) {

    var form_consulta_cliente = document.createElement('form');
    var input1_consulta = document.createElement('input');
    var input2_consulta = document.createElement('input');

    input1_consulta.setAttribute('type', 'text');
    input1_consulta.setAttribute('name', 'functiontype');
    input1_consulta.setAttribute('value', 'Consulta_Modulos');


    form_consulta_cliente.appendChild(input1_consulta);
    form_consulta_cliente.appendChild(input2_consulta);

    $.post("getdata",
            $(form_consulta_cliente).serialize(),
            function (message_consulta) {
                var ret_consulta = $.parseJSON(message_consulta);
                if (ret_consulta.returnType === 'OK') {
                    $(ret_consulta.nome).each(function (index, cod) {
                        addTableElement(table, cod);
                    });
                } else if (ret_consulta.returnType === 'ERROR') {
                    $('#defaultmessage').remove();
                    $('#container').append(
                            "<div id=\"defaultmessage\" class=\"alert alert-danger\" role=\"alert\">"
                            + ret_consulta.ErrorMessage
                            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                            + "<span aria-hidden=\"true\">&times;</span>"
                            + "</button></div>");
                } else {
                    console.log("unknown return type in consultaTableModulos(): " + message_consulta);
                }
            }
    );
}


function consultaTableClientesPorModulo(table, modulo_name) {
    var form_consulta_cliente = document.createElement('form');
    var input1_consulta = document.createElement('input');
    var input2_consulta = document.createElement('input');

    input1_consulta.setAttribute('type', 'text');
    input1_consulta.setAttribute('name', 'functiontype');
    input1_consulta.setAttribute('value', 'Consulta_clientes_por_Modulo');

    input2_consulta.setAttribute('type', 'text');
    input2_consulta.setAttribute('name', 'modulo_nome');
    input2_consulta.setAttribute('value', modulo_name);

    form_consulta_cliente.appendChild(input1_consulta);
    form_consulta_cliente.appendChild(input2_consulta);

    $.post("getdata",
            $(form_consulta_cliente).serialize(),
            function (message_consulta) {
                var ret_consulta = $.parseJSON(message_consulta);
                if (ret_consulta.returnType === 'OK') {
                    $(ret_consulta.codigo).each(function (index, cod) {
                        addTableElement(table, cod);
                    });
                } else if (ret_consulta.returnType === 'ERROR') {
                    $('#defaultmessage').remove();
                    $('#container').append(
                            "<div id=\"defaultmessage\" class=\"alert alert-danger\" role=\"alert\">"
                            + ret_consulta.ErrorMessage
                            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                            + "<span aria-hidden=\"true\">&times;</span>"
                            + "</button></div>");
                } else {
                    console.log("unknown return type in atualizaContato(): " + message_consulta);
                }
            }
    );
}
function consultaTableClientesPorModulo_id(table, modulo_id, event) {
    var form_consulta_cliente = document.createElement('form');
    var input1_consulta = document.createElement('input');
    var input2_consulta = document.createElement('input');

    input1_consulta.setAttribute('type', 'text');
    input1_consulta.setAttribute('name', 'functiontype');
    input1_consulta.setAttribute('value', 'Consulta_clientes_por_Modulo_id');

    input2_consulta.setAttribute('type', 'text');
    input2_consulta.setAttribute('name', 'modulo_codigo_banco');
    input2_consulta.setAttribute('value', modulo_id);

    form_consulta_cliente.appendChild(input1_consulta);
    form_consulta_cliente.appendChild(input2_consulta);

    $.post("getdata",
            $(form_consulta_cliente).serialize(),
            function (message_consulta) {
                var ret_consulta = $.parseJSON(message_consulta);
                if (ret_consulta.returnType === 'OK') {
                    $(ret_consulta.codigo).each(function (index, cod) {
                        addTableElement(table, cod);
                        if (event) { // preciso para adicionar os eventos de remoção
                            addTableRowEvent(table, event);
                        }
                    });
                } else if (ret_consulta.returnType === 'ERROR') {
                    $('#defaultmessage').remove();
                    $('#container').append(
                            "<div id=\"defaultmessage\" class=\"alert alert-danger\" role=\"alert\">"
                            + ret_consulta.ErrorMessage
                            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                            + "<span aria-hidden=\"true\">&times;</span>"
                            + "</button></div>");
                } else {
                    console.log("unknown return type in atualizaContato(): " + message_consulta);
                }
            }
    );
}
function consultaTableModuloPorCliente(table, cliente_codigo) {
    var form_consulta_cliente = document.createElement('form');
    var input1_consulta = document.createElement('input');
    var input2_consulta = document.createElement('input');

    input1_consulta.setAttribute('type', 'text');
    input1_consulta.setAttribute('name', 'functiontype');
    input1_consulta.setAttribute('value', 'Consulta_Modulo_por_Cliente');

    input2_consulta.setAttribute('type', 'text');
    input2_consulta.setAttribute('name', 'cliente_codigo');
    input2_consulta.setAttribute('value', cliente_codigo);

    form_consulta_cliente.appendChild(input1_consulta);
    form_consulta_cliente.appendChild(input2_consulta);

    $.post("getdata",
            $(form_consulta_cliente).serialize(),
            function (message_consulta) {
                var ret_consulta = $.parseJSON(message_consulta);
                if (ret_consulta.returnType === 'OK') {
                    $(ret_consulta.nome).each(function (index, cod) {
                        addTableElement(table, cod);
                    });
                } else if (ret_consulta.returnType === 'ERROR') {
                    $('#defaultmessage').remove();
                    $('#container').append(
                            "<div id=\"defaultmessage\" class=\"alert alert-danger\" role=\"alert\">"
                            + ret_consulta.ErrorMessage
                            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
                            + "<span aria-hidden=\"true\">&times;</span>"
                            + "</button></div>");
                } else {
                    console.log("unknown return type in atualizaContato(): " + message_consulta);
                }
            }
    );
}

function inputToUpperCase(input_id) {
    document.getElementById(input_id).addEventListener("keyup", function () {
        $("#" + input_id).val($("#" + input_id).val().toUpperCase());
    });
}

function autoDismissAlert() {
    window.setTimeout(function () {
        $(".alert").fadeTo(500, 0).slideUp(500, function () {
            $(this).remove();
        });
    }, 4000);
}

function quickMessage(message, where) {
    where === undefined ? to = '#container' : to = where;
    var to;
    $(to).append(
            "<div id=\"defaultmessage\" class=\"alert alert-success\" role=\"alert\">"
            + message
            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
            + "<span aria-hidden=\"true\">&times;</span>"
            + "</button></div><script>autoDismissAlert();</script>");
}
function quickErrorMessage(message, where) {
    where === undefined ? to = '#container' : to = where;
    var to;
    $(to).append(
            "<div id=\"defaultmessage\" class=\"alert alert-danger\" role=\"alert\">"
            + message
            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
            + "<span aria-hidden=\"true\">&times;</span>"
            + "</button></div><script>autoDismissAlert();</script>");
}

function displayErrorMessage(message, where) {
    $('#defaultmessage').remove();
    var to;
    where === undefined ? to = '#container' : to = where;
    $(to).append(
            "<div id=\"defaultmessage\" style='z-index:9999;' class=\"alert alert-danger\" role=\"alert\">"
            + message
            + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">"
            + "<span aria-hidden=\"true\">&times;</span>"
            + "</button></div>");
}

function compatilizeText(texto) {
    return texto.trim().replace(/\n/g, "<br>");
}

function compatilizeToTextErea(texto) {
    return texto.trim().replace(/<br>/g, "\r");
}

function clearForm(form) {
    $(form).closest('form').find("input[type=text], input[type=checkbox], textarea").val("");
    $(form).closest('form').find("input[type=checkbox]").val(false);
}

function removeTextAreaForm(form, id) {
    $(form).closest('form').find('textarea[id=' + id + ']').remove();
}
function removeLabelForm(form, id) {
    $(form).closest('form').find('label[id=' + id + ']').remove();
}

//adicionar um evento de confirmação.
function addConfirmMessage(message, btn_id, confirmed_function, val_refered, errorMessage) {
    var modal_message = "<div class=\"modal fade \" id=\"confirm_" + $(btn_id).attr('id') + "\"> " +
            "<div class=\"modal-dialog\"> " +
            "<div class=\"modal-content site-color\"> " +
            "    <div class=\"modal-body\" id=\"message_" + $(btn_id).attr('id') + "\"> " +
            "       " + message + " <br> " +
            "    </div><!-- /.modal-body --> " +
            "    <div class=\"modal-footer\"> " +
            "    <button type=\"button\"data-dismiss=\"modal\" class=\"btn btn-primary\" id=\"delete_" + $(btn_id).attr('id') + "\"> Sim </button>" +
            "    <button type=\"button\"data-dismiss=\"modal\" class=\"btn\" > Não </button>" +
            "    </div> " +
            "</div><!-- /.modal-content --> " +
            "</div><!-- /.modal-dialog --> " +
            "</div><!-- /.modal -->";

    $('body').append(modal_message);

    $(btn_id).on('click', function (e) {
        if ($(val_refered).val()) {
            $('#confirm_' + $(btn_id).attr('id')).modal({
                keyboard: false
            }).one('click', '#delete_' + $(btn_id).attr('id'), function (e) {

                confirmed_function();


            });
        } else {
            quickErrorMessage(errorMessage);
        }
    });

    $(btn_id).hover(function (e) {
        if (val_refered) {
            $("#message_" + $(btn_id).attr('id')).text(message + $(val_refered).val());
        }
    });

}

//apenas uma mensagem de conformação
function ConfirmMessage(message, confirmed_function, valor) {
    var modal_message = "<div class=\"modal fade \" id=\"confirm_message\"> " +
            "<div class=\"modal-dialog\"> " +
            "<div class=\"modal-content site-color\"> " +
            "    <div class=\"modal-body\" id=\"message_\"> " +
            "       " + message + " <br> " +
            "    </div><!-- /.modal-body --> " +
            "    <div class=\"modal-footer\"> " +
            "    <button type=\"button\"data-dismiss=\"modal\"  class=\"btn btn-primary\" id=\"delete_message\"> Sim </button>" +
            "    <button type=\"button\"data-dismiss=\"modal\" class=\"btn\" > Não </button>" +
            "    </div> " +
            "</div><!-- /.modal-content --> " +
            "</div><!-- /.modal-dialog --> " +
            "</div><!-- /.modal -->";

    $('body').append(modal_message);

    $('#confirm_message').modal({
        keyboard: false
    });

    $('#delete_message').click(function (e) {
        if (confirmed_function) {
            confirmed_function(valor);
        }
    });

}

function efetuaLogin(form) {

    $.get("logado.jsp",
            $(form).serialize(),
            function (message) {
                var ret_consulta = $.parseXML(message);
                if ($(ret_consulta).find('returnType').text() === 'OK') {

                    addLoggedUser(true);
                } else if ($(ret_consulta).find('returnType').text() === 'ERROR') {
                    quickErrorMessage($(ret_consulta).find('ErrorMessage').text());
                } else {
                    console.log("unknown return type in efetuaLogin(): " + message);
                }
            }
    );
}
