<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
    <meta charset="UTF-8">
        <title>Sugerencias | Vive Ya Travel</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/header.css" rel="stylesheet" type="text/css"/>
        <link href="../css/footer.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="../css/sugerencias.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    </head>
<body class="bg-light">
    <jsp:include page="header.jsp"/>
    
        <div class="container mt-5 formulario-sugerencias">
            <div class="card shadow-sm border-0 p-4 rounded-4 mx-auto" style="max-width: 500px;">


                <h3 class="text-center mb-4 fw-bold titulo-sugerencias">DÉJANOS TU SUGERENCIA</h3>

                <form action="${pageContext.request.contextPath}/Sugerencias" method="post" onsubmit="return validarFormulario();">
            <div class="mb-3">
                <label class="form-label">Nombres</label>
                <input type="text" class="form-control" name="nombres"
                       pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ ]+" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Apellidos</label>
                <input type="text" class="form-control" name="apellidos"
                       pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ ]+" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Celular</label>
                <input type="text" class="form-control" name="celular"
                maxlength="9" pattern="[0-9]{9}"
                oninput="this.value = this.value.replace(/[^0-9]/g, '');"
                required>
            <div class="mb-3">
                <label class="form-label">DNI</label>
                <input type="text" class="form-control" name="dni"
                maxlength="8" pattern="[0-9]{8}"
                oninput="this.value = this.value.replace(/[^0-9]/g, '');"
                required>
            </div>
            <div class="mb-3">
                <label class="form-label">Mensaje o sugerencia</label>
                <textarea class="form-control" name="mensaje" rows="3" required></textarea>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary px-4">Enviar</button>
            </div>
        </form>
            </div>
        </div>
        </div>    
        <script>
        function validarFormulario() {
            const celular = document.querySelector('[name="celular"]').value;
            const dni = document.querySelector('[name="dni"]').value;

            if (!/^[0-9]{9}$/.test(celular)) {
                Swal.fire('Error', 'El número de celular debe tener 9 dígitos.', 'error');
                return false;
            }
            if (!/^[0-9]{8}$/.test(dni)) {
                Swal.fire('Error', 'El DNI debe tener 8 dígitos.', 'error');
                return false;
            }
            return true;
        }

            <%
                String exito = request.getParameter("exito");
                if ("true".equals(exito)) {
            %>
                Swal.fire({
                    icon: 'success',
                    title: '¡Enviado!',
                    text: 'Tu sugerencia fue registrada correctamente.'
                }).then(() => {
                    // Limpia el parámetro "exito" de la URL
                    window.history.replaceState({}, document.title, window.location.pathname);
                });
            <%
                } else if ("false".equals(exito)) {
            %>
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Hubo un problema al enviar tu sugerencia.'
                }).then(() => {
                    // Limpia el parámetro "exito" de la URL
                    window.history.replaceState({}, document.title, window.location.pathname);
                });
            <%
                }
            %>
        </script>
        
    <jsp:include page="footer.jsp"/>
</body>
</html>
