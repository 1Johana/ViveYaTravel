<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/preguntas.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <jsp:include page="header.jsp"/>
    <body>
        <div class="container">
        <div class="faq-container">
        <h1 class="preguntas">PREGUNTAS FRECUENTES</h1>
        
        <details class="faq-item">
            <summary>¿Cómo puedo reservar un viaje?</summary>
            <p>Para reservar un viaje, visita nuestra página web, elige tu destino, 
                selecciona las fechas y sigue las instrucciones para completar tu reserva.</p>
        </details>
        
        <details class="faq-item">
            <summary>¿Qué métodos de pago aceptan?</summary>
            <p>Aceptamos pagos con tarjetas de crédito, débito, Yape, plin y transferencias bancarias.</p>
        </details>
        
        <details class="faq-item">
            <summary>¿Puedo cancelar o modificar mi reserva?</summary>
            <p>Sí, puedes cancelar o modificar tu reserva siguiendo las políticas de cancelación y 
                modificación establecidas en nuestros términos y condiciones. Por favor, revisa los 
                detalles específicos de tu reserva.</p>
        </details>
        
        <details class="faq-item">
            <summary>¿Ofrecen seguros de viaje?</summary>
            <p>Sí, ofrecemos un seguro de viaje que añadimos a tu reserva para que tengas una 
                mayor tranquilidad durante tu viaje.</p>
        </details>
        
        <details class="faq-item">
            <summary>¿Qué documentación necesito para viajar?</summary>
            <p>La documentación requerida varía según el destino. Generalmente, necesitarás tú 
                documento de identidad o carnet de extranjería, en algunos casos debes conatar 
                con pasaporte vigente. Recomendamos revisar los requisitos específicos de tu 
                destino antes de viajar.</p>
        </details>
        
        <details class="faq-item">
            <summary>¿Cómo puedo contactar con el servicio de atención al cliente?</summary>
            <p>PPuedes contactar con nuestro servicio de atención al cliente a través del 
                formulario de sugerencias en nuestro sitio web, por el número de WhatsApp o 
                por correo electrónico.</p>
        </details>
        
        <details class="faq-item">
            <summary>¿Ofrecen paquetes turísticos?</summary>
            <p>Sí, ofrecemos una variedad de paquetes turísticos que incluyen alojamiento, 
                transporte y actividades. Puedes consultar nuestras ofertas en la sección de 
                paquetes turísticos.</p>
        </details>
        
        <details class="faq-item">
            <summary>¿Qué debo hacer si pierdo mi vuelo?</summary>
            <p>Si pierdes tu vuelo, contacta inmediatamente con nuestra línea de atención al 
                cliente para recibir asistencia. Te ayudaremos a reprogramar tu vuelo o 
                encontrar una solución alternativa.</p>
        </details>
        
        <details class="faq-item">
            <summary>¿Puedo obtener un reembolso si cancelo mi viaje?</summary>
            <p>Los reembolsos dependen de las políticas de cancelación de tu reserva. Por favor,
                revisa los términos y condiciones específicos de tu reserva para conocer los 
                detalles sobre reembolsos.</p>
        </details>
        
        <details class="faq-item">
            <summary>¿Puedo solicitar un itinerario personalizado?</summary>
            <p>Sí, ofrecemos servicios de itinerarios personalizados. Nuestros asesores de 
                viaje pueden ayudarte a planificar un viaje que se ajuste a tus necesidades 
                y preferencias. Contáctanos para más detalles.</p>
        </details>
    </div>
   </div>
    </body>
    <jsp:include page="footer.jsp"/>
</html>
