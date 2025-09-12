<%@page import="com.mycompany.viveyatravel.modelo.dto.usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header>
    <link href="${pageContext.request.contextPath}/css/carrusel.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <div class="header">
<div class="contHeader">
    <div class="logo">
        <a href="vista/ADMIndex.jsp"><img src="https://www.viveyatravel.com/imagenes/logo-web-vive-ya-travel-2.png" class="logo"></a>
    </div>
    <div class="navbar">
        <nav>
            <ul class="menu">
                <!--Para encontrar la ruta request.getContextPath()%> -->
                <li><a href="<%=request.getContextPath()%>/srvADMIPaquete">PAQUETES</a></li>
                <li><a href="<%=request.getContextPath()%>/reporteUsuarios">USUARIOS</a></li>
                <li><a href="<%=request.getContextPath()%>/reporteUsuarios">VENTAS</a></li>
                <li><a href="${pageContext.request.contextPath}/vista/nosotros.jsp">NOSOTROS</a></li>
            </ul>
        </nav>
    </div>

    <div class="usuario-container">
        <p class="bienvenido">
            <% 
                usuario admin = (usuario) session.getAttribute("admin");
                if (admin != null) {
                    out.print("Hola " + admin.getCargo().getNombreCargo());
                } else {
                    out.print("Bienvenido invitado");
                }
            %>
        </p>
        <div class="usuario">
            <% if (admin != null) { %>
                <a href="${pageContext.request.contextPath}/srvUsuario?accion=cerrar"><i class="fa-solid fa-right-to-bracket cerrar"></i></a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/vista/iniciarSesion.jsp"><i class="fa-solid fa-user usuario"></i></a>
            <% } %>
        </div>
    </div>
</div>
</div>
</header>

