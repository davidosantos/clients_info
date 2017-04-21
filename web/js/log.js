/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function getLogs() {
    $.get("getdata",
            {functiontype: "get_sqllog"},
    function (logs) {
        $('#logs').html(logs);
    }
    );
}

setInterval(function () {
    getLogs();
}, 200);