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
       
        <form action="procesar_sugerencia.php" method="post">
            <label for="nombre">Nombres:</label>
            <input type="text" id="nombre" name="nombre" required>
            
            <label for="nombre">Apellidos</label>
            <input type="text" id="apellido" name="apellido" required>
            
            <label for="nombre">DNI</label>
            <input type="text" id="dni" name="dni" required>
            
            <label for="correo">Número de contacto</label>
            <input type="email" id="numero" name="numero" required>
           
            <label for="mensaje">Mensaje:</label>
            <textarea id="mensaje" name="mensaje" required></textarea>
            
            <button type="submit">Enviar</button>
        </form>
    </div>
    </body>
    <jsp:include page="footer.jsp"/>
</html>
