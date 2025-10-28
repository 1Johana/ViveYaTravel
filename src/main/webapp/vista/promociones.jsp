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

            <!-- ====== INICIO FOR EACH ====== -->
            <c:forEach var="o" items="${promociones}">
                <div class="tour mb-4">
                    <img src="${pageContext.request.contextPath}/paquetes/${o.imagen}"
                         alt="${o.nombrePaquete}" class="img-fluid"/>

                    <div class="info mt-2">
                        <h2>${o.nombrePaquete}</h2>
                        <p>${o.descripcionPaquete}</p>
                        <div class="precio">
                            <p>S/. ${o.precioPaquete}</p>
                        </div>
                    </div>

                    <!-- Botón que abre modal -->
                    <button type="button" class="btn btn-primary"
                            data-bs-toggle="modal"
                            data-bs-target="#exampleModal${o.idPaquete}">
                        Ver Detalle
                    </button>

                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal${o.idPaquete}" tabindex="-1"
                         aria-labelledby="exampleModalLabel${o.idPaquete}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5"
                                        id="exampleModalLabel${o.idPaquete}">
                                        ${o.nombrePaquete}
                                    </h1>
                                    <button type="button" class="btn-close"
                                            data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                </div>

                                <div class="modal-body">
                                    <div class="bloque-puntos-de-recojo mb-3">
                                        <div class="texto-descripcion texto-descripcion-itinerario">
                                            <span class="numero">Puntos de abordo</span>
                                        </div>

                                        <div class="puntos">
                                            <div class="punto1">
                                                <div class="bloque-recojo">
                                                    <div class="titulo-recojo">C.C. PLAZA NORTE</div>
                                                    <div class="direccion-recojo">Tomas Valle con P. Norte</div>
                                                    <div class="direccion-recojo">Ingreso Principal</div>
                                                </div>
                                            </div>

                                            <div class="punto2">
                                                <div class="bloque-recojo">
                                                    <div class="titulo-recojo">C.C. LA RAMBLA</div>
                                                    <div class="direccion-recojo">Av. Javier Prado Este 2050</div>
                                                    <div class="direccion-recojo">Ref. Puerta de Wong</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="tourDetalle${o.idPaquete}">
                                        ${o.detallePaquete}
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Cerrar</button>


                                    <!-- BOTÓN CORRECTO PARA ELEGIR ASIENTO -->
                                 <button type="button"
        class="btn btn-success"
        onclick="window.location.href='${pageContext.request.contextPath}/srvPromocion?accion=verAsientos&idPaquete=${o.idPaquete}&precioPaquete=${o.precioPaquete}&nombrePaquete=${o.nombrePaquete}';">
    Elegir Asiento
</button>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <!-- ====== FIN FOR EACH ====== -->

        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
