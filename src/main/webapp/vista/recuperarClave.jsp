<%@page import="com.mycompany.viveyatravel.modelo.dto.usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Restablecer Contraseña</title>

    <link href="${pageContext.request.contextPath}/css/cambioClave.css" rel="stylesheet" type="text/css"/>
    <link rel="icon" href="../img/icon.png" type="image">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body>

    <!-- Capa oscura del fondo -->
    <div class="overlay"></div>

    <div class="formularioClave">

        <div class="logo">
            <i class="fa-solid fa-plane-departure"></i>
            <span>Vive Ya Travel</span>
        </div>

        <h2>Hola ${nombre}</h2>
        <p>Crea una nueva contraseña para continuar tu viaje ✈️</p>

        <form action="${pageContext.request.contextPath}/srvRecuperarClave" method="post">

            <input type="hidden" name="action" value="cambiar">
            <input type="hidden" name="correo" value="${correo}">

            <!-- Campo con estilo flotante existente -->
            <div class="campo">
                <input type="password" name="clave" id="clave" required
                       pattern="^(?=.*[^A-Za-z0-9]).{8,}$"
                       title="Debe tener al menos 8 caracteres y un caracter especial">
                <label for="clave">Nueva contraseña</label>
                <span></span>
            </div>

            <!-- Botón existente del CSS -->
            <input type="submit" name="action" id="Registrar" value="cambiar">

        </form>

        <!-- Enlace estilo Travel -->
        <a href="login.jsp" class="volver">
            <i class="fa-solid fa-arrow-left"></i> Regresar
        </a>

    </div>

</body>
</html>
