<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.viveyatravel.modelo.dto.usuario"%>

<%
    usuario cliente = (usuario) session.getAttribute("cliente");
    String avatarUrl;
    if (cliente != null && cliente.getFotoPerfil() != null && cliente.getFotoPerfil().length > 0) {
        avatarUrl = request.getContextPath() + "/srvUsuario?accion=mostrarFoto&idUsuario=" + cliente.getIdUsuario();
    } else {
        String genero = (cliente != null && cliente.getGenero() != null) ? cliente.getGenero().trim().toLowerCase() : "";
        if (genero.equals("mujer")) avatarUrl = "https://cdn-icons-png.flaticon.com/512/3135/3135789.png";
        else if (genero.equals("hombre")) avatarUrl = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
        else avatarUrl = "https://cdn-icons-png.flaticon.com/512/1077/1077063.png";
    }
%>

<header class="main-header">
    <div class="header-container">

        <div class="header-left-group">
            
            <div class="menu-toggle" id="mobile-menu">
                <i class="fa-solid fa-bars"></i>
            </div>

            <div class="logo">
                <a href="${pageContext.request.contextPath}/vista/index.jsp">
                    <img src="https://www.viveyatravel.com/imagenes/logo-web-vive-ya-travel-2.png" alt="Logo">
                </a>
            </div>

            <nav class="navbar" id="navbar">
                <ul>
                    <li class="dropdown">
                        <a href="#">TOURS <i class="fa-solid fa-chevron-down"></i></a>
                        <ul class="submenu">
                            <li><a href="<%=request.getContextPath()%>/PaqueteControlador">Nacionales</a></li>
                            <li><a href="#">Internacionales</a></li>
                        </ul>
                    </li>
                    <li><a href="<%=request.getContextPath()%>/srvPromocion">PROMOCIONES</a></li>
                    <li><a href="${pageContext.request.contextPath}/vista/nosotros.jsp">NOSOTROS</a></li>
                </ul>
            </nav>
        </div>

        <div class="acciones-usuario">
            <div class="usuario-container">
                <% if (session.getAttribute("cliente") != null) { %>
                <div class="usuario-logueado">
                    <span class="username">
                        <small>Hola,</small> <%= cliente.getNombre()%>
                    </span>
                    <a href="#" class="avatar-link">
                        <img src="<%= avatarUrl%>" alt="Avatar" class="avatar">
                    </a>
                    <div class="dropdown-menu">
                        <a href="${pageContext.request.contextPath}/vista/perfil.jsp"><i class="fa-solid fa-user"></i> Perfil</a>
                        <a href="${pageContext.request.contextPath}/srvReserva?accion=misReservas"><i class="fa-solid fa-ticket"></i> Mis reservas</a>
                        <a href="${pageContext.request.contextPath}/srvUsuario?accion=cerrar" class="logout"><i class="fa-solid fa-arrow-right-from-bracket"></i> Cerrar sesión</a>
                    </div>
                </div>
                <% } else { %>
                <div class="usuario-invitado">
                    <a href="${pageContext.request.contextPath}/vista/iniciarSesion.jsp" class="btn-login">Iniciar Sesión</a>
                </div>
                <% } %>
            </div>

            <% if (session.getAttribute("cliente") != null) { %>
            <div class="carrito">
                <a href="<%=request.getContextPath()%>/vista/car.jsp">
                    <i class="fa-solid fa-cart-shopping"></i>
                </a>
            </div>
            <% } %>
        </div>
    </div>
</header>

<script>
    const menuBtn = document.getElementById('mobile-menu');
    const nav = document.getElementById('navbar');

    menuBtn.addEventListener('click', () => {
        nav.classList.toggle('active');
        // Cambiar icono de hamburguesa a X
        const icon = menuBtn.querySelector('i');
        if (nav.classList.contains('active')) {
            icon.classList.remove('fa-bars');
            icon.classList.add('fa-xmark');
        } else {
            icon.classList.remove('fa-xmark');
            icon.classList.add('fa-bars');
        }
    });
</script>