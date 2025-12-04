<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>

<%@ page import="com.mycompany.viveyatravel.modelo.dao.DbDAO" %>
<%@ page import="com.mycompany.viveyatravel.modelo.dao.ReservaaDAO" %>

<%
    DbDAO dao = new DbDAO();
    ReservaaDAO reservaDAO = new ReservaaDAO();

    // Reservas de HOY
    int bookingsToday = dao.getBookingsToday();

    // estadoPago: 'pendiente','pagado','cancelado'
    int confirmed = dao.getCountByStatus("pagado");
    int pending   = dao.getCountByStatus("pendiente");
    int cancelled = dao.getCountByStatus("cancelado");

    // NUEVO: totales de usuarios y reclamos
    int totalUsers     = dao.getTotalUsers();
    int totalReclamos  = dao.getTotalReclamaciones();

    // Ingresos por destino (paquete)
    Map<String, Integer> ingresosMap = new HashMap<>(dao.getIncomeByDestination());
    List<String> destinosList = new ArrayList<>(ingresosMap.keySet());
    List<Integer> ingresosList = new ArrayList<>(ingresosMap.values());

    // Convertimos las listas a literales de JS válidos
    String destinosJS = destinosList.toString()
            .replace("[", "['")
            .replace("]", "']")
            .replace(", ", "','");

    String ingresosJS = ingresosList.toString();

    // Reservas recientes
    List<ReservaaDAO.Reservaa> reservas = reservaDAO.getRecentReservations();

    String today = LocalDate.now()
        .format(java.time.format.DateTimeFormatter.ofPattern("dd 'de' MMMM yyyy", new Locale("es")));
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard — Vive Ya Travel</title>

    <!-- Fuentes / iconos -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!-- Tus CSS existentes -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Estilos específicos del dashboard (para que se vea más pro) -->
    <style>
        .dashboard-body {
            margin: 0;
            padding: 0;
            background: #f3f4f6;
            font-family: "Poppins", system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 32px auto;
            padding: 24px 28px 32px;
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.08);
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 24px;
        }

        .dashboard-title h1 {
            font-size: 1.8rem;
            margin: 0 0 4px;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .dashboard-title h1 i {
            font-size: 1.4rem;
            color: #2563eb;
        }

        .dashboard-title p {
            margin: 0;
            color: #6b7280;
            font-size: 0.95rem;
        }

        .dashboard-pill {
            align-self: center;
            padding: 6px 12px;
            border-radius: 999px;
            background: #eff6ff;
            color: #1d4ed8;
            font-size: 0.8rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .dashboard-pill i {
            font-size: 0.9rem;
        }

        .section-title {
            font-size: 1.05rem;
            font-weight: 600;
            color: #111827;
            margin: 0 0 12px;
        }

        /* KPIs */
        .kpi-section {
            margin-bottom: 28px;
        }

        .kpi-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
            gap: 16px;
        }

        .kpi {
            background: #f9fafb;
            border-radius: 16px;
            padding: 14px 16px;
            border: 1px solid #e5e7eb;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .kpi-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
        }

        .kpi-header span {
            font-size: 0.8rem;
            font-weight: 500;
            color: #6b7280;
        }

        .kpi-icon {
            width: 28px;
            height: 28px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #e0edff;
            color: #1d4ed8;
            font-size: 0.9rem;
        }

        .kpi-value {
            font-size: 1.4rem;
            font-weight: 600;
            color: #111827;
        }

        .kpi-footer {
            font-size: 0.75rem;
            color: #9ca3af;
        }

        /* Charts */
        .charts-section {
            margin-bottom: 28px;
        }

        .charts {
            display: grid;
            grid-template-columns: minmax(0, 2fr) minmax(0, 1.4fr);
            gap: 18px;
        }

        @media (max-width: 900px) {
            .charts {
                grid-template-columns: 1fr;
            }
        }

        .chart-box {
            background: #f9fafb;
            border-radius: 16px;
            padding: 16px 18px;
            border: 1px solid #e5e7eb;
        }

        .chart-box h3 {
            margin: 0 0 10px;
            font-size: 0.95rem;
            font-weight: 600;
            color: #111827;
        }

        .chart-box canvas {
            max-height: 280px;
        }

        /* Tabla */
        .table-section {
            margin-top: 8px;
        }

        .table-box {
            background: #f9fafb;
            border-radius: 16px;
            padding: 16px 18px;
            border: 1px solid #e5e7eb;
        }

        .table-box h3 {
            margin: 0 0 12px;
            font-size: 0.95rem;
            font-weight: 600;
            color: #111827;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.85rem;
        }

        thead {
            background: #e5e7eb;
        }

        th, td {
            padding: 8px 10px;
            text-align: left;
        }

        th {
            font-weight: 600;
            color: #374151;
            font-size: 0.8rem;
        }

        tbody tr:nth-child(every-2n), tbody tr:nth-child(2n) {
            background: #f3f4f6;
        }

        tbody tr:hover {
            background: #e0f2fe;
        }

        td {
            color: #4b5563;
        }

        .price-cell {
            font-weight: 500;
            color: #111827;
        }

        /* Estado como pill */
        .status-pill {
            display: inline-flex;
            align-items: center;
            padding: 3px 9px;
            border-radius: 999px;
            font-size: 0.73rem;
            font-weight: 500;
        }
        .status-paid {
            background: #dcfce7;
            color: #166534;
        }
        .status-pending {
            background: #fef9c3;
            color: #854d0e;
        }
        .status-cancelled {
            background: #fee2e2;
            color: #991b1b;
        }
        .status-default {
            background: #e5e7eb;
            color: #374151;
        }

        .empty-state {
            text-align: center;
            padding: 16px 0;
            font-size: 0.85rem;
            color: #9ca3af;
        }
    </style>
</head>

<body class="dashboard-body">

<div class="dashboard-container">

    <!-- Encabezado -->
    <header class="dashboard-header">
        <div class="dashboard-title">
            <h1>
                <i class="fa-solid fa-plane-departure"></i>
                Vive Ya Travel — Dashboard
            </h1>
            <p>Resumen general del sistema · <%= today %></p>
        </div>

        <div class="dashboard-pill">
            <i class="fa-solid fa-gauge-high"></i>
            Panel administrador
        </div>
    </header>

    <!-- ===== KPIs ===== -->
    <section class="kpi-section">
        <h2 class="section-title">Visión general</h2>

        <div class="kpi-container">
            <div class="kpi">
                <div class="kpi-header">
                    <span>Reservas de hoy</span>
                    <div class="kpi-icon">
                        <i class="fa-solid fa-calendar-day"></i>
                    </div>
                </div>
                <div class="kpi-value"><%= bookingsToday %></div>
                <div class="kpi-footer">Reservas generadas en las últimas 24 horas.</div>
            </div>

            <div class="kpi">
                <div class="kpi-header">
                    <span>Reservas pagadas</span>
                    <div class="kpi-icon">
                        <i class="fa-solid fa-circle-check"></i>
                    </div>
                </div>
                <div class="kpi-value"><%= confirmed %></div>
                <div class="kpi-footer">Pagos completados en el sistema.</div>
            </div>

            <div class="kpi">
                <div class="kpi-header">
                    <span>Reservas pendientes</span>
                    <div class="kpi-icon">
                        <i class="fa-solid fa-hourglass-half"></i>
                    </div>
                </div>
                <div class="kpi-value"><%= pending %></div>
                <div class="kpi-footer">Reservas a la espera de pago.</div>
            </div>

            <div class="kpi">
                <div class="kpi-header">
                    <span>Usuarios registrados</span>
                    <div class="kpi-icon">
                        <i class="fa-solid fa-users"></i>
                    </div>
                </div>
                <div class="kpi-value"><%= totalUsers %></div>
                <div class="kpi-footer">Clientes activos en la plataforma.</div>
            </div>

            <div class="kpi">
                <div class="kpi-header">
                    <span>Reclamos</span>
                    <div class="kpi-icon">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                    </div>
                </div>
                <div class="kpi-value"><%= totalReclamos %></div>
                <div class="kpi-footer">Reclamos registrados en el libro de reclamaciones.</div>
            </div>
        </div>
    </section>

    <!-- ===== GRÁFICOS ===== -->
    <section class="charts-section">
        <h2 class="section-title">Indicadores visuales</h2>

        <div class="charts">
            <div class="chart-box">
                <h3>Ingresos por paquete</h3>
                <canvas id="barChart"></canvas>
            </div>

            <div class="chart-box">
                <h3>Estados de reservas</h3>
                <canvas id="pieChart"></canvas>
            </div>
        </div>
    </section>

    <!-- ===== TABLA ===== -->
    <section class="table-section">
        <div class="table-box">
            <h3>Reservas recientes</h3>

            <table>
                <thead>
                <tr>
                    <th>#</th>
                    <th>Cliente</th>
                    <th>Paquete</th>
                    <th>Precio</th>
                    <th>Fecha</th>
                    <th>Estado</th>
                </tr>
                </thead>

                <tbody>
                <% if (reservas == null || reservas.isEmpty()) { %>
                    <tr>
                        <td colspan="6" class="empty-state">
                            No hay reservas recientes para mostrar.
                        </td>
                    </tr>
                <% } else {
                       for (ReservaaDAO.Reservaa r : reservas) {

                           String estado = (r.estado != null) ? r.estado.toLowerCase() : "";
                           String estadoLabel;
                           String estadoClass;

                           if ("pagado".equals(estado)) {
                               estadoLabel = "Pagado";
                               estadoClass = "status-paid";
                           } else if ("pendiente".equals(estado)) {
                               estadoLabel = "Pendiente";
                               estadoClass = "status-pending";
                           } else if ("cancelado".equals(estado)) {
                               estadoLabel = "Cancelado";
                               estadoClass = "status-cancelled";
                           } else {
                               estadoLabel = (r.estado != null) ? r.estado : "N/D";
                               estadoClass = "status-default";
                           }

                           String fechaCorta = r.fecha;
                           if (fechaCorta != null && fechaCorta.length() >= 10) {
                               fechaCorta = fechaCorta.substring(0, 10); // yyyy-MM-dd
                           }
                %>
                    <tr>
                        <td><%= r.id %></td>
                        <td><%= r.cliente %></td>
                        <td><%= r.destino %></td>
                        <td class="price-cell">S/ <%= String.format(java.util.Locale.US, "%.2f", r.precio) %></td>
                        <td><%= fechaCorta %></td>
                        <td>
                            <span class="status-pill <%= estadoClass %>">
                                <%= estadoLabel %>
                            </span>
                        </td>
                    </tr>
                <%   } // fin for
                   } // fin else %>
                </tbody>
            </table>
        </div>
    </section>

</div>

<script>
    const destinos = <%= destinosJS %>;   // ['Cusco','Arequipa', ...]
    const ingresos = <%= ingresosJS %>;   // [1200, 800, ...]

    // Bar chart: Ingresos por paquete
    new Chart(document.getElementById("barChart"), {
        type: 'bar',
        data: {
            labels: destinos,
            datasets: [{
                label: 'Ingresos (S/.)',
                data: ingresos,
                borderRadius: 8,
                backgroundColor: 'rgba(37, 99, 235, 0.85)'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    ticks: { stepSize: 1 }
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });

    // Pie chart: Estados de reservas
    new Chart(document.getElementById("pieChart"), {
        type: 'pie',
        data: {
            labels: ["Pagadas", "Pendientes", "Canceladas"],
            datasets: [{
                data: [<%= confirmed %>, <%= pending %>, <%= cancelled %>],
                backgroundColor: [
                    'rgba(34, 197, 94, 0.85)',   // verde
                    'rgba(234, 179, 8, 0.85)',   // amarillo
                    'rgba(248, 113, 113, 0.85)'  // rojo
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        boxWidth: 14,
                        font: { size: 11 }
                    }
                }
            }
        }
    });
</script>

</body>
</html>

