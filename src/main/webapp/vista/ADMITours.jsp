<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Tours - Administrador</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>
            /* Paleta de colores de Vive Ya Travel (Asumidos aquí para simpleza) */
            :root {
                --viveya-darkblue: #044B87;
                --viveya-mediumblue: #0660B0;
                --viveya-red: #dc3545;
            }
            .content {
                margin-left: 250px;
                transition: margin-left 0.3s;
            }
            .card-header {
                background-color: var(--viveya-darkblue) !important;
                color: white;
            }
            .btn {
                background: var(--viveya-mediumblue);
                color: white;
                border-color: var(--viveya-mediumblue);
            }
            .btn:hover {
                background: var(--viveya-darkblue);
                border-color: var(--viveya-darkblue);
            }
            .btn-outline-primary {
                color: var(--viveya-mediumblue);
                border-color: var(--viveya-mediumblue);
            }
            .btn-outline-primary:hover {
                background-color: var(--viveya-mediumblue);
                color: white;
            }
            .btn-outline-danger {
                color: var(--viveya-red);
                border-color: var(--viveya-red);
            }
            .btn-outline-danger:hover {
                background-color: var(--viveya-red);
                color: white;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="content" id="content">
            <div class="container py-4">
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/srvADMIPaquete" method="post" enctype="multipart/form-data" id="formPaquetes" class="row g-3">
                            <div class="col-md-2">
                                <label class="form-label">ID</label>
                                <input type="text" name="idPaquete" class="form-control" value="${idPaquete}" readonly>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Imagen</label>
                                <input type="file" name="imagen" class="form-control" accept="image/*" ${empty idPaquete ? 'required' : ''}>
                                <c:if test="${not empty imagen}">
                                    <small class="text-muted">Imagen actual: ${imagen}</small>
                                </c:if>
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
                            <div class="col-12 text-end">
                                <button type="submit" class="btn btn-primary" name="accion" value="${empty idPaquete ? 'Registrar' : 'Registrar'}">
                                    <i class="fa-solid fa-${empty idPaquete ? 'plus-circle' : 'save'}"></i> ${empty idPaquete ? 'Registrar' : 'Actualizar'}
                                </button>
                                <c:if test="${not empty idPaquete}">
                                    <a href="${pageContext.request.contextPath}/srvADMIPaquete" class="btn btn-outline-secondary">Cancelar</a>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>

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
                                        <div style="max-width: 220px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 14px; color: #333;">
                                            ${paq.detallePaquete}
                                        </div>
                                    </td>
                                    <td>
                                        <a href="srvADMIPaquete?accion=edit&id=${paq.idPaquete}" class="btn btn-outline-primary btn-sm" title="Editar"><i class="fa-solid fa-pen-to-square"></i></a>
                                        <button type="button" class="btn btn-outline-danger btn-sm" title="Eliminar" onclick="confirmarEliminar(${paq.idPaquete})">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            // 1. FUNCIÓN PARA DISPARAR SWEETALERT DE CONFIRMACIÓN
            function confirmarEliminar(id) {
                Swal.fire({
                    title: '¿Estás seguro?',
                    text: "¡El paquete será eliminado de forma permanente!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#dc3545',
                    cancelButtonColor: '#044B87',
                    confirmButtonText: 'Sí, ¡Eliminar!',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Redirige al Servlet para la acción de eliminación
                        window.location.href = 'srvADMIPaquete?accion=delete&id=' + id;
                    }
                });
            }
        </script>
        <jsp:include page="ADMIVista.jsp"/>
    </body>
</html>