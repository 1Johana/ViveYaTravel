<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Nosotros | VIVE YA TRAVEL</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/header.css" rel="stylesheet" type="text/css"/>
    <link href="../css/footer.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="../css/nosotros.css">
    
</head>

<body>
    <jsp:include page="header.jsp"/>

    <!-- SECCIÓN QUIÉNES SOMOS (con fondo tipo franja) -->
    <section class="seccion-nosotros text-light py-5">
        <div class="container">
            <div class="row align-items-center">

                <!-- Carrusel de imágenes -->
                <div class="col-md-6 mb-4 mb-md-0">
                    <div id="carouselNosotros" class="carousel slide shadow rounded-4" data-bs-ride="carousel">
                        <div class="carousel-item active">
                                <img src="https://scontent.flim15-1.fna.fbcdn.net/v/t39.30808-6/583329307_1321859086655501_8381330934220892605_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=f727a1&_nc_eui2=AeFrmperjwDBnBirME-6SMBfn-6UjhyFwF2f7pSOHIXAXWOZYiHkLIqwYm8T6gh5rKmN1mTL5Lsg_jiZttr84LQ_&_nc_ohc=UVokoaNw-BMQ7kNvwFAUlUW&_nc_oc=AdkHyfK-1iunwIYx3-5a2zh71dTPuniJI7fgFdPfU1btsZh2OE2l4G1Y1oVnEUQcJcM&_nc_zt=23&_nc_ht=scontent.flim15-1.fna&_nc_gid=HdXlE24eXTSuyWLfL1SIPg&oh=00_AfipxhdUkdkyusYcwC1MGS60UZ4bpnXt8aV8a8HveLEEdA&oe=6922672F" class="d-block w-100" alt="Playa en viaje">
                            </div>
                            <div class="carousel-item">
                                <img src="https://scontent.flim15-2.fna.fbcdn.net/v/t39.30808-6/581824038_1321249826716427_1252457838383567637_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=f727a1&_nc_eui2=AeGScXCiwJVj6LOJ7h319CM_9vmVWLy1p4f2-ZVYvLWnhynXpoU1mvM9c1N7gdSajw0eJYbuu7nSwzM5a_lKjLI1&_nc_ohc=3hOnoxEDY58Q7kNvwFAkrwF&_nc_oc=AdmGJVClqhmqxP8TTCoXKSw72pmHr6gyu0sFf7U3ZJl4i0wnHwSeZl43Ykxo0aiZTf4&_nc_zt=23&_nc_ht=scontent.flim15-2.fna&_nc_gid=zGS49KszyLKGgGcOU_DZnw&oh=00_Afiiqi6zz1YWKwGV4R9a_ZEAF52w7dV6l6CigXsJL6sl-g&oe=69226CD3" class="d-block w-100" alt="Montañas del Perú">
                            </div>
                            <div class="carousel-item">
                                <img src="https://scontent.flim15-1.fna.fbcdn.net/v/t39.30808-6/583253943_1321148943393182_2835516139478859013_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=f727a1&_nc_eui2=AeHtjg1a23Es3CRpgwHLxJQVTQtycvdNjkZNC3Jy902ORgkAIizjls5MBhe5zH2GcXIL06URlQaRkFt-2v-BYSQF&_nc_ohc=OQiqGF4C3_4Q7kNvwF03Pt0&_nc_oc=AdnrZ7NsHGQEaFxXFCk7s074hAP6j1F0J4nMIa82EvYJYap07N-lnVwGtAd9cB8_tHk&_nc_zt=23&_nc_ht=scontent.flim15-1.fna&_nc_gid=kyQHC0anhJ7UGQK2O4WJDw&oh=00_AfgU2bdXEmVHsXLJrEZzJU3F-lXETczZ_kV9hcYLhtOh2Q&oe=69226DAB" class="d-block w-100" alt="Turistas disfrutando de un tour">
                            </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselNosotros" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Anterior</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselNosotros" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Siguiente</span>
                        </button>
                    </div>
                </div>

                <div class="col-md-6">
                    <h2 class="fw-bold mb-3">¿QUIÉNES SOMOS?</h2>
                    <p>En VIVE YA TRAVEL somos una agencia peruana dedicada a crear experiencias de viaje únicas e inolvidables. 
                        Nuestro equipo apasionado ofrece los mejores destinos, precios competitivos y un servicio personalizado 
                        que te acompaña antes, durante y después de tu viaje, para que no tengas ningún incoveniente.</p>
                    <p>Con años de experiencia, conectamos viajeros con los lugares más increíbles del Perú y del mundo. 
                        Nuestra misión es inspirarte a descubrir nuevas culturas y vivir cada aventura con intensidad, 
                        garantizando atención de calidad y confianza en cada paso.</p>
                    <p>Permítenos ser tu aliado para que cada viaje con VIVE YA TRAVEL sea memorable y a tu medida.</p>
                </div>

            </div>
        </div>
    </section>

    <!-- OPINIONES -->
    <section class="bg-light py-5">
        <div class="container text-center">
            <h2 class="text-primary fw-bold mb-5"></h2>
                    <!-- Grupo 1 -->
                <div id="carouselOpiniones" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">

                <!-- Grupo 1 -->
                <div class="carousel-item active">
                    <div class="row g-4 justify-content-center">
                        <div class="col-md-4">
                            <div class="card shadow-sm h-100">
                                <div class="card-body">
                                    <p class="fst-italic">“Gracias a Vive Ya Travel tuve el mejor viaje de mi vida a Cusco. ¡Excelente servicio y atención!”</p>
                                    <h6 class="fw-bold mt-3 text-primary">– Ana Rodríguez</h6>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="card shadow-sm h-100">
                                <div class="card-body">
                                    <p class="fst-italic">“Todo fue perfecto desde la reserva hasta el regreso. Muy recomendados para viajar en familia.”</p>
                                    <h6 class="fw-bold mt-3 text-primary">– Carlos Mendoza</h6>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="card shadow-sm h-100">
                                <div class="card-body">
                                    <p class="fst-italic">“Excelente atención personalizada. Me ayudaron a planificar mi luna de miel sin preocupaciones.”</p>
                                    <h6 class="fw-bold mt-3 text-primary">– Sofía Torres</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Grupo 2 -->
                <div class="carousel-item">
                    <div class="row g-4 justify-content-center">
                        <div class="col-md-4">
                            <div class="card shadow-sm h-100">
                                <div class="card-body">
                                    <p class="fst-italic">“Viajamos a Iquitos con Vive Ya Travel y todo fue increíble. Puntuales y atentos en cada detalle.”</p>
                                    <h6 class="fw-bold mt-3 text-primary">– Luis Fernández</h6>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="card shadow-sm h-100">
                                <div class="card-body">
                                    <p class="fst-italic">“Un servicio de primera. Cumplieron con todo lo prometido y más. Volveré a viajar con ellos.”</p>
                                    <h6 class="fw-bold mt-3 text-primary">– María Gutiérrez</h6>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="card shadow-sm h-100">
                                <div class="card-body">
                                    <p class="fst-italic">“Recomiendo 100%. Me ayudaron con mi viaje a Arequipa y fue una experiencia sin igual.”</p>
                                    <h6 class="fw-bold mt-3 text-primary">– Jorge Ramos</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- CARRUSEL DE OPINIONES -->
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselOpiniones" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselOpiniones" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Siguiente</span>
            </button>

            <!-- Indicadores -->
            <div class="carousel-indicators mt-4">
                <button type="button" data-bs-target="#carouselOpiniones" data-bs-slide-to="0" class="active" aria-label="Grupo 1"></button>
                <button type="button" data-bs-target="#carouselOpiniones" data-bs-slide-to="1" aria-label="Grupo 2"></button>
            </div>
        </div>
    </div>
</section>
    
    <!-- Sección: Videos -->
    <section class=
        </div>
    </section>

    <!-- VIDEOS -->
    <section class="container my-5">
        <h2 class="text-center text-primary fw-bold mb-4">VIVE EXPERIENCIAS, VIVE YA TRAVEL</h2>
        <div class="row g-4">
            <div class="col-md-6">
                <div class="ratio ratio-16x9 shadow rounded-4">
                    <iframe src="https://www.youtube.com/embed/mZgDvY6ENkM" title="TOUR FULL DAY PARACAS ICA - HUACACHINA" allowfullscreen></iframe>
                </div>
            </div>
            <div class="col-md-6">
                <div class="ratio ratio-16x9 shadow rounded-4">
                    <iframe src="https://www.youtube.com/embed/7biaualce90" title="Tour Full Day Playa Tuquillo" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>