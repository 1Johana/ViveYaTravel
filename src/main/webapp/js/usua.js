function reporte(accion){
    $.get('../reporteUsuarios?accion=' + accion, function (r){
        if(r){
            //Para acceder
            $('#accion').val(accion);
            $('#repUsuario').val(JSON.stringify(r));
            $('#formReporte').submit();
        }else{
            alert('El reporte no se generó por un error: ' + r);
        }
    });
}
