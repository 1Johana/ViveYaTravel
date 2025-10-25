<!-- Improved Admin Tours JSP with Bootstrap & SweetAlert (Starting Template) -->
<!-- We will progressively enhance styling, layout and scripts -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <style>
            body {
                background-color: #f4f6f9;
            }
            .card-header {
                background-color: #0d6efd !important;
            }
            .btn-success {
                background-color: #198754;
            }
            .btn-info {
                background-color: #0dcaf0;
            }
            .card {
                border: none;
                border-radius: 10px;
            }
            .card img {
                height: 220px;
                object-fit: cover;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
            }
            .btn-warning {
                color: white;
            }
            .btn-warning:hover {
                background-color: #d39e00;
            }
        </style>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Tours - Administrador</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body class="bg-light">

        <jsp:include page="ADMIVista.jsp"/>

        <style>
            /* Ajuste cuando la barra lateral se oculta */
            .content {
                margin-left: 250px;
                transition: margin-left 0.3s;
            }
            .hidden-sidebar ~ .content {
                margin-left: 0 !important;
            }
            .btn {
                background: #6495ED;
                color: #f4f6f9;
            }
        </style>

        <script>
            // Detectamos si la barra lateral existe para sincronizar con este contenido
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
            <div class="container py-4">
                <!-- Formulario -->
                <div class="card shadow-sm mb-4">
                    <!--<div class="card-header bg-gradient-primary text-white fw-bold">Registrar nuevo paquete</div> -->
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/srvADMIPaquete" method="post" enctype="multipart/form-data" id="formPaquetes" class="row g-3">
                            <div class="col-md-2">
                                <label class="form-label">ID</label>
                                <input type="text" name="idPaquete" class="form-control" value="${idPaquete}" readonly>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Imagen</label>
                                <input type="file" name="imagen" class="form-control" accept="image/*" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Nombre</label>
                                <input type="text" name="nombrePaquete" class="form-control" value="${nombrePaquete}" required>
                            </div>
                            <div class="col-md-8">
                                <label class="form-label">Descripción</label>
                                <input type="text" name="descripcionPaquete" class="form-control" value="${descripcionPaquete}" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Precio (S/.)</label>
                                <input type="number" step="0.01" name="precioPaquete" class="form-control" value="${precioPaquete}" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Categoría</label>
                                <select name="categoria" class="form-select">
                                    <option value="T">Tours</option>
                                    <option value="P">Promoción</option>
                                </select>
                            </div>
                            <div class="col-md-8">
                                <label class="form-label">Detalle</label>
                                <textarea name="detallePaquete" class="form-control" rows="2">${detallePaquete}</textarea>
                            </div>
                            <div class="text-end">
                                <button type="submit" class="btn" name="accion" value="Registrar"><i class="fa-solid fa-plus-circle"></i> Registrar</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- TABLA DE PAQUETES INICIO -->
                <div class="table-responsive mt-4">
                    <table class="table table-bordered table-hover table-striped text-center">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Precio</th>
                                <th>Imagen</th>
                                <th>Categoría</th>
                                <th>Detalle</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="paq" items="${paquetes}">
                                <tr>
                                    <td>${paq.idPaquete}</td>
                                    <td>${paq.nombrePaquete}</td>
                                    <td>${paq.descripcionPaquete}</td>
                                    <td>${paq.precioPaquete}</td>
                                    <td><img src="paquetes/${paq.imagen}" alt="Imagen" width="80"></td>
                                    
                                    <td>${paq.categoria}</td>
                                    <td>
                                        <div style="
                                             max-width: 220px;
                                             white-space: nowrap;
                                             overflow: hidden;
                                             text-overflow: ellipsis;
                                             font-size: 14px;
                                             color: #333;
                                             ">
                                            ${paq.detallePaquete}
                                        </div>
                                    </td>

                                    <td>
                                        <a href="srvADMIPaquete?accion=edit&id=${paq.idPaquete}" class="btn btn-outline-primary btn-sm" title="Editar"><i class="fa-solid fa-pen-to-square"></i></a>
                                        <a href="srvADMIPaquete?accion=delete&id=${paq.idPaquete}" class="btn btn-outline-danger btn-sm" title="Eliminar" onclick="return confirm('¿Desea eliminar este paquete?')"><i class="fa-solid fa-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- TABLA DE PAQUETES FIN -->
    </body>
</html>
