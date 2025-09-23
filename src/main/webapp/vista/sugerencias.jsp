<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../css/header.css" rel="stylesheet" type="text/css"/>
        <link href="../css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="../css/sugerencias.css" rel="stylesheet" type="text/css"/>
        
    </head>
    <jsp:include page="header.jsp"/>
    <body>
        
      <div class="form-container">
          
       <h1 class="formulario">Formulario de Sugerencias</h1>
       
        <form id="sugerenciaForm" action="procesar_sugerencia.jsp" method="post">
        
            <label for="nombre">Nombres:</label>
            <input type="text" id="nombre" name="nombre" required>
            
            <label for="nombre">Apellidos</label>
            <input type="text" id="apellido" name="apellido" required>
            
            <label for="nombre">DNI</label>
            <input type="text" id="dni" name="dni" required maxlength="8" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
            
            <label for="correo">Número de contacto</label>
            <input type="text" id="numero" name="numero" required maxlength="9" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
           
            <label for="mensaje">Mensaje:</label>
            <textarea id="mensaje" name="mensaje" required></textarea>
            
            <button type="submit">Enviar</button>
        </form>
    </div>
    </body>
    <script>
    document.getElementById('sugerenciaForm').addEventListener('submit', function(event) {

        // Validar DNI: 8 números
        const dniInput = document.getElementById('dni');
        if (dniInput.value.length !== 8 || isNaN(dniInput.value)) {
            alert('El DNI debe contener exactamente 8 números.');
            event.preventDefault(); // Evita que el formulario se envíe
            return; // Detiene la ejecución del script
        }

        // Validar Número de contacto: 9 números
        const numeroInput = document.getElementById('numero');
        if (numeroInput.value.length !== 9 || isNaN(numeroInput.value)) {
            alert('El número de contacto debe contener exactamente 9 números.');
            event.preventDefault();
            return;
        }
    });
</script>
    <jsp:include page="footer.jsp"/>
</html>
