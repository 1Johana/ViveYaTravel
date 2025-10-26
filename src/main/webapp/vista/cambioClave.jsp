<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recuperar contraseña</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/cambioClave.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <div class="overlay"></div>

        <div class="formularioClave">
            <div class="logo">
                <i class="fa-solid fa-plane-departure"></i>
                <span>Vive Ya travel</span>
            </div>
            <h2>¿Olvidaste tu contraseña?</h2>
            <p>Introduce tu correo y te enviaremos un enlace para restablecerla.</p>

            <form action="${pageContext.request.contextPath}/srvRecuperarClave" method="post">
                <div class="campo">
                    <input type="email" name="correo" id="correo" required>
                    <label for="correo">Correo electrónico</label>
                    <span></span>
                </div>
                <input type="submit" name="action" id="Registrar" value="Enlace">
            </form>

            <a href="${pageContext.request.contextPath}/vista/iniciarSesion.jsp" class="volver">
                <i class="fa-solid fa-arrow-left"></i> Volver al inicio
            </a>
        </div>
    </body>
</html>
