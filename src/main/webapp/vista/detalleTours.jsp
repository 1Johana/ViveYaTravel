<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Detalle del Tour</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <%--Referenciar los estilos CSS --%>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/detallePaquete.css" rel="stylesheet" type="text/css"/>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    </head>

    <style>
        .estrellas {
            color: #FFD700; /* Color dorado */
            font-size: 1.1rem; /* Tamaño de las estrellas */
            margin-bottom: 15px; /* Espacio debajo */
        }
    </style>

    <%-- Traer header --%>
    <jsp:include page="header.jsp"/>

    <body>

        <!-- Si el detalle existe... -->
        <c:if test="${detalle != null}">

            <div class="detalle-container">
                <h1>${detalle.nombrePaquete}</h1>
                <!-- Sección Hotel -->
                <div class="seccion seccion-hotel">
                    <h2>${detalle.nombreHotel}</h2>
                    <!-- Número de estrellas -->
                    <div class="estrellas">
                        <c:forEach begin="1" end="${detalle.categoriaHotel}">
                            <i class="fa-solid fa-star"></i> 
                        </c:forEach>
                    </div>

                    <img src="${pageContext.request.contextPath}/hoteles/${detalle.imagenHotel}" alt="Foto de ${detalle.nombreHotel}">

                    <h3>Detalles del Hotel:</h3>
                    <c:set var="listaDetalleHotel" value="${fn:split(detalle.detalleHotel, '|')}" />
                    <ul>
                        <c:forEach var="item" items="${listaDetalleHotel}">
                            <li><c:out value="${item}" /></li>
                            </c:forEach>
                    </ul>
                </div>

                <div class="seccion seccion-itinerario">
                    <h2>Itinerario del Viaje</h2>
                    <c:set var="listaItinerario" value="${fn:split(detalle.itinerario, '|')}" />

                    <c:forEach var="dia" items="${listaItinerario}">
                        <p><c:out value="${dia}" /></p>
                    </c:forEach>
                </div>

                <div class="seccion seccion-inclusion">
                    <h2>El Paquete Incluye</h2>
                    <c:set var="listaInclusion" value="${fn:split(detalle.inclusion, '|')}" />
                    <ul>
                        <c:forEach var="item" items="${listaInclusion}">
                            <li><c:out value="${item}" /></li>
                            </c:forEach>
                    </ul>
                </div>
                <!-- mapa de sitio -->   
                <c:url value="https://maps.google.com/maps" var="mapUrl" scope="request">
                    <c:param name="q" value="${detalle.nombrePaquete}" />
                    <c:param name="output" value="embed" />
                    <c:param name="t" value="m" />
                </c:url>

                <div class="seccion seccion-mapa">
                    <h2>Mapa de Sitio</h2>
                    <iframe
                        width="100%" 
                        height="300"
                        frameborder="0" style="border:0;"
                        referrerpolicy="no-referrer-when-downgrade"
                        src="${mapUrl}"
                        allowfullscreen>
                    </iframe>
                </div>

            </div> 
        </c:if>

        <c:if test="${detalle == null}">
            <div class="error-container">
                <h2>Oops!</h2>
                <p>No pudimos encontrar los detalles para este paquete.</p>
                <a href="${pageContext.request.contextPath}/PaqueteControlador">Volver a Tours</a>
            </div>
        </c:if>

    </body>
    <%-- Traer el footer --%>
    <jsp:include page="footer.jsp"/>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>