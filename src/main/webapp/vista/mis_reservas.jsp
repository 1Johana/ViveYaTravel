<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis reservas</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>
    
    <link href="${pageContext.request.contextPath}/css/header.css?v=5" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <style>
        /* Un pequeño estilo para que el footer no quede flotando */
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .main-container {
            flex-grow: 1; /* Empuja el footer hacia abajo */
        }
    </style>
</head>
<body>

    <jsp:include page="header.jsp"/>

    <div class="container mt-4 main-container">
        <h3 class="mb-3">Mis reservas</h3>

        <c:choose>
            <c:when test="${empty reservas}">
                <div class="alert alert-info">Aún no tienes reservas registradas.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Fecha</th>
                            <th>Paquete</th>
                            <th>Asiento</th>
                            <th>Estado</th>
                            <th class="text-end">Precio</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="r" items="${reservas}" varStatus="s">
                            <tr>
                                <td>${s.index + 1}</td>
                                <td>
                                    <fmt:formatDate value="${r.fechaReserva}" pattern="yyyy-MM-dd HH:mm"/>
                                </td>
                                <td>
                                    <c:out value="${empty r.nombrePaquete ? '—' : r.nombrePaquete}"/>
                                </td>
                                <td>
                                    <c:out value="${empty r.numeroAsiento ? '—' : r.numeroAsiento}"/>
                                </td>
                                <td>
                                    <span class="badge bg-${r.estadoPago == 'PAGADO' ? 'success' : 'secondary'}">
                                        <c:out value="${r.estadoPago}"/>
                                    </span>
                                </td>
                                <td class="text-end">
                                    S/. <fmt:formatNumber value="${r.precioPaquete}" minFractionDigits="2" maxFractionDigits="2"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>