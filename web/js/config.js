/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function sendFormConfig() {
//    var teste = $("#host").val();
//    $get("getdata", {
//        func : teste
//    }, function (data) {
//
//    });
}

addLoggedUser();

function sendBancoDeDadosTest() {
    addTableFunctionTypeINE("#banco_form", "config_banco_test");
    var data = $("#banco_form");
    $.post("getdata",
            $(data).serialize(),
            function (message) {
                $('#defaultmessage').remove();
                $('#spaceheader').append(message);

            }
    );

}
function sendBancoDeDadosSalvar() {
    addTableFunctionTypeINE("#banco_form", "config_banco_save");
    var data = $("#banco_form");
    $.post("getdata",
            $(data).serialize(),
            function (message) {

                var dmessageCounter = 10;
                setInterval(function () {
                    $('#defaultmessage').remove();
                    $('#spaceheader').append(message);
                    $('#defaultmessage')
                            .append('<strong> Direcionando para página inicial em '
                                    + dmessageCounter + ' segundos.</strong>');
                    dmessageCounter--;
                    if (dmessageCounter <= 0) {
                        window.location = 'index.jsp';
                    }
                }, 1000);
            }
    );

}
function criarUserSalvar() {
    addTableFunctionTypeINE("#user_form", "config_create_user");
    var data = $("#user_form");
    $.post("getdata",
            $(data).serialize(),
            function (message) {
                $('#defaultmessage').remove();
                $('#spaceheader').append(message);
                
            }
    );

}

function sendBancoDeDadosCriar() {

    window.open("log.jsp", "_blank ", "width=400,height=400");
    addTableFunctionTypeINE("#banco_form", "config_banco_create");

    var data = $("#banco_form");
    $.post("getdata",
            $(data).serialize(),
            function (message) {
                $('#defaultmessage').remove();
                $('#spaceheader').append(message);

            }
    );

}
function sendBancoDeDadosScript() {


    addTableFunctionTypeINE("#banco_form", "config_banco_script");

    var data = new FormData(jQuery('#banco_form')[0]);
    $.post({
        url: "salvarModulo",
        type: "POST",
        data: data,
        processData: false,
        contentType: false,
        success: function (message) {
            $('#defaultmessage').remove();
            $('#spaceheader').append(message);
            window.open("log.jsp", "_blank ", "width=400,height=400");
        },
        error: function (jqXHR, textStatus, errorMessage) {
            console.log(errorMessage); // Optional
        }
    });

}

function sendMailSave() {
    addTableFunctionTypeINE("#email_form", "mail_save");
    var data = $("#email_form");
    $.get("getdata",
            $(data).serialize(),
            function (message) {
                $('#defaultmessage').remove();
                $('#spaceheader').append(message);
            }
    );
}

function sendMailTest() {
    addTableFunctionTypeINE("#email_form", "mail_test");
    var data = $("#email_form");
    $.get("getdata",
            $(data).serialize(),
            function (message) {
                $('#defaultmessage').remove();
                $('#spaceheader').append(message);
            }
    );
}
