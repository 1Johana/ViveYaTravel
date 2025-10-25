<%@page import="com.mycompany.viveyatravel.modelo.dto.usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Recuperar contraseña</title>
    <link href="${pageContext.request.contextPath}/css/cambioClave.css" rel="stylesheet" type="text/css"/>
    <link rel="icon" href="../img/icon.png" type="image">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    
    <style>
        body {
            background-color: #f4f6f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .formularioClave {
            background: #fff;
            padding: 30px 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 450px;
        }

        .formularioClave h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #0d6efd;
        }

        .formularioClave .campo {
            margin-bottom: 20px;
        }

        .formularioClave label {
            font-weight: 500;
            margin-bottom: 5px;
            display: block;
        }

        .formularioClave input[type="password"] {
            border-radius: 8px;
            padding: 10px;
            width: 100%;
            border: 1px solid #ced4da;
            font-size: 14px;
        }

        .formularioClave button, 
        .formularioClave input[type="submit"] {
            width: 100%;
            border-radius: 8px;
            padding: 10px;
            font-size: 16px;
            font-weight: 500;
        }

        .formularioClave input[type="submit"] {
            background-color: #0d6efd;
            color: white;
            border: none;
        }

        .formularioClave input[type="submit"]:hover {
            background-color: #0b5ed7;
        }
    </style>
</head>
<body>

    <div class="formularioClave">
        <h2><i class="fa-solid fa-key"></i> Hola ${nombre}, restablece tu contraseña</h2>            
        <form action="${pageContext.request.contextPath}/srvRecuperarClave" method="post" id="resetForm">
            <input type="hidden" name="action" value="cambiar">
            <input type="hidden" name="correo" value="${correo}">

            <div class="campo">
                <label for="clave">Nueva contraseña:</label>
                <input type="password" id="clave" name="clave" required
                       pattern='^(?=.*[^A-Za-z0-9]).{8,}$'
                       title="Debe tener al menos 8 caracteres y un caracter especial">
            </div>

            <input type="submit" value="Cambiar contraseña">
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
