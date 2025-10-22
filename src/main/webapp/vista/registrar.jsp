<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath}/css/registroUsuario.css" rel="stylesheet" type="text/css"/>
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Registrar</title>
</head>
<body>

    <!-- === CONTENEDOR DE FONDO === -->
    <div class="background-container">
        <img src="${pageContext.request.contextPath}/img/fondoregistrarusuario.jpg" alt="Fondo de registro">
        <div class="background-overlay"></div>
    </div>

    <!-- === MENSAJE DE ERROR FLOTANTE === -->
    <%
        String registro = request.getParameter("registro");
        if (registro != null) {
            String mensajeError = "";
            if ("correo".equals(registro)) {
                mensajeError = "Este correo electrónico ya está en uso.";
            } else if ("dni".equals(registro)) {
                mensajeError = "Este DNI ya está en uso.";
            } else if ("formatoCorreo".equals(registro)) {
                mensajeError = "Solo se permiten correos @gmail.com o @hotmail.com.";
            }
            if (!mensajeError.isEmpty()) {
    %>
    <div class="alert-overlay" id="alertOverlay">
        <div class="alert-box">
            <p><%= mensajeError %></p>
        </div>
    </div>
    <%
            }
        }
    %>

    <!-- === FORMULARIO REGISTRO === -->
    <div class="formularioRegistro">
        <h1>Registrarse</h1>
        <p>Es rápido y fácil</p>
        <form action="${pageContext.request.contextPath}/srvRegistroUsuario" method="post">
            <div class="registro">
                <input type="text" maxlength="8" oninput="this.value = this.value.replace(/[^0-9]/g, '')" name="nroDni" id="dni" required>
                <label>DNI</label>
            </div>
            <div class="registro">
                <input type="text" name="nombre" id="nombre" required>
                <label>Nombre</label>
            </div>
            <div class="registro">
                <input type="text" name="apellido" id="apellido" required>
                <label>Apellido</label>
            </div>
            <div class="registro">
                <input type="text" maxlength="9" oninput="this.value = this.value.replace(/[^0-9]/g, '')" name="nroCelular" id="celular" required>
                <label>Celular</label>
            </div>
            <div class="registro">
                <input type="email" name="correoElectronico" id="correoElectronico" required
                       pattern="^[a-zA-Z0-9._%+-]+@(gmail\\.com|hotmail\\.com)$"
                       title="Solo se permiten correos @gmail.com o @hotmail.com">
                <label>Correo Electrónico</label>
            </div>
            <div class="registro">
                <input type="password" name="clave" id="password" required
                       pattern="^(?=.*[^A-Za-z0-9]).{8,}$"
                       title="Debe tener al menos 8 caracteres y un caracter especial">
                <label>Contraseña</label>
            </div>
            <input type="submit" name="registrar" id="Registrar" value="Registrarte">
        </form>
    </div>

    <!-- === SCRIPT DNI Y ALERTA === -->
    <script>
    // Autocompletado con API Perú
    document.getElementById('dni').addEventListener('input', async function() {
        const dni = this.value.trim();
        if (dni.length === 8) {
            const params = { dni };
            try {
                const response = await fetch("https://apiperu.dev/api/dni", {
                    method: "POST",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json",
                        "Authorization": "Bearer 237fdc97ec26b93ea174384b3e4ec6129384b25cfed0b63dfe81254827ee8f73"
                    },
                    body: JSON.stringify(params)
                });
                const data = await response.json();
                if (data.success && data.data) {
                    document.getElementById("nombre").value = data.data.nombres;
                    document.getElementById("apellido").value = data.data.apellido_paterno + " " + data.data.apellido_materno;
                }
            } catch (e) {
                console.error("Error al conectar con API Perú:", e);
            }
        }
    });

    // Desaparecer alerta automáticamente
    const alertOverlay = document.getElementById('alertOverlay');
    if (alertOverlay) {
        setTimeout(() => {
            alertOverlay.classList.add('fade-out');
            setTimeout(() => alertOverlay.remove(), 500);
        }, 3000);
    }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
