<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="${pageContext.request.contextPath}/css/registroUsuario.css" rel="stylesheet" type="text/css"/>
         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <title>Registrar</title>
    </head>
    <body>
        <div class="col-md-3">
                    <%
                        String correoVa = request.getParameter("registro");
                        if ("correo".equals(correoVa)) {
                    %>  
                    <div class="alert alert-dismissible alert-danger">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <strong>¡Error!</strong> Este correo electronico ya esta en uso.
                    </div>
                    <%
                        }
                    %>

                    <%
                        String dniVa = request.getParameter("registro");
                        if ("dni".equals(dniVa)) {
                    %>  
                    <div class="alert alert-dismissible alert-danger">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <strong>¡Error!</strong> Este dni ya esta en uso.
                    </div>
                    <%
                        }
                    %>
                </div>
        <div class="formularioRegistro">
            <h1>Registrarse</h1>
            <p>Es rápido y fácil</p>
            <form action="${pageContext.request.contextPath}/srvRegistroUsuario" method="post">
                <div class="registro">
                    <input type="text" name="nombre" id="nombre" required>
                    <label>Nombre</label>
                </div>
                <div class="registro">
                    <input type="text" name="apellido" id="apellido" required>
                    <label>Apellido</label>
                </div>
                <div class="registro">
                    <input type="text" maxlength="9" name="nroCelular" id="celular" required>
                    <label>Celular</label>
                </div>
                <div class="registro">
                    <input type="text" maxlength="8" name="nroDni" id="dni" required>
                    <label>DNI</label>
                </div>
                <div class="registro">
                    <input type="text" name="correoElectronico" id="correoElectronico" required>
                    <label>Correo Electronico</label>
                </div>
                <div class="registro">
                    <input type="password" name="clave" id="password" required>
                    <label>Contraseña</label>
                </div>
                <input type="submit" name="registrar" id="Registrar" value="Registrarte">
            </form>

        </div>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
