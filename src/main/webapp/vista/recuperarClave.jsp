
<%@page import="com.mycompany.viveyatravel.modelo.dto.usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recuperar contraseña</title>
        <link href="${pageContext.request.contextPath}/css/cambioClave.css" rel="stylesheet" type="text/css"/>

    </head>
    <body>
        <div class="formularioClave">
            <h2>Hola ${nombre}, restablece tu contraseña</h2>            
            <form action="${pageContext.request.contextPath}/srvRecuperarClave" method="post" id="resetForm">
                <input type="hidden" name="action" value="cambiar">
                <!-- Recuperar el correo -->
                <input type="hidden" name="correo" value="${correo}">

                <div class="campo">
                    <label for="clave">Nueva contraseña:</label>
                    <input type="password" id="clave" name="clave" required
                           pattern='^(?=.*[^A-Za-z0-9]).{8,}$'
                           title="Debe tener al menos 8 caracteres y un caracter especial">
                </div>
                <!-- <button type="submit">Cambiar contraseña</button> -->
                <input type="submit" value="cambiar">

            </form>
        </div>
    </body>
</html>
