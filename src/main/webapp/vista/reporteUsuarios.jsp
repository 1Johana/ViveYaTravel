<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reporte de Usuarios</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        /* Contenido y tabla */
        .content {
            margin-left: 250px;
            transition: margin-left 0.3s;
            padding: 20px;
        }
        .hidden-sidebar ~ .content {
            margin-left: 0 !important;
        }
        .table-wrapper {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.1);
        }
        .table thead {
            background-color: #0d6efd;
            color: #fff;
        }
        .ex {
            margin-right: 10px;
        }
        .btn-export {
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <jsp:include page="ADMIVista.jsp"/>
    
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const sidebar = document.getElementById("sidebar");
            const content = document.getElementById("content");
            const toggleButton = document.getElementById("toggleSidebar");
            const navbar = document.getElementById("navbar");

            if (toggleButton) {
                toggleButton.addEventListener("click", () => {
                    sidebar.classList.toggle("hidden-sidebar");
                    if (sidebar.classList.contains("hidden-sidebar")) {
                        content.style.marginLeft = "0";
                        navbar.style.marginLeft = "0";
                    } else {
                        content.style.marginLeft = "250px";
                        navbar.style.marginLeft = "250px";
                    }
                });
            }
        });
    </script>

    <div class="content" id="content">    
        <div class="d-flex justify-content-end btn-export">
            <a class="btn btn-success me-2" href="<%=request.getContextPath()%>/srvReporteUsuarios?accion=excel">
                <i class="fas fa-file-excel"></i> Exportar Excel
            </a>
            <a class="btn btn-danger" href="<%=request.getContextPath()%>/srvReporteUsuarios?accion=pdf" target="_blank">
                <i class="fas fa-file-pdf"></i> Exportar PDF
            </a>
        </div>

        <div class="table-wrapper table-responsive">
            <table class="table table-striped table-hover table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOMBRE</th>
                        <th>APELLIDO</th>
                        <th>TELÉFONO</th>
                        <th>DNI</th>
                        <th>CORREO</th>
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
        </div>
    </div>

    <script>
        var contextPath = "${pageContext.request.contextPath}";
    </script>
    <script src="../js/usua.js" type="text/javascript"></script>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
