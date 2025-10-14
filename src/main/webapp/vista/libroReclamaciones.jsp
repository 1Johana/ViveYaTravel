<%-- 
    Document   : libroReclamaciones
    Created on : 7 may. 2024, 19:13:01
    Author     : Yenifer
--%>

<%@page contentType="text/html;  charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Libro de reclamaciones</title>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/LibrodeReclamaciones.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/LibrodeReclamaciones.css?v=2" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="libro-container">
            <h1 class="libro-title">Libro de Reclamaciones</h1>
            <p class="libro-info">
                Conforme a lo establecido en la Ley N°29571 del código de la Protección y Defensa del consumidor puedes ingresar en nuestro Libro de Reclamaciones tus quejas o reclamos.
            </p>
            <!-- Formulario -->
            <form id="formReclamo" action="${pageContext.request.contextPath}/reclamaciones" method="post">
                <input type="hidden" name="accion" value="Registrar">
                <!-- Identificación del consumidor reclamante -->
                <fieldset>
                    <legend>Identificación del consumidor reclamante</legend>
                    <div class="form-row">
                        <input type="text" name="nombre" placeholder="Nombre y Apellidos" required>
                        <input type="text" name="dni" placeholder="N° de documento de identidad" required>
                        <input type="text" name="direccion" placeholder="Dirección">
                    </div>
                    <div class="form-row">
                        <input type="text" name="distrito" placeholder="Distrito / Provincia / Departamento">
                        <input type="text" name="telefono" placeholder="Teléfono de contacto">
                        <input type="email" name="email" placeholder="Correo electrónico">
                    </div>
                </fieldset>
                <!-- Identificación del bien contratado -->
                <fieldset>
                    <legend>Detalle del reclamo o queja</legend>
                    <div class="form-row">
                        <select name="tipo_bien" class="select-corto" required>
                            <option value="" disabled selected>Tipo de Bien</option>
                            <option>Producto</option>
                            <option>Servicio</option>
                        </select>
                        <textarea name="descripcion_bien" rows="4" placeholder="Descripción del producto o servicio" required class="descripcion-bien"></textarea>
                    </div>
                </fieldset>
                <!-- Detalle de la reclamación -->
                <fieldset>
                    <legend>Detalle de la reclamación</legend>
                    <div class="form-row">
                        <select name="tipo_reclamo" class="select-corto" required>
                            <option value="" disabled selected>Tipo de reclamación</option>
                            <option>Reclamo</option>
                            <option>Queja</option>
                        </select>
                        <textarea name="detalle_reclamo" rows="4" placeholder="Detalle del reclamo o queja" required class="detalle-del-reclamo-o-queja"></textarea>
                    </div>
                </fieldset>
                <!-- Botón -->
                <div class="text-center">
                    <button type="submit" class="btn btn-enviar">Enviar reclamo</button>
                </div>
            </form>
            <p class="libro-legal-text">
                En cumplimiento de lo dispuesto por el Decreto Supremo 011 – 2011 – PCM que aprueba el Reglamento del Libro de Reclamaciones, Vive Ya Travel pone a disposición del usuario el presente libro virtual de reclamaciones, en el que pueden registrar sus quejas y reclamos formales sobre los servicios ofrecidos por Vive Ya Travel y sus establecimientos asociados.
            </p>
        </div>
                    <!-- Modal de éxito -->
        <div id="modalExito" class="modal-exito">
            <div class="modal-contenido">
                <div class="icono-exito">✔</div>
                <p>ENVÍO EXITOSO</p>
            </div>
        </div>

        <!-- Script para mostrar modal -->
        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const form = document.getElementById("formReclamo");
                const modal = document.getElementById("modalExito");

                form.addEventListener("submit", function(e) {
                    e.preventDefault(); // Evita recargar la página

                    fetch(this.action, {
                        method: this.method,
                        body: new FormData(this)
                    })
                    .then(response => {
                        if (response.ok) {
                            // Mostrar el modal
                            modal.classList.add("visible");

                            // Ocultar el modal y resetear el formulario
                            setTimeout(() => {
                                modal.classList.remove("visible");
                                form.reset();
                            }, 3000);
                        } else {
                            console.error("Error al enviar el reclamo.");
                        }
                    })
                    .catch(error => console.error("Error:", error));
                });
            });
        </script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>