<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Promociones</title>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/tours.css" rel="stylesheet" type="text/css"/>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    </head>

    <jsp:include page="header.jsp"/>

    <body>
        <h1 class="tCat">¡Aprovecha nuestras promociones!</h1>
        <div class="tours-layout">
            <form class="filtros-sidebar" action="${pageContext.request.contextPath}/srvPromocion" method="GET">
                <h3><i class="fa-solid fa-filter"></i> FILTROS</h3>

                <div class="filtro-grupo">
                    <label for="nombre">Buscar por nombre:</label>
                    <input type="text" id="nombre" name="nombre" value="${filtroNombre != null ? filtroNombre : ''}" placeholder="Ej: Lima, Ica, Paracas..." class="form-control">
                </div>

                <div class="filtro-grupo">
                    <label for="precio">Precio:</label>
                    <select id="precio" name="precio" class="form-select">
                        <option value="todos" ${filtroPrecio == 'todos' || filtroPrecio == null ? 'selected' : ''}>Todos</option>
                        <option value="100" ${filtroPrecio == '100' ? 'selected' : ''}>Menos de S/100</option>
                        <option value="200" ${filtroPrecio == '200' ? 'selected' : ''}>S/100 - S/200</option>
                        <option value="201" ${filtroPrecio == '201' ? 'selected' : ''}>Más de S/200</option>
                    </select>
                </div>

                <%-- Filtro por Orden --%>
                <div class="filtro-grupo">
                    <label for="orden">Ordenar por:</label>
                    <select id="orden" name="orden" class="form-select">
                        <option value="sin_orden" ${filtroOrden == 'sin_orden' || filtroOrden == null ? 'selected' : ''}>Sin ordenar</option>
                        <option value="precio_asc" ${filtroOrden == 'precio_asc' ? 'selected' : ''}>Precio (más bajo)</option>
                        <option value="precio_desc" ${filtroOrden == 'precio_desc' ? 'selected' : ''}>Precio (más alto)</option>
                        <option value="nombre_asc" ${filtroOrden == 'nombre_asc' ? 'selected' : ''}>Nombre (A-Z)</option>
                    </select>
                </div>

                <%-- Botones --%>
                <button type="submit" class="btn-custom-primary">Aplicar Filtros</button>
                <a href="${pageContext.request.contextPath}/srvPromocion" class="btn-custom-secondary">Limpiar Filtros</a>
            </form>

            <div class="contenedor-paquetes">
                
                <c:forEach var="p" items="${promociones}"> 
                    <div class="tour">
                        <img src="${pageContext.request.contextPath}/paquetes/${p.getImagen()}" alt="lugares"/>
                        <div class="info">
                            
                            <h2 class="tour-nombre">${p.getNombrePaquete()}</h2>
                            <p class="tour-descripcion">${p.getDescripcionPaquete()}</p>
                            <p class="tour-precio">S/.${p.getPrecioPaquete()}</p>
                            
                        </div>
                        <a href="${pageContext.request.contextPath}/srvPromocion?accion=verAsientos&idPaquete=${p.idPaquete}" class="btn-custom-primary">
                            ELEGIR ASIENTO
                        </a>
                    </div> 
                </c:forEach>
                    
            </div> 
        
        </div> 
    </body>

    <jsp:include page="footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>