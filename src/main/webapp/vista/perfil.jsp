<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.viveyatravel.modelo.dto.usuario"%>
<%
    usuario cliente = (usuario) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect(request.getContextPath() + "/vista/iniciarSesion.jsp");
        return;
    }

    String avatarUrl;
    if (cliente.getFotoPerfil() != null && cliente.getFotoPerfil().length > 0) {
        avatarUrl = request.getContextPath() + "/srvUsuario?accion=mostrarFoto&idUsuario=" + cliente.getIdUsuario();
    } else {
        String genero = cliente.getGenero() != null ? cliente.getGenero().trim().toLowerCase() : "";
        if (genero.equals("mujer")) {
            avatarUrl = "https://cdn-icons-png.flaticon.com/512/3135/3135789.png";
        } else if (genero.equals("hombre")) {
            avatarUrl = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
        } else {
            avatarUrl = "https://cdn-icons-png.flaticon.com/512/1077/1077063.png";
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mi Perfil</title>

        <%-- ¡PERFECTO! Solo los links a los archivos .css externos --%>
        <link href="${pageContext.request.contextPath}/css/perfil.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    </head>
    
    <body>

        <div class="sidebar">
            <h2>Mi Perfil</h2>
            <a href="#" class="active">Editar perfil</a>
            <a href="#" onclick="abrirModal()">Cambiar contraseña</a>
            <a href="#">Historial de viajes</a>
            <a href="#">Métodos de pago</a>

            <form action="<%=request.getContextPath()%>/srvEliminarUsuario" method="post"
                  onsubmit="return confirm('¿Seguro que deseas eliminar tu cuenta?');">
                <input type="hidden" name="idUsuario" value="<%= cliente.getIdUsuario()%>">
                <button type="submit" name="eliminar" value="Eliminar" style="color: #ff6b6b;">Eliminar cuenta</button>
            </form>
        </div>

        <div class="main-content" id="mainProfileContent">
            
            <div class="profile-header">
                <div class="avatar-container"> 
                    <div class="profile-photo" id="avatarClickeable" style="background-image: url('<%= avatarUrl%>');">
                        <div class="avatar-overlay">
                            <i class="fa-solid fa-camera"></i>
                        </div>
                    </div>
                    <div class="avatar-menu" id="avatarMenu">
                        <a href="#" id="menuSubirFoto">
                            <i class="fa-solid fa-upload"></i> Subir foto
                        </a>
                        <a href="${pageContext.request.contextPath}/srvUsuario?accion=eliminarFoto"
                           onclick="return confirm('¿Estás seguro de que deseas eliminar tu foto de perfil?');">
                            <i class="fa-solid fa-trash"></i> Eliminar foto
                        </a>
                    </div>
                </div> 
                <div>
                    <h1><%= cliente.getNombre() + " " + cliente.getApellido()%></h1>
                    <p><%= cliente.getCorreoElectronico()%></p>
                </div>
            </div>
            
            <div class="profile-section">
                <h2>Editar información</h2>
                <form action="<%=request.getContextPath()%>/srvUsuario" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="accion" value="actualizarPerfil">
                    <input type="hidden" name="idUsuario" value="<%= cliente.getIdUsuario()%>">

                    <%-- Código limpio: Input oculto y vista previa separada --%>
                    <input type="file" id="fotoPerfil" name="fotoPerfil" accept="image/*" onchange="previewImage(event)" style="display: none;"> 
                    <img id="preview" alt="Vista previa">
                    
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" value="<%= cliente.getNombre()%>" required pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,30}">

                    <label for="apellido">Apellido:</label>
                    <input type="text" id="apellido" name="apellido" value="<%= cliente.getApellido()%>" required pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]{2,30}">

                    <label for="nroCelular">Número de Celular:</label>
                    <input type="text" id="nroCelular" name="nroCelular" maxlength="9" oninput="this.value = this.value.replace(/[^0-9]/g, '')" value="<%= cliente.getNroCelular()%>" required pattern="[0-9]{9}">

                    <label for="nroDni">DNI:</label>
                    <input type="text" id="nroDni" value="<%= cliente.getNroDni()%>" readonly>

                    <label for="correoElectronico">Correo:</label>
                    <input type="email" id="correoElectronico" value="<%= cliente.getCorreoElectronico()%>" readonly>

                    <button type="submit" name="actualizar" value="Actualizar" class="save-btn">
                        Guardar cambios
                    </button>
                </form>
            </div>
            
        </div> <div class="modal" id="modalClave">
            <div class="modal-content">
                <span class="close-btn" onclick="cerrarModal()">✖</span>
                <h2>Cambiar contraseña</h2>
                <form action="<%=request.getContextPath()%>/srvActualizarClave" method="POST" onsubmit="return validarClave(this)">
                    <input type="hidden" name="correoElectronico" value="<%= cliente.getCorreoElectronico()%>">
                    <label for="claveActual">Contraseña actual:</label>
                    <input type="password" id="claveActual" name="claveActual" required>
                    <label for="claveNueva">Nueva contraseña:</label>
                    <input type="password" id="claveNueva" name="claveNueva" required>
                    <label for="claveRepetir">Confirmar nueva contraseña:</label>
                    <input type="password" id="claveRepetir" name="claveRepetir" required>
                    <div id="form-message-container" class="msg" style="display: none;"></div>
                    <button type="submit" class="save-btn">Actualizar contraseña</button>
                </form>
            </div>
        </div>

        <script>
            // --- LÓGICA DEL MODAL ---
            const modal = document.getElementById("modalClave");
            const mainContent = document.getElementById("mainProfileContent");

            function abrirModal() {
                modal.style.display = "flex";
                mainContent.style.display = "block";
            }

            function cerrarModal() {
                modal.style.display = "none";
                mainContent.style.display = "block";
            }

            window.onclick = function (event) {
                if (event.target === modal)
                    cerrarModal();
            }

            // --- LÓGICA DE VALIDACIÓN DE CLAVE ---
            function validarClave(form) {
                const nueva = document.getElementById('claveNueva').value.trim();
                const repetir = document.getElementById('claveRepetir').value.trim();
                const regex = /^(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/;
                const msgContainer = document.getElementById('form-message-container');
                msgContainer.textContent = ""; 
                msgContainer.classList.remove('error', 'success'); 
                msgContainer.style.display = "none"; 
                let msg = "";
                let esValido = true;
                if (!regex.test(nueva)) {
                    msg = "⚠️ La nueva contraseña debe tener al menos 8 caracteres y un símbolo especial.";
                    esValido = false;
                } else if (nueva !== repetir) {
                    msg = "❌ Las contraseñas no coinciden.";
                    esValido = false;
                }
                if (!esValido) {
                    msgContainer.textContent = msg; 
                    msgContainer.classList.add('error'); 
                    msgContainer.style.display = "block"; 
                    return false; 
                }
                msgContainer.textContent = "✅ Contraseña válida, guardando...";
                msgContainer.classList.add('success'); 
                msgContainer.style.display = "block"; 
                return true; 
            }
            
            // --- LÓGICA DE VISTA PREVIA Y MENÚ DEL AVATAR ---
            const avatar = document.getElementById('avatarClickeable');
            const menu = document.getElementById('avatarMenu');
            const btnSubir = document.getElementById('menuSubirFoto');
            const fileInput = document.getElementById('fotoPerfil');

            avatar.addEventListener('click', function (event) {
                event.stopPropagation(); 
                menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
            });

            btnSubir.addEventListener('click', function (e) {
                e.preventDefault(); 
                fileInput.click(); 
                menu.style.display = 'none'; 
            });

            window.addEventListener('click', function (event) {
                if (menu.style.display === 'block' && !menu.contains(event.target)) {
                    menu.style.display = 'none';
                }
            });

            function previewImage(event) {
                if (event.target.files && event.target.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const avatarDiv = document.getElementById('avatarClickeable');
                        avatarDiv.style.backgroundImage = `url('${e.target.result}')`;
                        const previewImg = document.getElementById('preview');
                        previewImg.src = e.target.result;
                        previewImg.style.display = 'block';
                    };
                    reader.readAsDataURL(event.target.files[0]);
                }
            }
        </script>
        
    </body>
</html>