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

<style>
    @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Open+Sans:wght@400;600&display=swap');

    :root {
        --header-bg: rgba(2, 12, 27, 0.95); /* Azul Oscuro Profundo */
        --color-text: #ffffff;
        --color-accent: #F7B32B; /* Dorado */
        --font-main: 'Montserrat', sans-serif;
    }

    /* Reset del Header */
    .header {
        background-color: var(--header-bg);
        width: 100%;
        height: 80px;
        position: sticky;
        top: 0;
        z-index: 1000;
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        font-family: var(--font-main);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* CONTENEDOR PRINCIPAL (Flexbox que separa Izquierda y Derecha) */
    .contHeader {
        width: 100%;
        max-width: 1280px;
        padding: 0 20px;
        display: flex;
        justify-content: space-between; /* <--- ESTO SEPARA LOS GRUPOS */
        align-items: center;
    }

    /* --- GRUPO IZQUIERDA (Logo + Nav) --- */
    .grupo-izquierda {
        display: flex;
        align-items: center;
        gap: 40px; /* Espacio entre logo y menú */
    }

    .logo a img {
        height: 50px;
        transition: transform 0.3s;
    }
    .logo a img:hover { transform: scale(1.05); }

    .navbar ul.menu {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        gap: 25px;
    }

    .navbar a {
        text-decoration: none;
        color: var(--color-text);
        font-weight: 600;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: 0.3s;
    }
    .navbar a:hover { color: var(--color-accent); }

    /* Dropdown Tours */
    .dropdown-tours { position: relative; }
    .submenu {
        display: none; position: absolute; top: 100%; left: 0;
        background: #fff; min-width: 160px; border-radius: 5px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.2); padding: 5px 0;
    }
    .dropdown-tours:hover .submenu { display: block; }
    .submenu li a { 
        color: #333; display: block; padding: 10px 15px; 
    }
    .submenu li a:hover { background: #f0f0f0; color: #003366; }


    /* --- GRUPO DERECHA (Usuario + Carrito) --- */
    .grupo-derecha {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    /* USUARIO */
    .usuario-logueado a {
        display: flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
        color: var(--color-text);
        cursor: pointer;
    }
    .username { font-size: 14px; font-weight: 700; text-align: right; }
    
    .imagen {
        width: 42px; height: 42px; border-radius: 50%; object-fit: cover;
        border: 2px solid rgba(255,255,255,0.5);
    }

    /* Menú Usuario Desplegable */
    .menu2 { position: relative; list-style: none; margin: 0; padding: 0; }
    .menu2 ul {
        display: none; position: absolute; top: 120%; right: 0;
        background: #fff; min-width: 180px; border-radius: 5px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2); z-index: 1000;
    }
    .menu2:hover ul { display: block; }
    .menu2 ul li a {
        color: #333; padding: 10px 15px; display: flex; align-items: center; gap: 10px; text-decoration: none; font-size: 13px;
    }
    .menu2 ul li a:hover { background: #f4f4f4; color: #003366; }

    /* CARRITO */
    .carro a {
        color: var(--color-text);
        font-size: 20px;
        display: flex; align-items: center; justify-content: center;
        width: 40px; height: 40px;
        background: rgba(255,255,255,0.1);
        border-radius: 50%;
        transition: 0.3s;
    }
    .carro a:hover { background: var(--color-accent); color: #003366; }

    /* BOTÓN LOGIN */
    .btn-login {
        border: 1px solid #fff; padding: 8px 20px; border-radius: 20px; color: #fff; text-decoration: none; font-weight: 600; font-size: 13px; transition: 0.3s;
    }
    .btn-login:hover { background: #fff; color: #003366; }
    
    @media (max-width: 900px) { .navbar { display: none; } }
</style>

<div class="header">
    <div class="contHeader">

        <div class="grupo-izquierda">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/vista/index.jsp">
                    <img src="https://www.viveyatravel.com/imagenes/logo-web-vive-ya-travel-2.png" alt="Logo">
                </a>
            </div>

            <div class="navbar">
                <nav>
                    <ul class="menu">
                        <li class="dropdown-tours">
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
        </div>

        <div class="grupo-derecha">
            
            <div class="usuario-container">
                <% if (session.getAttribute("cliente") != null) { %>
                <ul class="menu2">
                    <li>
                        <div class="usuario-logueado">
                            <a href="#">
                                <span class="username">Hola, <%= cliente.getNombre()%></span>
                                <img class="imagen" src="<%= avatarUrl%>" alt="Avatar" />
                            </a>
                        </div>
                        <ul>
                            <li class="perfil">
                                <a href="${pageContext.request.contextPath}/vista/perfil.jsp"><i class="fa-solid fa-user"></i> Perfil</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/srvReserva?accion=misReservas"><i class="fa-solid fa-ticket"></i> Mis reservas</a>
                            </li>
                            <li class="close">
                                <a href="${pageContext.request.contextPath}/srvUsuario?accion=cerrar"><i class="fa-solid fa-arrow-right-from-bracket"></i> Cerrar sesión</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <% } else { %>
                <div class="usuario">
                    <a href="${pageContext.request.contextPath}/vista/iniciarSesion.jsp" class="btn-login">Iniciar Sesión</a>
                </div>
                <% } %>
            </div>

            <% if (session.getAttribute("cliente") != null) { %>
            <div class="carro">
                <a href="<%=request.getContextPath()%>/vista/car.jsp">
                    <i class="fa-solid fa-cart-shopping"></i>
                </a>
            </div>
            <% } %>
            
        </div> </div>
</div>