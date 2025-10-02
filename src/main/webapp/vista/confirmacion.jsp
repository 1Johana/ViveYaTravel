<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirmación</title>
    <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <jsp:include page="header.jsp"/>

    <div class="container mt-4">
        <h3>Pago confirmado</h3>

        <div class="alert alert-success">
            <strong>¡Pago simulado exitoso!</strong><br/>
            Orden: <strong>${sessionScope.orderId}</strong><br/>
            Total pagado: <strong>S/. <fmt:formatNumber value='${sessionScope.totalPagado}' type='number' minFractionDigits='2' maxFractionDigits='2'/></strong>
        </div>

        <h5>Detalle de la compra</h5>
        <c:if test="${empty sessionScope.compraReciente}">
            <p>No se encontró información de la compra.</p>
        </c:if>

        <c:if test="${not empty sessionScope.compraReciente}">
            <table class="table">
                <thead>
                    <tr><th>Item</th><th>Paquete</th><th>Cantidad</th><th>Subtotal</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${sessionScope.compraReciente}" varStatus="s">
                        <tr>
                            <td>${s.index + 1}</td>
                            <td>${p.nombrePaquete}</td>
                            <td>${p.cantidad}</td>
                            <td>S/. <fmt:formatNumber value="${p.subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">Volver al inicio</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
