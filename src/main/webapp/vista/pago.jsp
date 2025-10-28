<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pagar - Resumen</title>
    <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <jsp:include page="header.jsp"/>

    <div class="container mt-4">
        <h3>Resumen de compra</h3>

        <c:if test="${empty sessionScope.carrito}">
            <div class="alert alert-warning">No hay paquetes en el carrito.</div>
        </c:if>

        <c:if test="${not empty sessionScope.carrito}">
            <table class="table table-striped align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Item</th>
                        <th>Paquete</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="subtotal" value="0" scope="page"/>
                    <c:forEach var="p" items="${sessionScope.carrito}" varStatus="s">
                        <tr>
                            <td>${s.index + 1}</td>
                            <td>${p.nombrePaquete}</td>
                            <td>S/. <fmt:formatNumber value="${p.precioPaquete}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                            <td>${p.cantidad}</td>
                            <td>S/. <fmt:formatNumber value="${p.subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                        </tr>
                        <c:set var="subtotal" value="${subtotal + p.subtotal}" scope="page"/>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Datos que llegan del selector -->
            <c:set var="numAsiento" value="${not empty param.numeroAsiento ? param.numeroAsiento : sessionScope.numeroAsiento}" />
            <c:set var="extras" value="${empty param.extrasTotal ? 0 : param.extrasTotal}" />
            <c:set var="seguro" value="${empty param.seguroPrecio ? 0 : param.seguroPrecio}" />
            <c:set var="mascota" value="${empty param.mascotaPrecio ? 0 : param.mascotaPrecio}" />

            <!-- 💺 Mostrar asiento elegido -->
            <div class="alert alert-info">
                <strong>Asiento seleccionado:</strong>
                <c:choose>
                    <c:when test="${not empty numAsiento}">
                        <span class="badge bg-success fs-6">Asiento ${numAsiento}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="text-danger">No se ha seleccionado ningún asiento.</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <!-- Simulación de pago -->
                    <div class="card mb-3 shadow-sm">
                        <div class="card-header bg-primary text-white">Datos de pago (simulado)</div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/srvPromocion" method="post">
                                <input type="hidden" name="accion" value="confirmarPago"/>

                                <!-- Mantener datos para el backend -->
                                <input type="hidden" name="idBus" value="${param.idBus}"/>
                                <input type="hidden" name="idPaquete" value="${param.idPaquete}"/>
                                <input type="hidden" name="idAsiento" value="${param.idAsiento}"/>
                                <input type="hidden" name="numeroAsiento" value="${numAsiento}"/>
                                <input type="hidden" name="seguroPrecio" value="${seguro}"/>
                                <input type="hidden" name="mascotaPrecio" value="${mascota}"/>
                                <input type="hidden" name="extrasTotal" value="${extras}"/>
                                <input type="hidden" name="subtotal" value="${subtotal}"/>
                                <input type="hidden" name="total" value="${subtotal + extras}"/>

                                <div class="mb-3">
                                    <label for="nombreTarjeta" class="form-label">Nombre en la tarjeta</label>
                                    <input type="text" id="nombreTarjeta" name="nombreTarjeta" class="form-control" required/>
                                </div>
                                <div class="mb-3">
                                    <label for="numTarjeta" class="form-label">Número de tarjeta</label>
                                    <input type="text" id="numTarjeta" name="numTarjeta" class="form-control" placeholder="4111 1111 1111 1111" required/>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <label for="exp" class="form-label">Exp.</label>
                                        <input type="text" id="exp" name="exp" class="form-control" placeholder="MM/AA" required/>
                                    </div>
                                    <div class="col">
                                        <label for="cvv" class="form-label">CVV</label>
                                        <input type="text" id="cvv" name="cvv" class="form-control" placeholder="123" required/>
                                    </div>
                                </div>

                                <div class="mt-3 d-flex justify-content-between">
                                    <a href="${pageContext.request.contextPath}/srvPromocion?accion=verCarrito" class="btn btn-secondary">
                                        Volver al carrito
                                    </a>
                                    <button type="submit" class="btn btn-success">
                                        Confirmar pago y reservar asiento
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-dark text-white">Totales</div>
                        <div class="card-body">
                            <p>Subtotal: <strong>S/.
                                <fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong>
                            </p>

                            <p>Extras:
                              <strong>S/. <fmt:formatNumber value="${extras}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong>
                              <small class="text-muted d-block mt-1">
                                <c:if test="${seguro > 0}">Seguro: S/. <fmt:formatNumber value="${seguro}" minFractionDigits="2" maxFractionDigits="2"/> </c:if>
                                <c:if test="${mascota > 0}">Mascota: S/. <fmt:formatNumber value="${mascota}" minFractionDigits="2" maxFractionDigits="2"/></c:if>
                                <c:if test="${extras == 0}">Sin extras seleccionados</c:if>
                              </small>
                            </p>

                            <hr/>
                            <p>Total a pagar:
                              <strong class="text-primary">S/.
                                <fmt:formatNumber value="${subtotal + extras}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                              </strong>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
