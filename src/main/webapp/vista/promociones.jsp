<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Promociones</title>
    <%-- Referenciar los estilos CSS --%>
    <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/tours.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
</head>
<body>
    <jsp:include page="header.jsp"/>

    <div class="container mt-4">
        <h1 class="tCat">¡Aprovecha las promociones!</h1>

        <div class="contenedor">
            <div class="contenedor-paquetes">
                <!-- Promociones -->
                <c:forEach var="o" items="${promociones}">
                    <div class="tour mb-4">
                        <!-- Datos del paquete -->
                        <img src="${pageContext.request.contextPath}/paquetes/${o.imagen}" alt="${o.nombrePaquete}" class="img-fluid"/>
                        <div class="info mt-2">
                            <h2>${o.nombrePaquete}</h2>
                            <p>${o.descripcionPaquete}</p>
                            <div class="precio">
                                <p>S/. ${o.precioPaquete}</p>
                            </div>
                        </div>

                        <!-- Botón que abre modal único por paquete -->
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                data-bs-target="#exampleModal${o.idPaquete}">
                            Ver Detalle
                        </button>

                        <!-- Modal (único por paquete) -->
                        <div class="modal fade" id="exampleModal${o.idPaquete}" tabindex="-1"
                             aria-labelledby="exampleModalLabel${o.idPaquete}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel${o.idPaquete}">
                                            ${o.nombrePaquete}
                                        </h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Puntos de recojo (puedes mantener tu contenido original aquí) -->
                                        <div class="bloque-puntos-de-recojo mb-3">
                                            <div class="texto-descripcion texto-descripcion-itinerario">
                                                <span class="numero">Puntos de abordo</span>
                                            </div>
                                            <div class="puntos">
                                                <div class="punto1">
                                                    <a class="ubicacion-icono" href="https://www.google.com.pe/maps/dir/-12.0269735,-76.9621988/Unnamed+Road,+Independencia" target="_blank">.</a>
                                                    <div class="bloque-recojo">
                                                        <div class="titulo-recojo">C.C. PLAZA NORTE</div>
                                                        <div class="direccion-recojo">Tomas Valle con P. Norte</div>
                                                        <div class="direccion-recojo">Ingreso Principal</div>
                                                    </div>
                                                </div>

                                                <div class="punto2">
                                                    <a class="ubicacion-icono" href="https://www.google.com.pe/maps/dir/-12.0269972,-76.9621752/Jr.+Ucello+100-162,+Cercado+de+Lima+15036" target="_blank">.</a>
                                                    <div class="bloque-recojo">
                                                        <div class="titulo-recojo">C.C. LA RAMBLA</div>
                                                        <div class="direccion-recojo">Av. Javier Prado Este 2050</div>
                                                        <div class="direccion-recojo">Ref. Puerta de Wong</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Detalle del paquete -->
                                        <div id="tourDetalle${o.idPaquete}">
                                            ${o.detallePaquete}
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>

                                        <!-- Form que envía el id correcto al servlet -->
                                        <form action="${pageContext.request.contextPath}/srvPromocion" method="post" style="display:inline;">
                                            <input type="hidden" name="accion" value="agregar"/>
                                            <input type="hidden" name="idPaquete" value="${o.idPaquete}"/>
                                            <button type="submit" class="btn btn-primary">Reservar</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- /modal -->
                    </div> <!-- /tour -->
                </c:forEach>
            </div> <!-- /contenedor-paquetes -->
        </div> <!-- /contenedor -->
    </div> <!-- /container -->

    <jsp:include page="footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</body>
</html>
