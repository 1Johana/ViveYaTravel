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
                        <div class="carousel-inner rounded-4">
                            <div class="carousel-item active">
                                <img src="https://scontent.flim15-1.fna.fbcdn.net/v/t39.30808-6/565149298_1300511672123576_31884257409829849_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=f727a1&_nc_eui2=AeFg1jReynf2xDUQWMWkfufTNEKoiepqrDU0QqiJ6mqsNZaKeMoMjJGkaSQ81Ez7FnFAvVsMvg0gvW0oZB3RLex_&_nc_ohc=UyYsXv_cZkwQ7kNvwGbEKgn&_nc_oc=AdnBUJj_ZiRYNEUJC9hKo1vbokUbXmU8Nn3F9LjalMbj3aVSLRCroLiFG0jSZmliDeY&_nc_zt=23&_nc_ht=scontent.flim15-1.fna&_nc_gid=sGqN1cH0-h7ngj2zhi7hww&oh=00_Afeg5pgtWLMW3E67Su620Pq_XWiVgmseaYGeOn6rVrMy2g&oe=690227A3" class="d-block w-100" alt="Playa en viaje">
                            </div>
                            <div class="carousel-item">
                                <img src="https://scontent.flim15-2.fna.fbcdn.net/v/t39.30808-6/557785754_1288279163346827_3429501833302811854_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=f727a1&_nc_eui2=AeESgH2bVR8cAUCXKKjWbDB7te6CtTIklxO17oK1MiSXE8GBLqtER_PwzqNnFin18HGeqrdSym5I4sP8KMCOwCYa&_nc_ohc=v3Y5MjU2uZIQ7kNvwHmuKcW&_nc_oc=AdmI0Q3qPPLW1shs70XUlStIKNSMZ29SjPOQQXyUHpz1uezUC548hWmD4xRdxX1cyrY&_nc_zt=23&_nc_ht=scontent.flim15-2.fna&_nc_gid=h4LeJ9PQiuqTzuYZ_eLJGQ&oh=00_AfcSJGIUbDjwgp0dJcae7WlyyACTYQoUKFuYPOccHkCukg&oe=69020D8D" class="d-block w-100" alt="Montañas del Perú">
                            </div>
                            <div class="carousel-item">
                                <img src="https://scontent.flim15-2.fna.fbcdn.net/v/t39.30808-6/556604268_1283826000458810_6936830597889716811_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=f727a1&_nc_eui2=AeEICCeV9I4lx7wyvT7EonhNT9rvQWOsVvVP2u9BY6xW9StozJ37wZ-NpBWUlSGKJtKWVyXq6_H6ylg2qp8muwgr&_nc_ohc=38srLGo08JYQ7kNvwGh3UIO&_nc_oc=AdmGqkp5u10TydCVI44Fw9Fb_460ZQZyFqCUh13ojx0zcGlrzzoXsw7SN6BOxeVvUiE&_nc_zt=23&_nc_ht=scontent.flim15-2.fna&_nc_gid=12kTe8NV6XTkkcJCOTNruw&oh=00_Afei35ilbrLsF8KwNLWlV7jFahDynseiQ_aHVsQcj6ecwg&oe=6902186D" class="d-block w-100" alt="Turistas disfrutando de un tour">
                            </div>
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