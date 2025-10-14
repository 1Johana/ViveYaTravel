<%-- 
    Document   : Contactanos
    Created on : 2 oct. 2025, 12:44:39
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contáctanos</title>
        <link href="../css/header.css" rel="stylesheet" type="text/css"/>
        <link href="../css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="../css/contactanos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="blur-background">
            <img src="../img/contactanosfondo.jpg" alt="fondo" class="background-img"/>
            <div class="content-page">
                <div class="title-container">
                    <h1 class="section-title">Contactanos</h1>
                </div>
                <div class="main-container"> 
                    <div class="info-panel">
                    <div class="card">
                        <div class="card-title">Central Telefónica / Whatsapp</div>
                        (01) 550-6474 / (+51)955 563 339
                    </div>
                    <div class="card">
                        <div class="card-title">Oficina</div>
                        Av. Javier Prado Este 3371, San Borja 15021.
                    </div>
                    <div class="card">
                        <div class="card-title">Email</div>
                        <a
                        href="mailto:reservas@viveyatravel.com">reservas@viveyatravel.com</a>
                    </div>
                </div>
                <div class="map-panel">
                    <iframe
                        class="responsive-map"
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3901.3816937947126!2d-76.9900284!3d-12.0860012!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c7cafc2c3b1b%3A0x28555167378b03c0!2sVive%20Ya%20Travel!5e0!3m2!1ses-419!2spe!4v1759446300582!5m2!1ses-419!2spe" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"
                        allowfullscreen=""
                        loading="lazy"
                        referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                </div>
            </div>
        </div>        
    </body>
</html>