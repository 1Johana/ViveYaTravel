<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Reclamos</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <!-- FontAwesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />

        <!-- SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </head>
    <body>      
        <div class="content" id="content">    
            <div class="table-wrapper table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NOMBRE</th>
                            <th>DNI</th>
                            <th>DIRECCIÓN</th>
                            <th>DISTRITO</th>
                            <th>TELÉFONO</th>
                            <th>CORREO</th>
                            <th>TIPO_BIEN</th>
                            <th>DESCRIPCIÓN_BIEN</th>
                            <th>TIPO_RECLAMO</th>
                            <th>DESCRIPCIÓN_RECLAMO</th>
                            <th>FECHA</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${lista}">
                            <tr>
                                <td>${r.id}</td>
                                <td>${r.nombre}</td>
                                <td>${r.dni}</td>
                                <td>${r.direccion}</td>
                                <td>${r.distrito}</td>
                                <td>${r.telefono}</td>
                                <td>${r.email}</td>
                                <td>${r.tipoBien}</td>
                                <td>${r.descripcionBien}</td>
                                <td>${r.tipoReclamo}</td>
                                <td>${r.detalleReclamo}</td>
                                <td>${r.fecha}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <script src="../js/usua.js" type="text/javascript"></script>
        <script>
            var contextPath = "${pageContext.request.contextPath}";
        </script>

        <!-- Bootstrap Bundle JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <jsp:include page="ADMIVista.jsp"/>
    </body>
</html>
