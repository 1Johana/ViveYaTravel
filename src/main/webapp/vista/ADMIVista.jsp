<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel Administrador - Vive Ya Travel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
        <style>
            /* Paleta de colores de Vive Ya Travel */
            :root {
                --viveya-darkblue: #044B87; /* Azul oscuro primario */
                --viveya-mediumblue: #0660B0; /* Azul medio para hover */
                --viveya-lightblue: #2196F3; /* Azul claro para activo/acento */
                --viveya-red: #E74C3C; /* Rojo para cerrar sesión */
                --viveya-bg-light: #f8f9fa; /* Fondo claro */
            }

            body {
                background-color: var(--viveya-bg-light);
                padding-top: 56px; /* Espacio para el navbar fijo */
            }

            /* Sidebar Styles (Panel Lateral Fijo) */
            .sidebar {
                width: 250px;
                height: 100vh;
                background: var(--viveya-darkblue);
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1030; /* Alto z-index para estar sobre el contenido */
                transition: all 0.3s;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            }
            .sidebar-header {
                padding: 20px 20px 15px 20px;
                text-align: center;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }
            .sidebar-header .logo-text {
                font-size: 1.5rem;
                font-weight: 700;
                color: #ffffff;
                margin: 0;
            }

            /* Enlaces de la barra lateral */
            .sidebar a {
                color: #ffffff;
                display: flex;
                align-items: center;
                padding: 15px 20px;
                text-decoration: none;
                font-size: 1rem;
                transition: background-color 0.2s;
            }
            .sidebar a i {
                margin-right: 10px;
                font-size: 1.1rem;
            }
            .sidebar a:hover {
                background: var(--viveya-mediumblue);
            }
            /* Estilo para el elemento ACTIVO */
            .sidebar a.active {
                background: var(--viveya-lightblue);
                color: #ffffff;
                border-left: 5px solid #ffffff;
                padding-left: 15px;
            }

            /* Estilo para Cerrar Sesión */
            .sidebar a.text-danger {
                color: var(--viveya-red) !important;
                margin-top: 15px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }
            .sidebar a.text-danger:hover {
                background: rgba(255, 255, 255, 0.1);
            }

            /* Navbar Fijo Superior */
            .navbar {
                position: fixed;
                top: 0;
                left: 250px;
                right: 0;
                z-index: 1020;
                height: 56px;
                transition: all 0.3s;
            }

            /* Contenido Principal */
            .content {
                margin-left: 250px;
                padding: 20px;
                transition: margin-left 0.3s;
                min-height: calc(100vh - 56px); /* Para que el contenido use toda la pantalla menos el navbar */
            }

            /* Toggle/Ocultar Funcionalidad */
            .sidebar.toggled {
                margin-left: -250px;
            }
            .content.toggled {
                margin-left: 0;
            }
            .navbar.toggled {
                left: 0;
            }

            /* Estilo del botón hamburguesa */
            #toggleSidebar {
                color: var(--viveya-darkblue);
                border-color: var(--viveya-darkblue);
            }
            #toggleSidebar:hover {
                background-color: var(--viveya-darkblue);
                color: white;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h4 class="logo-text">
                    <i class="fa-solid fa-plane-departure me-2"></i>Vive Ya Travel
                </h4>
                <p class="text-white-50 small mt-1">Administrador</p>
            </div>
            <a href="<%=request.getContextPath()%>/vista/ADMIDashboard.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a>
            <a href="<%=request.getContextPath()%>/srvADMIPaquete"><i class="fa-solid fa-box-archive"></i> Gestión de Paquetes</a>
            <a href="<%=request.getContextPath()%>/reporteUsuarios"><i class="fa-solid fa-users"></i> Usuarios</a>
            <a href="#"><i class="fa-solid fa-clipboard-list"></i> Paquetes Vendidos</a>
            <a href="<%=request.getContextPath()%>/reclamaciones?vista=admin"><i class="fa-solid fa-file-pen"></i> Reclamos</a>
            <a href="<%=request.getContextPath()%>/vista/ADMIJuegos.jsp"><i class="fa-solid fa-gamepad"></i> Juegos</a>
            <a href="#"><i class="fa-solid fa-gear"></i> Configuración</a>
            <a href="${pageContext.request.contextPath}/srvUsuario?accion=cerrar" class="text-danger"><i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión</a>
        </div>
        <nav class="navbar navbar-light bg-white shadow-sm" id="navbar">
            <div class="container-fluid">
                <button class="btn btn-outline-dark me-3" id="toggleSidebar">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <!--<span class="navbar-brand mb-0 h1">Panel de Administración</span>-->
                <div class="d-flex align-items-center">
                    <span class="me-3 text-muted d-none d-sm-block">Hola, Administrador!</span>
                    <i class="fa-solid fa-bell me-3 text-warning"></i>
                    <i class="fa-solid fa-user-circle fa-lg text-primary"></i>
                </div>
            </div>        
        </nav>
        <div class="content" id="content">
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

            // Función para manejar el enlace activo (opcional, requiere JS en producción)
            document.addEventListener("DOMContentLoaded", function () {
                const links = sidebar.querySelectorAll('a');
                const currentUrl = window.location.href;

                links.forEach(link => {
                    // Lógica simple para marcar el Dashboard si está en la URL base
                    if (link.href === currentUrl || link.href + "/" === currentUrl ||
                            (link.textContent.includes('Dashboard') && (currentUrl.endsWith('/') || currentUrl.includes('index.jsp')))) {
                        link.classList.add('active');
                    } else {
                        link.classList.remove('active');
                    }
                });
            });

        </script>
    </body>
</html>
