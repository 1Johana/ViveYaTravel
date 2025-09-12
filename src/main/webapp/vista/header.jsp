<%@page import="com.mycompany.viveyatravel.modelo.dto.usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<header>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/headerValidacionUsuario.css" rel="stylesheet" type="text/css"/>
    <div class="header">
        <div class="contHeader">
            <div class="logo">
                <a href="index.jsp"><img src="https://www.viveyatravel.com/imagenes/logo-web-vive-ya-travel-2.png" class="logo"></a>
            </div>
            <div class="navbar">
                <nav>
                    <ul class="menu">
                        <!--Para encontrar la ruta request.getContextPath()%> -->
                        <li><a href="<%=request.getContextPath()%>/PaqueteControlador">TOURS</a></li>
                        <li><a href="<%=request.getContextPath()%>/srvPromocion">PROMOCIONES</a></li>
                        <li><a href="${pageContext.request.contextPath}/vista/nosotros.jsp">NOSOTROS</a></li>
                    </ul>
                </nav>
            </div>
            <div class="carro">
                <a href="<%=request.getContextPath()%>/vista/car.jsp"><img class="carrito"/><i class="fa-solid fa-cart-shopping carrito"></i></a>
            </div>
            <div class="usuario-container">
                <!--Cuando entra un usuario se carga esta seccion -->
                <%
                    usuario cliente = (usuario) session.getAttribute("cliente");
                    if (cliente != null) {
                %>
                <ul class="menu2">
                    <li><a href="#">
                            <p class="username">
                                <%
                                    out.print("Hola, " + cliente.getNombre());
                                %>
                            </p>
                            <img class="imagen" src="${pageContext.request.contextPath}/img/user.png" alt=""/>
                            <i class="fa-solid fa-chevron-down" style="color: #fff"></i></a>
                        <ul>
                            <li>
                                <div class="boton-modal">
                                    <label for="btn-modal">
                                        Editar perfil
                                    </label>
                                </div>
                            </li>
                            <li class="close"><a href="${pageContext.request.contextPath}/srvUsuario?accion=cerrar"><i class="fa-solid fa-arrow-right-from-bracket"></i> Cerrar sesión</a></li>
                        </ul>
                    </li>
                </ul>
                <%
                } else {
                %>
                <!--En caso contrario de no haber iniciado sesion -->
                <p class="bienvenido">
                    <% out.print("Bienvenido invitado"); %> 
                </p>
                <div class="usuario">
                    <a href="${pageContext.request.contextPath}/vista/iniciarSesion.jsp"><i class="fa-solid fa-user usuario"></i></a>
                </div>
                <% }%>
            </div>
        </div>
    </div>
            <%if (cliente != null) {%>
    <input type="checkbox" id="btn-modal">
    <div class="container-modal">
        <div class="content-modal">
            <!--<h2>Editar Perfil</h2>-->
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
        <%}%>
    </div>
</header>
