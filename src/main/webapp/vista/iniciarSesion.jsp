<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="${pageContext.request.contextPath}/css/inicioSesion.css" rel="stylesheet" type="text/css"/> <!-- Rutas relativas unicas, es decir, para evitar el mal acceso a las rutas  -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <title>Iniciar Sesion</title>
    </head>
    <body>
                <div class="col-md-5">
                    <%
                        String registroExito = request.getParameter("registro");
                        if ("exito".equals(registroExito)) {
                    %>  
                    <div class="alert alert-dismissible alert-success">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <strong>¡Listo!</strong> Se ha registrado correctamente.
                    </div>
                    <%
                        }
                    %>

                    <%
                        String credencialesError = (String) request.getAttribute("msjeCredenciales");
                        if (credencialesError != null) {
                    %>  
                    <div class="alert alert-dismissible alert-danger">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <strong>¡Error!</strong> Correo electronico o contraseña incorrectas.
                    </div>
                    <%
                        }
                    %>
                </div>
        
        <div class="formulario">
            <h1>Inicio de sesion</h1>
            <form action="${pageContext.request.contextPath}/srvUsuario?accion=verificar" method="post"> 
                <div class="user">
                    <input type="text" name="correo" id="correo" required>
                    <label>Correo Electronico</label>
                </div>
                <div class="user">
                    <input type="password" name="clave" id="clave" required>
                    <label>Contraseña</label>
                </div>
                <div class="recordar">
                    ¿Olvidaste tu contraseña?
                </div>
                <input type="submit" name="verificar" id="Verificar" value="iniciar">
                <div class="registrarse">
                    Crear <a href="${pageContext.request.contextPath}/vista/registrar.jsp">cuenta</a>
                </div>
                <div class="volver">
                    Volver al <a href="${pageContext.request.contextPath}/vista/index.jsp">inicio</a>
                </div>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
