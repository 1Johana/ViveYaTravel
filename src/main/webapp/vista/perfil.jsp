<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.viveyatravel.modelo.dto.usuario"%>
<%
    usuario cliente = (usuario) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect(request.getContextPath() + "/vista/iniciarSesion.jsp");
        return;
    }

    // Avatar según género
    String avatarUrl;
    String genero = cliente.getGenero() != null ? cliente.getGenero().trim().toLowerCase() : "";
    if (genero.equals("mujer")) {
        avatarUrl = "https://cdn-icons-png.flaticon.com/512/3135/3135789.png";
    } else if (genero.equals("hombre")) {
        avatarUrl = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
    } else {
        avatarUrl = "https://cdn-icons-png.flaticon.com/512/1077/1077063.png";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mi Perfil</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f6fa;
                margin: 0;
                display: flex;
                height: 100vh;
            }
            .sidebar {
                width: 250px;
                background-color: #1e1e2f;
                color: #fff;
                display: flex;
                flex-direction: column;
                padding-top: 30px;
            }
            .sidebar a, .sidebar form button {
                text-decoration: none;
                color: #cfcfcf;
                padding: 15px 25px;
                display: block;
                border: none;
                background: none;
                text-align: left;
                cursor: pointer;
            }
            .sidebar a:hover, .sidebar form button:hover {
                background-color: #2f2f45;
                color: #fff;
            }
            .main-content {
                flex: 1;
                background-color: #ffffff;
                padding: 40px;
            }
            .profile-header {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            .profile-photo {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                background-size: cover;
                background-position: center;
            }
            .profile-section {
                margin-top: 30px;
                border-top: 1px solid #ddd;
                padding-top: 20px;
            }
            .profile-section label {
                display: block;
                font-weight: bold;
                margin-top: 15px;
            }
            .profile-section input {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .save-btn {
                margin-top: 25px;
                background-color: #0073aa;
                color: #fff;
                padding: 10px 25px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .save-btn:hover {
                background-color: #005f87;
            }

            /* 🔐 Modal estilos */
            .modal {
                display: none;
                position: fixed;
                z-index: 100;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.6);
                justify-content: center;
                align-items: center;
            }
            .modal-content {
                background: #fff;
                padding: 30px;
                border-radius: 10px;
                width: 400px;
                position: relative;
            }
            .close-btn {
                position: absolute;
                right: 10px;
                top: 10px;
                background: none;
                border: none;
                font-size: 18px;
                cursor: pointer;
            }
            /* Estilo general del modal */
            #modalClave .modal-content {
                background: #fff;
                padding: 25px 35px;
                border-radius: 10px;
                width: 420px;
                max-width: 95%;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
                font-family: 'Segoe UI', sans-serif;
            }

            /* Título */
            #modalClave h2 {
                margin-top: 0;
                font-size: 20px;
                color: #222;
                margin-bottom: 15px;
                text-align: center;
            }

            /* Formulario */
            #modalClave form {
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            /* Etiquetas e inputs */
            #modalClave label {
                font-weight: 600;
                margin-bottom: 4px;
            }

            #modalClave input[type="password"] {
                width: 100%;
                padding: 8px 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                transition: border-color 0.3s;
            }

            #modalClave input[type="password"]:focus {
                border-color: #0078d4;
                outline: none;
            }

            /* Botón */
            #modalClave button {
                background-color: #0078d4;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                cursor: pointer;
                margin-top: 8px;
                transition: background-color 0.3s;
            }

            #modalClave button:hover {
                background-color: #005fa3;
            }

            /* Mensaje de validación (de tu script anterior) */
            .msg {
                font-size: 14px;
                padding: 8px;
                border-radius: 5px;
                text-align: center;
                animation: fadeIn 0.3s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-5px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <h2>Mi Perfil</h2>
            <a href="#" class="active">Editar perfil</a>
            <a href="#" onclick="abrirModal()">Cambiar contraseña</a>
            <!-- Conservamos tus otras opciones originales -->
            <a href="#">Historial de viajes</a>
            <a href="#">Métodos de pago</a>

            <form action="<%=request.getContextPath()%>/srvEliminarUsuario" method="post"
                  onsubmit="return confirm('¿Seguro que deseas eliminar tu cuenta?');">
                <input type="hidden" name="idUsuario" value="<%= cliente.getIdUsuario()%>">
                <button type="submit" name="eliminar" value="Eliminar" style="color: #ff6b6b;">Eliminar cuenta</button>
            </form>
        </div>

        <!-- Contenido principal -->
        <div class="main-content">
            <div class="profile-header">
                <div class="profile-photo" style="background-image: url('<%= avatarUrl%>');"></div>
                <div>
                    <h1><%= cliente.getNombre() + " " + cliente.getApellido()%></h1>
                    <p><%= cliente.getCorreoElectronico()%></p>
                </div>
            </div>

            <div class="profile-section">
                <h2>Editar información</h2>
                <form action="<%=request.getContextPath()%>/srvActualizarUsuario" method="POST">
                    <input type="hidden" name="idUsuario" value="<%= cliente.getIdUsuario()%>">

                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre"
                           value="<%= cliente.getNombre()%>"
                           required pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,30}">

                    <label for="apellido">Apellido:</label>
                    <input type="text" id="apellido" name="apellido"
                           value="<%= cliente.getApellido()%>"
                           required pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,30}">

                    <label for="nroCelular">Número de Celular:</label>
                    <input type="text" id="nroCelular" name="nroCelular" maxlength="9"
                           oninput="this.value = this.value.replace(/[^0-9]/g, '')"
                           value="<%= cliente.getNroCelular()%>" required pattern="[0-9]{9}">

                    <label for="nroDni">DNI:</label>
                    <input type="text" id="nroDni" value="<%= cliente.getNroDni()%>" readonly>

                    <label for="correoElectronico">Correo:</label>
                    <input type="email" id="correoElectronico" value="<%= cliente.getCorreoElectronico()%>" readonly>

                    <button type="submit" class="save-btn">Guardar cambios</button>
                </form>
            </div>
        </div>

        <!-- 🔐 Modal de cambio de contraseña -->
        <div class="modal" id="modalClave">
            <div class="modal-content">
                <button class="close-btn" onclick="cerrarModal()">✖</button>
                <h2>Cambiar contraseña</h2>
                <form action="<%=request.getContextPath()%>/srvActualizarClave" method="POST" onsubmit="return validarClave()">
                    <input type="hidden" name="correoElectronico" value="<%= cliente.getCorreoElectronico()%>">

                    <label for="claveActual">Contraseña actual:</label>
                    <input type="password" id="claveActual" name="claveActual" required>

                    <label for="claveNueva">Nueva contraseña:</label>
                    <input type="password" id="claveNueva" name="claveNueva" required>

                    <label for="claveRepetir">Confirmar nueva contraseña:</label>
                    <input type="password" id="claveRepetir" name="claveRepetir" required>

                    <button type="submit" class="save-btn">Actualizar contraseña</button>
                </form>
            </div>
        </div>

        <script>
            const modal = document.getElementById("modalClave");

            function abrirModal() {
                modal.style.display = "flex";
            }

            function cerrarModal() {
                modal.style.display = "none";
            }

            window.onclick = function (event) {
                if (event.target === modal)
                    cerrarModal();
            }

            // 🔐 Validación visual mejorada
            function validarClave() {
                const nueva = document.getElementById('claveNueva').value.trim();
                const repetir = document.getElementById('claveRepetir').value.trim();
                const regex = /^(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/;

                // Eliminar cualquier mensaje previo
                const msgExistente = document.querySelector(".msg");
                if (msgExistente)
                    msgExistente.remove();

                const form = document.querySelector("#modalClave form");
                const msg = document.createElement("div");
                msg.classList.add("msg");
                msg.style.marginTop = "15px";
                msg.style.padding = "10px";
                msg.style.borderRadius = "5px";
                msg.style.fontWeight = "bold";
                msg.style.textAlign = "center";
                msg.style.transition = "opacity 0.4s ease";

                if (!regex.test(nueva)) {
                    msg.style.background = "#ffe1e1";
                    msg.style.color = "#d8000c";
                    msg.textContent = "⚠️ La nueva contraseña debe tener al menos 8 caracteres y un símbolo especial.";
                    form.appendChild(msg);
                    return false;
                }

                if (nueva !== repetir) {
                    msg.style.background = "#ffe1e1";
                    msg.style.color = "#d8000c";
                    msg.textContent = "❌ Las contraseñas no coinciden.";
                    form.appendChild(msg);
                    return false;
                }

                msg.style.background = "#e0ffe4";
                msg.style.color = "#007a33";
                msg.textContent = "✅ Contraseña válida, guardando cambios...";
                form.appendChild(msg);
                setTimeout(() => msg.style.opacity = "0", 3000);

                return true;
            }
        </script>

    </body>
</html>
