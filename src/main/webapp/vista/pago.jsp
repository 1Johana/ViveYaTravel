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
            <table class="table">
                <thead>
                    <tr>
                        <th>Item</th><th>Paquete</th><th>Precio</th><th>Cantidad</th><th>Subtotal</th>
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

            <div class="row">
                <div class="col-md-6">
                    <!-- Simulamos ingreso de datos de pago (no reales) -->
                    <div class="card mb-3">
                        <div class="card-header">Datos de pago (simulado)</div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/srvPago" method="post">
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

                                <!-- campos ocultos: subtotal (por si quieres enviarlo) -->
                                <input type="hidden" name="subtotal" value="${subtotal}"/>

                                <div class="mt-3">
                                    <a href="${pageContext.request.contextPath}/srvPromocion?accion=verCarrito" class="btn btn-secondary">Volver al carrito</a>
                                    <button type="submit" class="btn btn-primary">Confirmar pago (simulado)</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">Totales</div>
                        <div class="card-body">
                            <p>Subtotal: <strong>S/. <fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong></p>
                            <p>Descuento: <strong>S/. 0.00</strong></p>
                            <hr/>
                            <p>Total a pagar: <strong>S/. <fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong></p>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
