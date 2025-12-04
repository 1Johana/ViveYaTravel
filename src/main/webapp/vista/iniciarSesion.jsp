<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Iniciar Sesión | Vive Ya Travel</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link href="${pageContext.request.contextPath}/css/inicioSesion.css?v=FINAL" rel="stylesheet" type="text/css"/>
</head>
<body>

    <div class="login-card">
        
        <div class="login-header">
            <h2>¡Bienvenido!</h2>
            <p>Inicia sesión para continuar tu aventura</p>
        </div>

        <div class="alert-messages">
            <% 
                String registroExito = request.getParameter("registro");
                if ("exito".equals(registroExito)) { 
            %>  
                <div class="custom-alert" style="background: rgba(40, 167, 69, 0.9);">
                    <i class="fa-solid fa-check-circle"></i> ¡Registro exitoso!
                </div>
            <% 
                }
                String credencialesError = (String) request.getAttribute("msjeCredenciales");
                if (credencialesError != null) { 
            %>  
                <div class="custom-alert">
                    <i class="fa-solid fa-circle-exclamation"></i> Datos incorrectos
                </div>
            <% } %>
        </div>

        <form action="${pageContext.request.contextPath}/srvUsuario?accion=verificar" method="post">
            
            <div class="input-group">
                <i class="fa-solid fa-envelope"></i>
                <input type="text" name="correo" placeholder="Correo Electrónico" required autocomplete="off">
            </div>

            <div class="input-group">
                <i class="fa-solid fa-lock"></i>
                <input type="password" name="clave" placeholder="Contraseña" required>
            </div>
            
            <input type="submit" value="INGRESAR" class="btn-submit">
            
        </form>

        <div class="login-footer">
            <a href="${pageContext.request.contextPath}/vista/cambioClave.jsp">¿Olvidaste tu contraseña?</a>
            
            <div class="divider"></div>
            
            <p style="margin:0; opacity:0.7;">¿Aún no tienes cuenta?</p>
            <a href="${pageContext.request.contextPath}/vista/registrar.jsp" style="color: #F7B32B; font-size: 16px;">
                Regístrate aquí <i class="fa-solid fa-arrow-right"></i>
            </a>
            
            <a href="${pageContext.request.contextPath}/vista/index.jsp" style="margin-top: 10px; font-size: 12px; opacity: 0.6;">
                <i class="fa-solid fa-house"></i> Volver al inicio
            </a>
        </div>

    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const alertas = document.querySelectorAll(".custom-alert");
            
            if (alertas.length > 0) {
                setTimeout(() => {
                    alertas.forEach(alerta => {
                        alerta.style.transition = "opacity 0.5s ease, transform 0.5s ease";
                        alerta.style.opacity = "0";
                        alerta.style.transform = "translateY(-10px)"; // Efecto de subir al desaparecer
                        
                        // Eliminar del DOM después de la animación
                        setTimeout(() => alerta.remove(), 500);
                    });
                }, 3000); // Espera 3 segundos antes de desaparecer
            }
        });
    </script>

</body>
</html>