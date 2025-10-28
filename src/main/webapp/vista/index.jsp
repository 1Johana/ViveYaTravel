<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vive Ya Travel</title>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet" type="text/css"/> 
        
        <script src="//code.tidio.co/5al8l06rqcmi3eecttdrth0mcufr1dhb.js" async></script>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <main>
            <section class="hero-slider">
                <div class="hero-bg">
                    <div class="bg-slide active" style="background-image: url('${pageContext.request.contextPath}/img/1.jpg');"></div>
                    <div class="bg-slide" style="background-image: url('${pageContext.request.contextPath}/img/2.jpg');"></div>
                    <div class="bg-slide" style="background-image: url('${pageContext.request.contextPath}/img/3.jpg');"></div>
                </div>
                <div class="content-wrapper">
                    <div class="adventure-text">
                        <p class="location-area">CUZCO</p>
                        <h1 class="location-name">MACHU PICCHU</h1>
                        <p class="explore-text">
                            VIAJA Y DESCUBRE LUGARES NUEVOS
                        </p>

                    </div>
                    <div class="nav-arrows" style="display:none;">
                        <button class="prev-btn"><i class='bx bx-chevron-left'></i></button>
                        <button class="next-btn"><i class='bx bx-chevron-right'></i></button>
                    </div>
                </div>
                
                <div class="card-slider-container">
                    <div class="card-wrapper">
                        <div class="card" data-index="0">
                            <img src="${pageContext.request.contextPath}/img/1.jpg" alt="Saint Antönien"/>
                            <h3>MACHU PICCHU</h3>
                        </div>
                        <div class="card" data-index="1">
                            <img src="${pageContext.request.contextPath}/img/2.jpg" alt="Nagano Prefecture"/>
                            <h3>LUNAHUANA</h3>
                        </div>
                        <div class="card" data-index="2">
                            <img src="${pageContext.request.contextPath}/img/3.jpg" alt="Marrakech Merzouga"/>
                            <h3>CASTILLO DE CHANCAY</h3>
                        </div>
                    </div>
                </div>
            </section>
                            <!-- Sección de destinos populares -->
            <section class="trending-destinations">
                <div class="trending-header">
                    <h2>Destinos mas Visitados</h2>
                    <p>Descubre el paraíso en cada rincón del mundo, nosotros te llevamos hasta allí.</p>
                </div>

                <div class="trending-gallery">
                <div class="destination-card">
                     <img src="${pageContext.request.contextPath}/img/iquitos.jpg" alt="iquitos">
                    <h4>Iquitos</h4>
                </div>
                <div class="destination-card">
                    <img src="${pageContext.request.contextPath}/img/machupicchu.jpg" alt="machupicchu">
                    <h4>Machu Picchu</h4>
                </div>
                <div class="destination-card">
                     <img src="${pageContext.request.contextPath}/img/lagotiticaca.jpg" alt="lagotiticaca">
                    <h4>Lago Titicaca</h4>
                </div>
                <div class="destination-card">
                    <img src="${pageContext.request.contextPath}/img/arequipa.jpg" alt="arequipa">
                    <h4>La Ciudad Blanca</h4>
                </div>
                <div class="destination-card">
                    <img src="${pageContext.request.contextPath}/img/vallesagrado.jpg" alt="vallesagrado">
                    <h4>Valle Sagrado</h4>
                </div>
                <div class="destination-card">
                    <img src="${pageContext.request.contextPath}/img/tingomaria.jpg" alt="tingomaria">
                    <h4>Cueva de las Lechuzas</h4>
                </div>
            </div>
            </section>
                    <section class="travel-section">
                        <div class="travel-bg">
                            <img src="${pageContext.request.contextPath}/img/tersec.jpg" alt="tersec">
                        </div>
                        <div class="travel-bg">
                            <img src="${pageContext.request.contextPath}/img/tersec.jpg" alt="tersec">
                        </div>
                        <div class="travel-container">
                            <!-- LADO IZQUIERDO: TEXTO -->
                        <div class="travel-text">
                            <h2>VIAJA Y DISFRUTA DE TUS VACACIONES</h2>
                            <p class="subtitle">
                                <i class='bx bx-play-circle'></i> elige tus divertidas vacaciones
                            </p>
                            <p class="description">
                                Deja atrás la rutina y vive experiencias inolvidables. Descubre nuevos destinos, 
                                culturas fascinantes y paisajes que te dejarán sin aliento. Ya sea que prefieras 
                                relajarte en una playa de aguas cristalinas, explorar montañas imponentes o 
                                perderte entre las calles de una ciudad vibrante, tus vacaciones merecen ser únicas.
                                <br><br>
                                ¡El mundo te espera para que lo disfrutes al máximo! 🌎✨
                            </p>
                            
                        </div>
                             <!-- LADO DERECHO: VIDEOS -->
                            <div class="travel-videos">
                                <div class="video-item">
                                    <iframe 
                                        src="https://www.youtube.com/embed/Lc2s4OTfkZ0?start=22&autoplay=1&mute=1&loop=1&playlist=Lc2s4OTfkZ0&controls=0&modestbranding=1&showinfo=0"
                                        title="YouTube video player"
                                        frameborder="0"
                                        allow="autoplay; fullscreen; picture-in-picture"
                                        allowfullscreen>
                                    </iframe>
                                </div>
                                <div class="video-item">
                                    <iframe 
                                        src="https://www.youtube.com/embed/kEwfNR-UYqA?autoplay=1&mute=1&loop=1&playlist=kEwfNR-UYqA&controls=0&modestbranding=1&showinfo=0"
                                        title="YouTube video player"
                                        frameborder="0"
                                        allow="autoplay; fullscreen; picture-in-picture"
                                        allowfullscreen>                                            
                                    </iframe>
                                </div>    
                                <div class="video-item">
                                    <iframe 
                                        src="https://www.youtube.com/embed/ZDBAUP_3hc4?start=183&autoplay=1&mute=1&loop=1&playlist=ZDBAUP_3hc4&controls=0&modestbranding=1&showinfo=0"
                                        title="Video de YouTube - ViveYaTravel"
                                        frameborder="0"
                                        allow="autoplay; fullscreen; picture-in-picture"
                                        allowfullscreen>
                                    </iframe>
                                </div>                               
                                <div class="video-item">
                                    <iframe 
                                        src="https://www.youtube.com/embed/4OBQZKvnves?start=4&autoplay=1&mute=1&loop=1&playlist=4OBQZKvnves&controls=0&modestbranding=1&showinfo=0"
                                        title="YouTube video player - ViveYaTravel"
                                        frameborder="0"
                                        allow="autoplay; fullscreen; picture-in-picture"
                                        allowfullscreen>
                                    </iframe>
                                </div>
                            </div>
                        </div>     
                    </section>
                    <section class="steps-section">
            <div class="steps-content">
                <div class="steps-text">
                    <p class="section-subtitle">Cómo funciona</p>
                    <h2>3 Pasos Simples para Tu Próxima Aventura</h2>

                    <div class="step">
                        <div class="icon" style="background-color: #ffb6c1;">①</div>
                        <div class="step-info">
                            <h4>Buscar destino</h4>
                            <p>Explora las culturas vibrantes o relájate en sus impresionantes playas.</p>
                        </div>
                    </div>

                    <div class="step">
                        <div class="icon" style="background-color: #b2c5ff;">②</div>
                        <div class="step-info">
                            <h4>Elegir fechas</h4>
                            <p>¡Elige tu escapada perfecta! Evalua tu fecha de viaje y explora nuevos destinos increíbles.</p>
                        </div>
                    </div>

                    <div class="step">
                        <div class="icon" style="background-color: #ffe6a1;">③</div>
                        <div class="step-info">
                            <h4>Alista tu equipaje</h4>
                            <p>Descubre destinos extraordinarios, sumérgete en nuevas culturas y crea recuerdos que durarán toda la vida.</p>
                        </div>
                    </div>
                </div>

                <div class="steps-image">
                    <div class="main-image">
                        <img src="${pageContext.request.contextPath}/img/subebuss.jpg" alt="subebuss" class="main-photo">
                        <img src="${pageContext.request.contextPath}/img/destinobus.jpg" alt="destinobus" class="corner-image">
                        
                    </div>
                </div>
            </div>
            </section> 
                        <!-- Sección: 3 Simple Steps -->
            
                        <!-- IV Sección: Opiniones de clientes -->
            <section class="testimonials-section">
                <!-- 👇 Imagen de fondo directamente en el HTML -->
                <img src="${pageContext.request.contextPath}/img/selfie.jpg" alt="selfie" class="background-image">
                <div class="testimonials-content">
                    <!-- Lado izquierdo -->
                    <div class="testimonials-text">
                        <h2>¿Qué dicen nuestros clientes de nosotros?</h2>
                        <p>No te fíes solo de nuestras palabras. Descubre lo que nuestros viajeros opinan sobre sus increíbles viajes con nosotros.</p>

                        <div class="stats">
                            <div class="stat">
                                <h3>8.5M+</h3>
                                <p>Clientes felices</p>
                            </div>
                            <div class="stat">
                                <h3>4.8★</h3>
                                <p>Calificación general</p>
                            </div>
                        </div>
                    </div>

                    <!-- Lado derecho (tarjeta del testimonio) -->
                    <div class="testimonial-card">
                        <div class="testimonial-header">
                            <img src="${pageContext.request.contextPath}/img/comentusua.jpg" alt="comentusua" class="customer-photo">
                            <div>
                                <h4>Esther Avellanada</h4>
                                <p>San Ignacio, Trujillo</p>
                            </div>
                            <span class="rating">4.9★</span>
                        </div>

                        <p class="testimonial-text">
                            ¡Nuestro viaje a La Montaña de 7 Colores con Vive Ya Travel fue absolutamente mágico! El itinerario estaba perfectamente planificado y nuestro guía, Samit, era increíblemente amable y tenía muchísimos conocimientos.
                            La tour y los paseos fue lo mejor, y la comida estuvo deliciosa. Recomendamos encarecidamente esta empresa a cualquiera que busque una experiencia memorable.
                        </p>

                        <div class="testimonial-progress">
                            <span class="progress-start">01</span>
                            <div class="progress-bar">
                                <div class="progress-fill"></div>
                            </div>
                            <span class="progress-end">02</span>
                        </div>
                    </div>
                </div>
            </section>                        
        </main>                   
        <jsp:include page="footer.jsp"/>
        <script src="https://kit.fontawesome.com/81581fb069.js" crossorigin="anonymous"></script>
        
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                const bgSlides = document.querySelectorAll(".bg-slide");
                const cards = document.querySelectorAll(".card");
                const cardWrapper = document.querySelector(".card-wrapper");
                const adventureText = document.querySelector(".adventure-text");
                const locationArea = document.querySelector(".location-area");
                const locationName = document.querySelector(".location-name");
                
                const totalSlides = cards.length;
                let currentIndex = 0; // Índice del fondo y texto actual
                const ANIMATION_DURATION = 500; // 0.5 segundos

                const adventures = [
                    { area: "Cuzco", name: "MACCHU PICCHU" },
                    { area: "ICA", name: "LUNAHUANA" },
                    { area: "Chancay", name: "CASTILLO DE CHANCAY" }
                ];

                // Función para actualizar el fondo y el texto
                function updateContent(index) {
                    // 1. Actualiza el Fondo
                    bgSlides.forEach((slide) => slide.classList.remove("active"));
                    bgSlides[index].classList.add("active");

                    // 2. Actualiza el Texto (con transición de fade)
                    adventureText.classList.add('fading');
                    setTimeout(() => {
                        locationArea.textContent = adventures[index].area;
                        locationName.textContent = adventures[index].name;
                        adventureText.classList.remove('fading');
                    }, 500); 
                }
                
                function nextSlide() {
                 // Tarjeta actual (posición 1 visible)
                const outgoingCard = cardWrapper.children[0]; 
    
                // Tarjeta que entrará (posición 2, que será visible sin efecto)
                const incomingCard = cardWrapper.children[1]; 

                    // 🔸 Aplicar efecto de desaparición a la tarjeta activa antes de retirarla
                    outgoingCard.classList.add("disappear");

                    // 3. Cambiar el fondo y texto
                    currentIndex = (currentIndex + 1) % totalSlides;
                    updateContent(currentIndex);

                    // 4. Después de que termina la animación (0.5s)
                    setTimeout(() => {
                        // Quitar la animación
                        outgoingCard.classList.remove("disappear");

                            // Mover la tarjeta desaparecida al final
                            cardWrapper.appendChild(outgoingCard);

                            // Ocultar la tarjeta que coincide con el fondo (nuevo children[0])
                        cardWrapper.children[0].classList.add("hidden");

                            // Asegurar que las demás estén visibles
                        for (let i = 1; i < cardWrapper.children.length; i++) {
                            cardWrapper.children[i].classList.remove("hidden");
                        }
                        }, ANIMATION_DURATION);
                    }


                        // Inicialización: Ocultar la primera tarjeta (índice 0) que coincide con el fondo inicial
                    function initSlider() {
                        cards[0].classList.add("hidden"); 
                        updateContent(currentIndex);
                    }
                
                    // Iniciar la reproducción automática
                    setInterval(nextSlide, 4000); // Cambio cada 4 segundos

                    // Iniciar
                    initSlider();
                });
        </script>
    </body>
</html>