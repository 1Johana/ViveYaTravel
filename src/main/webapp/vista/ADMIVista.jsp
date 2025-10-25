<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    <style>
        body { background-color: #f4f6f9; }
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #6495ED;
            position: fixed;
            transition: margin-left .3s;
        }
        .sidebar a { color: #ffffff; display: block; padding: 12px 20px; text-decoration: none; font-weight: bold;}
        .sidebar a:hover { background: #4471D3; }
        .content { margin-left: 250px; padding: 20px; transition: margin-left .3s; }
        .navbar { margin-left: 250px; transition: margin-left .3s; }
        .sidebar.toggled { margin-left: -250px; }
        .content.toggled { margin-left: 0; }
        .navbar.toggled { margin-left: 0; }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h4 class="text-white text-center py-3 border-bottom">Administrador</h4>
        <a href="#"><i class="fa-solid fa-gauge"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/srvADMIPaquete"><i class="fa-solid fa-box"></i> Gestión de Paquetes</a>
        <a href="<%=request.getContextPath()%>/reporteUsuarios"><i class="fa-solid fa-users"></i> Usuarios</a>
        <a href="#"><i class="fa-solid fa-box"></i> Paquetes Vendidos</a>
        <a href="#"><i class="fa-solid fa-file-pen"></i>Reclamos</a>
        <a href="#"><i class="fa-solid fa-gear"></i> Configuración</a>
        <a href="${pageContext.request.contextPath}/srvUsuario?accion=cerrar" class="text-danger"><i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión</a>
    </div>

    <!-- Navbar -->
    <nav class="navbar navbar-light bg-white shadow-sm" id="navbar">
        <div class="container-fluid">
            <!-- Botón hamburguesa -->
            <button class="btn btn-outline-dark me-3" id="toggleSidebar">
                <i class="fa-solid fa-bars"></i>
            </button>
            <span class="navbar-brand mb-0 h1">Panel de Administración</span>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="content" id="content">
      <!--  <h2>Bienvenido al panel administrador</h2>
        <p>Aquí podrás gestionar todo el contenido de tu sistema.</p> -->
    </div>

    <script>
        const toggleBtn = document.getElementById('toggleSidebar');
        const sidebar = document.getElementById('sidebar');
        const navbar = document.getElementById('navbar');
        const content = document.getElementById('content');

        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('toggled');
            navbar.classList.toggle('toggled');
            content.classList.toggle('toggled');
        });
    </script>
</body>
</html>
