<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- Importación de biblioteca de etiquetas JSTL -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tours</title>
        <%--Referenciar los estilos CSS --%>
         <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/tours.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>

    <%-- Traer header --%>
    <jsp:include page="ADMIHeader.jsp"/>

    <body>
        <h1 class="tCat">Crea recuerdos...</h1>

        <!-- Formulario para añadir nuevos tours -->
        <form action="<%= request.getContextPath()%>/srvADMIPaquete" method="post" class="formulario" id="formPaquetes">
            <fieldset>
                <label>ID</label>
                <input type="text" name="idPaquete" value="${idPaquete}" readonly/>
                <label>Imagen</label>
                <input type="text" name="imagen" value="${imagen}"/>
                <label>Nombre</label>
                <input type="text" name="nombrePaquete" value="${nombrePaquete}"/>
                <label>Descripción</label>
                <input type="text" name="descripcionPaquete" value="${descripcionPaquete}"/>
                <label>Precio</label>
                <input type="text" name="precioPaquete" value="${precioPaquete}"/>
                <label>Categoría</label>
                <select name="categoria">
                    <option value="T" name="categoria">Tours</option>
                    <option value="P" name="categoria">Promoción</option>
                </select>
                <!-- comment <input type="text" name="categoria" value=""/> -->
                <label>Detalle</label>
                <input type="text" name="detallePaquete" value="${detallePaquete}"/>

                <input type="submit"  value="Registrar" name="accion"/>
            </fieldset>
        </form>


        <div class="contenedor">
            <div class="contenedor-paquetes">
                <!--Paquetes-->               

                <c:forEach var="tur" items="${paquetes}"> <!--Bucle para recorrer la lista-->
                    
                    <div class="tour">  <!-- Contenedor -->
                       
                        <img src="${pageContext.request.contextPath}/paquetes/${tur.getImagen()}" alt="lugares"/>
                        <div class="info">
                            <!-- Para obtener los datos -->
                            <h2>${tur.getNombrePaquete()}</h2> 
                            <p>${tur.getDescripcionPaquete()}</p>
                            <div class="precio">
                                <p>S/.${tur.getPrecioPaquete()}</p>
                            </div>
                        </div>
                        <!-- Boton modal -->
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal"
                                data-Titulo="${tur.getNombrePaquete()}"
                                data-Detalle="${tur.getDetallePaquete()}">
                            Ver Detalle
                        </button>
                        <!--Modal--> 
                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog ">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                                            <span id="tourTitulo">
                                                ${tur.getNombrePaquete()}
                                            </span>
                                        </h1>
                                    </div>
                                    <div class="modal-body">

                                        <!<!-- Puntos de recojo -->
                                        <div class="bloque-puntos-de-recojo">
                                            <div class="texto-descripcion texto-descripcion-itinerario">
                                                <span class="numero">Puntos de abordo</span>
                                            </div>
                                            <div class="puntos">
                                                <div class="punto1"><a class="ubicacion-icono" href="https://www.google.com.pe/maps/dir/-12.0269735,-76.9621988/Unnamed+Road,+Independencia/@-12.025523,-77.0290547,14z/data=!3m1!4b1!4m10!4m9!1m1!4e1!1m5!1m1!1s0x9105cefcc625c5f9:0x43165a30c8ee4764!2m2!1d-77.0606806!2d-12.0080299!3e0?hl=es-419">.</a>
                                                    <div class="bloque-recojo">
                                                        <div class="titulo-recojo">C.C. PLAZA NORTE</div>
                                                        <div class="direccion-recojo">Tomas Valle con P. Norte</div>
                                                        <div class="direccion-recojo">Ingreso Principal</div>
                                                    </div>

                                                </div>
                                                <div class="punto2"><a class="ubicacion-icono" href="https://www.google.com.pe/maps/dir/-12.0269972,-76.9621752/Jr.+Ucello+100-162,+Cercado+de+Lima+15036/@-12.0589987,-77.0041035,14z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x9105c7d6a7ef3965:0xfab38eabd22da2e2!2m2!1d-77.0053347!2d-12.0899561?hl=es-419&amp;authuser=0">.</a>
                                                    <div class="bloque-recojo">
                                                        <div class="titulo-recojo">C.C. LA RAMBLA</div>
                                                        <div class="direccion-recojo">Av. Javier Prado Este 2050</div>
                                                        <div class="direccion-recojo">Ref. Puerta de Wong</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <span id="tourDetalle">
                                            ${tur.getDetallePaquete()}
                                        </span>>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                        <button type="button" class="btn btn-primary">Reservar</button>
                                    </div>
                                </div>
                            </div>
                        </div> 
                            <a href="<%=request.getContextPath()%>/srvADMIPaquete?accion=edit&id=${tur.getIdPaquete()}"><i class="fa-solid fa-pen-to-square editar"></i></a>
                            <a href="<%=request.getContextPath()%>/srvADMIPaquete?accion=delete&id=${tur.getIdPaquete()}"><i class="fa-sharp fa-solid fa-trash delete"></i></a>
                    </div> 
                </c:forEach>
            </div>
        </div>

        <script type="text/javascript">
            document.addEventListener('DOMContentLoaded', (event) => {
                const exampleModal = document.getElementById('exampleModal');
                exampleModal.addEventListener('show.bs.modal', (event) => {

                    const button = event.relatedTarget;
                    const tourTitulo = button.getAttribute('data-Titulo');
                    const tourDetalle = button.getAttribute('data-Detalle');

                    // Actualiza el contenido del modal
                    const modalTitle = exampleModal.querySelector('#tourTitulo');
                    const modalBodyInput = exampleModal.querySelector('#tourDetalle');

                    modalTitle.textContent = tourTitulo;
                    modalBodyInput.textContent = tourDetalle;
                });
            });
        </script>
    </body>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!-- Traer el footer -- Incluir contenido JSP -->
    <jsp:include page="footer.jsp"/>
</html>
