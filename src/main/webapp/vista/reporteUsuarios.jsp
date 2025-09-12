<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte de usurios</title>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/reporteUsuarios.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    </head>

    <jsp:include page="ADMIHeader.jsp"/>

    <body>
        
        <a class="ex" href="<%=request.getContextPath()%>/srvReporteUsuarios?accion=excel"><i class="fas fa-file-pdf"></i>Exportar Excel</a>
        <a class="ex" href="<%=request.getContextPath()%>/srvReporteUsuarios?accion=pdf" target="_blank"><i class="fas fa-file-pdf"></i>Exportar PDF</a>

        <table class="tablaRep">
            <thead>
                <tr>
                    <td>ID</td>
                    <td>NOMBRE</td>
                    <td>APELLIDO</td>
                    <td>TELÉFONO</td>
                    <td>DNI</td>
                    <td>CORREO</td>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${repUsuario}">
                    <tr>
                        <td>${u.idUsuario}</td>
                        <td>${u.nombre}</td>
                        <td>${u.apellido}</td>
                        <td>${u.nroCelular}</td>
                        <td>${u.nroDni}</td>
                        <td>${u.correoElectronico}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </body>

    <script>
        var contextPath = "${pageContext.request.contextPath}";
    </script>
    <script src="../js/usua.js" type="text/javascript"></script>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <jsp:include page="footer.jsp"/>
</html>
