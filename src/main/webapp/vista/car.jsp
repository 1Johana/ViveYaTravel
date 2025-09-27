<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrito</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/carrusel.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="container mt-4">
            <h3>Carrito</h3>
            <div class="row">
                <div class="col-sm-8">

                    <!-- Inicializo total para que siempre exista -->
                    <c:set var="total" value="0" scope="page"/>

                    <c:if test="${empty sessionScope.carrito}">
                        <p>No tienes paquetes en tu carrito.</p>
                    </c:if>

                    <c:if test="${not empty sessionScope.carrito}">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ITEM</th>
                                    <th>NOMBRE</th>
                                    <th>PRECIO</th>
                                    <th>CANTIDAD</th>
                                    <th>SUBTOTAL</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="car" items="${sessionScope.carrito}" varStatus="i">
                                    <tr>
                                        <td>${i.index + 1}</td>
                                        <td>${car.nombrePaquete}</td>
                                        <td>
                                            S/. 
                                            <fmt:formatNumber value="${car.precioPaquete}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                        </td>
                                        <td>${car.cantidad}</td>
                                        <td>
                                            S/. 
                                            <fmt:formatNumber value="${car.subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                        </td>
                                    </tr>

                                    <!-- acumular total -->
                                    <c:set var="total" value="${total + car.subtotal}" scope="page"/>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>

                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-header">
                            <h3>Generar compra</h3>
                        </div>
                        <div class="card-body">
                            <label>Total:</label>
                            <input type="text" readonly class="form-control" 
                                   value="S/. <fmt:formatNumber value='${total}' type='number' minFractionDigits='2' maxFractionDigits='2'/>">
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-info btn-block">Realizar Pago</a>
                            <a href="#" class="btn btn-danger btn-block">Generar Compra</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
