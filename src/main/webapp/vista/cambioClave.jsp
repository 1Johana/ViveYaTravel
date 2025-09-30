<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cambio de contraseña</title>
        <link href="${pageContext.request.contextPath}/css/cambioClave.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="formularioClave">
            <h2>Recuperar el acceso a tu cuenta</h2>
            <p>Introduce tu correo electrónico y te enviaremos un enlace para restablecerla.</p>

            <form action="${pageContext.request.contextPath}/srvRecuperarClave" method="post">
                <div class="campo">
                    <label for="correo">Correo electrónico:</label>
                    <input type="email" name="correo" id="correo" required>
                </div>
                <input type="submit" name="action" id="Registrar" value="Enlace">
            </form>
        </div>
    </body>
</html>
