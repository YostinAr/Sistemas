function ConsultarNombre() {

    let identificacion = $("#identificacion").val();

    if (identificacion.length > 0) {
        $.ajax({
            type: "GET",
            url: "https://apis.gometa.org/cedulas/" + identificacion,
            dataType: "json",
            success: function (result) {
                $("#nombre").val(result.nombre);
            }
        });
    }
    else {
        $("#nombre").val("");
    }
}

function EvitarEspacios(evt) {
    if (evt.keyCode === 32) {
        return false;
    }
    return true;
}

function FnDecimal(evt, elemento) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode >= 48 && charCode <= 57) {
        return true;
    }
    if (charCode == 44) {
        if (elemento.value.indexOf(',') <= 0) {
            return true;
        }
        else {
            return false;
        }
    }
    return false;
}

function FnEnteros(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode >= 48 && charCode <= 57) {
        return true;
    }
    return false;
}