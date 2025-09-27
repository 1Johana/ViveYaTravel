<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Carrito</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
    <h1>Tu Carrito</h1>

    <!-- Si no hay paquetes en el carrito -->
    <c:if test="${empty sessionScope.carrito}">
        <p>No tienes paquetes en tu carrito.</p>
    </c:if>

    <!-- Si hay paquetes en el carrito -->
    <c:if test="${not empty sessionScope.carrito}">
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Paquete</th>
                    <th>Descripción</th>
                    <th>Precio</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${sessionScope.carrito}">
                    <tr>
                        <td>${c.nombrePaquete}</td>
                        <td>${c.descripcionPaquete}</td>
                        <td>S/. ${c.precioPaquete}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>
