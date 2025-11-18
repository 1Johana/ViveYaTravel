<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.viveyatravel.modelo.dto.usuario"%>

<%
    usuario cliente = (usuario) session.getAttribute("cliente");
    if (cliente == null) {
        cliente = new usuario(); // Evitar null pointer si no hay sesión
    }

    // 🧠 Selección dinámica del avatar según el género
    String avatarUrl;
    if (cliente.getGenero() != null && cliente.getGenero().equalsIgnoreCase("Mujer")) {
        avatarUrl = "https://cdn-icons-png.flaticon.com/512/3135/3135789.png"; // avatar mujer
    } else {
        avatarUrl = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"; // avatar hombre o default
    }
%>

<header>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/headerValidacionUsuario.css" rel="stylesheet" type="text/css"/>

    <div class="header">
        <div class="contHeader">

            <!-- LOGO -->
            <div class="logo">
                <a href="${pageContext.request.contextPath}/index.jsp">
                    <img src="https://www.viveyatravel.com/imagenes/logo-web-vive-ya-travel-2.png" class="logo">
                </a>
            </div>

            <!-- NAVBAR -->
            <div class="navbar">
                <nav>
                    <ul class="menu">
                        <li class="dropdown-tours">
                            <a href="#">TOURS <i class="fa-solid fa-chevron-down down-arrow"></i></a>
                            <ul class="submenu">
                                <li><a href="<%=request.getContextPath()%>/PaqueteControlador">Nacionales</a></li>
                                <li><a href="<%=request.getContextPath()%>/SRVInternacional">Internacionales</a></li>
                            </ul>
                        </li>
                        <li><a href="<%=request.getContextPath()%>/srvPromocion">PROMOCIONES</a></li>
                        <li><a href="${pageContext.request.contextPath}/vista/nosotros.jsp">NOSOTROS</a></li>
                    </ul>
                </nav>
            </div>

            <!-- CARRITO -->
            <div class="carro">
                <a href="<%=request.getContextPath()%>/vista/car.jsp">
                    <i class="fa-solid fa-cart-shopping carrito"></i>
                </a>
            </div>

            <!-- USUARIO -->
            <div class="usuario-container">
                <%
                    if (session.getAttribute("cliente") != null) {
                %>
                <ul class="menu2">
                    <li>
                        <a href="#">
                            <p class="username">Hola, <%= cliente.getNombre() %></p>
                            <img class="imagen" src="<%= avatarUrl %>" alt="Avatar" />
                            <i class="fa-solid fa-chevron-down" style="color: #fff"></i>
                        </a>
                        <ul>
                            <!-- 🧩 Botón para abrir ventana de perfil -->
                            <li class="perfil">
                                <a href="${pageContext.request.contextPath}/vista/perfil.jsp">
                                    <i class="fa-solid fa-user"></i> Perfil</a>
                            </li>
                            <!-- 🔹 Mis reservas (compras anteriores) -->
                            <li>
                                <a href="${pageContext.request.contextPath}/srvReserva?accion=misReservas">
                                    <i class="fa-solid fa-ticket"></i>Mis reservas</a>
                            </li>

                            </li>
                            <li class="close">
                                <a href="${pageContext.request.contextPath}/srvUsuario?accion=cerrar">
                                    <i class="fa-solid fa-arrow-right-from-bracket"></i>Cerrar sesión</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <%
                } else {
                %>
                <p class="bienvenido">Bienvenido invitado</p>
                <div class="usuario">
                    <a href="${pageContext.request.contextPath}/vista/iniciarSesion.jsp">
                        <i class="fa-solid fa-user usuario"></i>
                    </a>
                </div>
                <% } %>
            </div>

        </div>
            
    </div>

    <!-- Modal de edición de perfil -->
    <% if (cliente != null) {%>
    <input type="checkbox" id="btn-modal">
    <div class="container-modal">
        <div class="content-modal">
            <div class="btn-cerrar">
                <label for="btn-modal"><i class="fa-solid fa-xmark"></i></label>
            </div>
            <h2>Editar Perfil</h2>
            <form action="${pageContext.request.contextPath}/srvActualizarUsuario" method="POST">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="idUsuario" value="<%= cliente.getIdUsuario()%>">

                <div class="update">
                    <input type="text" name="nombre" id="nombre" value="<%= cliente.getNombre()%>" required>
                    <label for="nombre">Nombre:</label>
                </div>

                <div class="update">
                    <input type="text" name="apellido" id="apellido" value="<%= cliente.getApellido()%>" required>
                    <label for="apellido">Apellido:</label>
                </div>

                <div class="update">
                    <input type="text" name="nroCelular" id="celular" value="<%= cliente.getNroCelular()%>" required>
                    <label for="nroCelular">Nro Celular:</label>
                </div>

                <div class="update">
                    <input type="text" name="nroDni" id="dni" value="<%= cliente.getNroDni()%>" required>
                    <label for="nroDni">Nro DNI:</label>
                </div>

                <div class="update">
                    <input type="email" name="correoElectronico" id="correoElectronico" value="<%= cliente.getCorreoElectronico()%>" required>
                    <label for="correoElectronico">Correo Electrónico:</label>
                </div>

                <div class="update">
                    <input type="password" id="password" name="clave" value="<%= cliente.getClave()%>" required>
                    <label for="clave">Clave:</label>
                </div>

                <input type="submit" name="actualizar" id="Actualizar" value="Actualizar">
            </form>
        </div>
        <label for="btn-modal" class="cerrar-modal"></label>
    </div>
    <% }%>
</header>
