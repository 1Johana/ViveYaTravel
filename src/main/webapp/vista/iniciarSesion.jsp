<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <!-- Enlace correcto al CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/ViveYaTravel/css/inicioSesion.css" rel="stylesheet" type="text/css"/> 
    <title>Inicio de Sesión</title>

</head>
<body>

    <!-- FONDO + CAPA OSCURA -->
    <div class="background-container">
        <img src="${pageContext.request.contextPath}/img/viveya_fondologin.jpg" alt="fondo">
    </div>
    <div class="background-overlay"></div>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="main-content-wrapper">

        <div class="welcome-area">
            <h1 class="welcome-text">Bienvenido a <br> VIVE YA TRAVEL</h1>
        </div>

        <div class="login-area">
            <div class="alert-messages">
                <%
                    String registroExito = request.getParameter("registro");
                    if ("exito".equals(registroExito)) {
                %>  
                <div class="alert alert-success custom-alert" role="alert">
                    <strong>¡Listo!</strong> Se ha registrado correctamente.
                </div>
                <%
                    }
                    String credencialesError = (String) request.getAttribute("msjeCredenciales");
                    if (credencialesError != null) {
                %>  
                <div class="alert alert-danger custom-alert" role="alert">
                    <strong>¡Error!</strong> Correo electrónico o contraseña incorrectas.
                </div>
                <%
                    }
                %>
            </div>

            <div class="login-box">
                <h1 class="login-title">Inicio de Sesión</h1> 
                <form action="${pageContext.request.contextPath}/srvUsuario?accion=verificar" method="post" class="login-form"> 
                    
                    <div class="form-group">
                        <label for="correo" class="form-label-custom">Correo Electrónico</label>
                        <input type="text" name="correo" id="correo" class="form-control-custom" required>
                    </div>

                    <div class="form-group">
                        <label for="clave" class="form-label-custom">Contraseña</label>
                        <input type="password" name="clave" id="clave" class="form-control-custom" required>
                    </div>
                    
                    <input type="submit" name="verificar" id="Verificar" value="Iniciar" class="btn-submit">
                    
                    <div class="login-links">
                        <a href="${pageContext.request.contextPath}/vista/cambioClave.jsp" class="link-forgot">¿Olvidaste tu contraseña?</a>
                        <a href="${pageContext.request.contextPath}/vista/registrar.jsp" class="link-create">Crear cuenta</a>
                        <a href="${pageContext.request.contextPath}/vista/index.jsp" class="link-return">Volver al inicio</a>
                    </div>
                </form>
            </div>
        </div> 

    </div> 

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const alertBox = document.querySelector(".custom-alert");
        if (alertBox) {
            setTimeout(() => {
                alertBox.style.opacity = "0";
                setTimeout(() => alertBox.remove(), 900);
            }, 2000);
        }
    });
</script>

</body>
</html>
