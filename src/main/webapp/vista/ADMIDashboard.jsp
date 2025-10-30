<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Vive Ya Travel</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />

        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>

        <style>
            /* Definición de variables de color de Vive Ya Travel */
            :root {
                --viveya-darkblue: #044B87; /* Azul Principal */
                --viveya-mediumblue: #0660B0; /* Azul Secundario */
                --viveya-success: #28a745; /* Verde Bootstrap más intenso */
                --viveya-warning: #ffc107; /* Amarillo Bootstrap más intenso */
                --viveya-danger: #dc3545; /* Rojo Bootstrap más intenso */
                --viveya-bg-light: #f8f9fa;
            }

            /* Estilos base (Mantenidos) */
            body {
                background-color: var(--viveya-bg-light);
            }
            .card {
                border: none;
                border-radius: 0.5rem;
                position: relative;
                overflow: hidden;
                box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
                transition: transform 0.2s, box-shadow 0.2s;
                min-height: 120px;
            }
            .card:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
            }
            .card-body {
                padding: 1.25rem;
            }

            /* Títulos de tarjeta - SIN OPACIDAD */
            .card-title {
                font-size: 0.9rem;
                font-weight: 500;
                margin-bottom: 0.2rem;
                /* opacity: 0.9; -- REMOVIDO PARA MAYOR VITALIDAD */
            }

            .card-text.fs-3 {
                font-size: 2.2rem !important;
                font-weight: 700;
                margin-bottom: 0;
            }

            /* Aplicación de colores más vivos a las Tarjetas */
            .card.bg-primary {
                background-color: var(--viveya-darkblue) !important;
            }
            .card.bg-success {
                background-color: var(--viveya-success) !important;
            }
            .card.bg-warning {
                background-color: var(--viveya-warning) !important;
                color: #333 !important; /* Texto oscuro para contraste en fondo amarillo/naranja */
            }
            .card.bg-danger {
                background-color: var(--viveya-danger) !important;
            }

            /* Iconos de fondo sutil (se mantienen) */
            .card-body i.position-absolute {
                opacity: 0.15;
                color: #ffffff;
                font-size: 3rem !important;
                bottom: 15px;
                right: 15px;
            }

            /* Para la tarjeta warning, el icono debe ser oscuro para contrastar con el fondo claro */
            .card.bg-warning .card-body i.position-absolute {
                color: rgba(0,0,0,0.2) !important; /* Icono oscuro para fondo claro */
            }

            .shadow-sm {
                box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075) !important;
            }
            .bg-light {
                background-color: var(--viveya-bg-light) !important;
            }

            /* Sincronización del margen */
            .content {
                margin-left: 250px;
                transition: margin-left 0.3s;
                padding: 20px;
            }
        </style>
    </head>
    <body class="bg-light">


        <div class="content" id="content">
            <div class="container-fluid py-4">
                <div class="p-3 bg-white rounded shadow-sm">
                    <h3 class="mb-3">Dashboard (Resumen General)</h3>
                    <p>Aquí tienes un resumen de la actividad reciente de Vive Ya Travel.</p>

                    <div class="row mt-4">
                        <div class="col-md-3 mb-3">
                            <div class="card text-white bg-primary">
                                <div class="card-body">
                                    <h5 class="card-title">Ventas Mes</h5>
                                    <p class="card-text fs-3">$XX,XXX</p>
                                    <i class="fa-solid fa-money-bill-wave fa-2x position-absolute end-0 bottom-0 m-3 opacity-25"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card text-white bg-success">
                                <div class="card-body">
                                    <h5 class="card-title">Nuevos Usuarios</h5>
                                    <p class="card-text fs-3">+12</p>
                                    <i class="fa-solid fa-user-plus fa-2x position-absolute end-0 bottom-0 m-3 opacity-25"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card text-dark bg-warning"> <div class="card-body">
                                    <h5 class="card-title">Paquetes Activos</h5>
                                    <p class="card-text fs-3">15</p>
                                    <i class="fa-solid fa-luggage-cart fa-2x position-absolute end-0 bottom-0 m-3 opacity-25"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card text-white bg-danger">
                                <div class="card-body">
                                    <h5 class="card-title">Reclamos Pendientes</h5>
                                    <p class="card-text fs-3">3</p>
                                    <i class="fa-solid fa-triangle-exclamation fa-2x position-absolute end-0 bottom-0 m-3 opacity-25"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">

                        <div class="col-lg-6 col-md-12 mb-4">
                            <div class="p-4 bg-white rounded shadow-sm h-100">
                                <h5 class="mb-3" style="color: var(--viveya-darkblue);">📈 Rendimiento Mensual (Ingresos)</h5>
                                <div class="chart-container" style="position: relative; height: 350px;">
                                    <canvas id="chartRendimientoMensual"></canvas>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-12 mb-4">
                            <div class="p-4 bg-white rounded shadow-sm h-100">
                                <h5 class="mb-3" style="color: var(--viveya-darkblue);">🌍 Destinos más Populares</h5>
                                <div class="chart-container" style="position: relative; height: 350px;">
                                    <canvas id="chartDestinosPopulares"></canvas>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 mb-4">
                            <div class="p-4 bg-white rounded shadow-sm">
                                <h5 class="mb-3" style="color: var(--viveya-darkblue);">👥 Historial de Nuevos Clientes (Últimos 6 meses)</h5>
                                <div class="chart-container" style="position: relative; height: 350px;">
                                    <canvas id="chartNuevosClientes"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const viveyaPrimary = '#044B87'; // Azul oscuro
                const viveyaSecondary = '#0660B0'; // Azul medio
                const viveyaGreen = '#28a745'; // Verde de éxito (más vivo)

                const colorsPalette = [
                    viveyaPrimary,
                    viveyaSecondary,
                    '#2196F3', // Azul claro
                    '#90CAF9'  // Azul muy claro
                ];

                // 1. Gráfico de Rendimiento Mensual (Barras)
                const ctxRendimiento = document.getElementById('chartRendimientoMensual');
                if (ctxRendimiento) {
                    new Chart(ctxRendimiento, {
                        type: 'bar',
                        data: {
                            labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'],
                            datasets: [{
                                    label: 'Ingresos ($)',
                                    data: [12000, 19000, 30000, 15000, 22000, 28000],
                                    backgroundColor: viveyaPrimary,
                                    borderColor: viveyaPrimary,
                                    borderWidth: 1
                                }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {y: {beginAtZero: true, grid: {color: 'rgba(0, 0, 0, 0.05)'}}},
                            plugins: {legend: {display: false}}
                        }
                    });
                }

                // 2. Gráfico de Destinos Populares (Dona)
                const ctxDestinos = document.getElementById('chartDestinosPopulares');
                if (ctxDestinos) {
                    new Chart(ctxDestinos, {
                        type: 'doughnut',
                        data: {
                            labels: ['Cancún', 'Europa', 'Perú', 'Tailandia'],
                            datasets: [{
                                    label: 'Ventas',
                                    data: [25, 45, 15, 15],
                                    backgroundColor: colorsPalette,
                                    hoverOffset: 8
                                }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        usePointStyle: true,
                                    }
                                }
                            }
                        }
                    });
                }

                // 3. Historial de Nuevos Clientes (Líneas)
                const ctxClientes = document.getElementById('chartNuevosClientes');
                if (ctxClientes) {
                    new Chart(ctxClientes, {
                        type: 'line',
                        data: {
                            labels: ['Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
                            datasets: [{
                                    label: 'Nuevos Usuarios',
                                    data: [15, 22, 18, 35, 40, 55],
                                    borderColor: viveyaGreen,
                                    backgroundColor: 'rgba(40, 167, 69, 0.1)', // Usar el verde más vivo con transparencia
                                    borderWidth: 2,
                                    pointRadius: 4,
                                    fill: true,
                                    tension: 0.4
                                }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                y: {beginAtZero: true, grid: {color: 'rgba(0, 0, 0, 0.05)'}},
                                x: {grid: {display: false}}
                            },
                            plugins: {legend: {display: false}}
                        }
                    });
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="ADMIVista.jsp"/>

    </body>
</html>