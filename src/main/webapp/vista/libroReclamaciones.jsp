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
        <img src="${pageContext.request.contextPath}/img/libima.jpg" alt="Fondo libro" class="full-page-background">
        <!-- 🟢 ALERTA DE ÉXITO -->
        <div class="alert-messages">
            <c:if test="${not empty mensaje}">
                <div class="alert alert-success custom-alert" id="alertaExito" role="alert">
                    <strong>¡Listo!</strong> ${mensaje}
                </div>
            </c:if>
        </div>
             <!-- 🔴 Mensaje de error si algo no pasa la validación del backend -->
            <c:if test="${not empty error}">
                <p style="color:red; font-weight:bold; text-align:center;">
                    ${error}
                </p>
            </c:if>
        <div class="libro-container">
            <div class="libro-contenido">
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
                        <!-- 🧩 Validación: solo números para DNI -->
                        <input type="text" name="dni" placeholder="N° de documento de identidad"
                               required maxlength="8" pattern="[0-9]+"
                               title="Solo se permiten números"
                               oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                        <input type="text" name="direccion" placeholder="Dirección">
                    </div>
                    <div class="form-row">
                        <input type="text" name="distrito" placeholder="Distrito / Provincia / Departamento">
                         <!-- 🧩 Validación: solo números para teléfono -->
                         <!-- Teléfono solo números (9 dígitos exactos) -->
                        <input type="text" name="telefono" placeholder="Teléfono de contacto"
                               maxlength="9" minlength="9"
                               pattern="^[0-9]{9}$"
                               title="Debe contener exactamente 9 números"
                               oninput="this.value = this.value.replace(/[^0-9]/g, '')">
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
        </div>
        <jsp:include page="footer.jsp"/>
                        
<!-- 🕒 Script para ocultar la alerta después de 3 segundos -->
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const alerta = document.getElementById("alertaExito");
        if (alerta) {
            setTimeout(() => {
                alerta.style.transition = "opacity 0.8s ease, transform 0.8s ease";
                alerta.style.opacity = "0";
                alerta.style.transform = "translateY(-10px)";
                setTimeout(() => alerta.remove(), 900);
            }, 3000);
        }
    });
</script>
        
    </body>
</html>