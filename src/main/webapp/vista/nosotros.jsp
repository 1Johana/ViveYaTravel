<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/nosotros.css" rel="stylesheet" type="text/css"/>
    </head>
    <jsp:include page="header.jsp"/>       
     <!-- Encabezado NOSOTROS -->
        <h1 class="nosotros"> NOSOTROS</h1> 
        <p class="nosotros-text">  <!-- clase para colocar la información  sobre la empresa -->
                Somos una agencia de turismo con más de 5 años de experiencia en el
                <br><!-- propiedad para separar texto-->
                rubro del turismo brindando la mejor experiencia a nuestros clientes.
                <br>
                Brindamos paquetes turísticos a diversos destinos del Perú para
                <br>
                personas residentes de Lima Metropolitana.
     </p>
        <!-- Crear un contenedor para añadir la mision y vision -->
        <section class="contenedor-nosotros">
         <div class="vision"> <!-- clase para el apartado de la vision -->
            <h2 class="vision-heading">Vision</h2>  <!-- encabezado Vision -->
            <p class="vision-text">  <!-- clase para colocar la vision de la empresa -->
                Ser reconocidos como líderes en la industria del turismo,
                <br> 
                distinguiéndonos por nuestra pasión por el servicio al cliente.
            </p>
            <div class="vision-img">  <!-- clase para el apartado de la imagen de la vision -->
                <img src="../img/vision.jpg" alt="vision" width="200"/><!-- direccion de la imagen vision-->
            </div>
            </div>
             
             <div class="mision"><!-- clase para el apartado de la mision -->
                 <h3 class="mision-heading">Mision</h3><!-- encabezado Mision -->
                    <p class="mision-text">   <!-- clase para colocar la mision de la empresa -->
                       Proporcionar experiencias de viaje inolvidables y personalizadas
                       <br>
                       que inspiren a nuestros clientes, vidas y crear recuerdos únicos. 
                    </p>
            <div class="mision-img"> <!-- clase para el apartado de la imagen de la mision -->
                <img src="../img/mision.jpg" alt="mision" width="200"/>  <!-- direccion de la imagen mision-->
                    </div>
                    </div>
           </section>
        <div class="ustedes">
            <h3 class="ustedes-heading">UN POCO MÁS DE NOSOTROS...</h3>
        </div>

         <div class="video-container">
            <iframe src="https://www.youtube.com/embed/7biaualce90" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            <iframe src="https://www.youtube.com/embed/mZgDvY6ENkM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            
        </div>
                 
    <!-- FOOTER-->
    <jsp:include page="footer.jsp"/>0

</html>
