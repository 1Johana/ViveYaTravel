<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrito</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/carrusel.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="styles.css" />
        <script src="//code.tidio.co/5al8l06rqcmi3eecttdrth0mcufr1dhb.js" async></script>
    </head>
    <body>
        <jsp:include page="header.jsp"/>  

        <div class="container mt-4">
            <h3>Carrito</h3>
            <div class="row">
                <div class="col-sm-8">
                    <c:if test="${empty sessionScope.carrito}">
                        <p>No tienes paquetes en tu carrito.</p>
                    </c:if>
                    <c:if test="${not empty sessionScope.carrito}">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">ITEM</th>                           
                                    <th scope="col">NOMBRE</th>
                                    <th scope="col">PRECIO</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="car" items="${sessionScope.carrito}" varStatus="i">
                                    <tr>
                                        <td>${i.index + 1}</td>                               
                                        <td>${car.nombrePaquete}</td>
                                        <td>S/. ${car.precioPaquete}</td>
                                    </tr>
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
                            <label>Subtotal:</label>
                            <input type="text" readonly="" class="form-control"> 
                            <label>Descuento:</label>
                            <input type="text" readonly="" class="form-control"> 
                            <label>Pagar:</label>
                            <input type="text" readonly="" class="form-control"> 
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-info btn-block">Realizar Pago</a>                        
                            <a href="#" class="btn btn-danger btn-block">Generar Compra</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    </body>
</html>
