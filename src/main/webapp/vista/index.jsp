<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Metadata para configurar el contenido y el juego de caracteres de la página -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vive Ya Travel</title>
        <!-- Enlaces a hojas de estilo externas e internas -->
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/carrusel.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="styles.css" />
        <script src="//code.tidio.co/5al8l06rqcmi3eecttdrth0mcufr1dhb.js" async></script>
    </head>
    <body>
        <!-- Incluir el encabezado de la página -->
        <jsp:include page="header.jsp"/>
        <main>
            <!-- Sección del carrusel de imágenes -->
            <div class="carrusel-body">
                <div class="contenedor-carrusel">
                    <div class="carruseles" id="slider">
                        <section class="slider-section">
                            <img src="${pageContext.request.contextPath}/img/1.jpg" alt="Machu Pichu"/>
                        </section>
                        <section class="slider-section">
                            <img src="${pageContext.request.contextPath}/img/2.jpg" alt="Ica"/>
                        </section>
                        <section class="slider-section">
                            <img src="${pageContext.request.contextPath}/img/3.jpg" alt="Castillo de Chancay"/>
                        </section>
                    </div>
                        <!-- Botón para mover el carrusel a la izquierda -->
                    <div class="btn-left"><i class='bx bxs-chevron-left'></i></div>
                    <!-- Botón para mover el carrusel a la derecha -->
                    <div class="btn-right"><i class='bx bxs-chevron-right'></i></div>
                </div>
            </div>

            <!-- Título principal de la sección de aventuras -->
            <h1 class="heading-1">DESCUBRE TU NUEVA AVENTURA</h1>

                 <!-- Sección de características destacadas -->
            <section class="container container-features">
                <div class="card-feature">
                    <i class="fa-solid fa-plane-up"></i>
                    <div class="feature-content">
                        <span>Viajes a nivel nacional</span>
                        <p>Valor superior a $150</p>
                    </div>
                </div>
                <div class="card-feature">
                    <i class="fa-solid fa-wallet"></i>
                    <div class="feature-content">
                        <span>Contrareembolso</span>
                        <p>100% garantía de devolución de dinero</p>
                    </div>
                </div>
                <div class="card-feature">
                    <i class="fa-solid fa-gift"></i>
                    <div class="feature-content">
                        <span>Tarjeta regalo especial</span>
                        <p>Ofrece bonos especiales con regalo</p>
                    </div>
                </div>
                <div class="card-feature">
                    <i class="fa-solid fa-headset"></i>
                    <div class="feature-content">
                        <span>Servicio al cliente 24/7</span>
                        <p>LLámenos 24/7 al 123-456-7890</p>
                    </div>
                </div>
            </section>





            <!-- Título principal de la sección de paquetes turísticos -->

            <h1 class="heading-1">PAQUETES TURISTICOS</h1>
            <section class="container top-products">
                <div class="container-products">
                    <!-- Paquete 1 -->
                    <div class="card-product">
                        <div class="container-img">
                            <img src="${pageContext.request.contextPath}/paquetes/machu_picchu.jpg" alt="Machu Picchu" />
                            <div class="button-group">
                                <span><i class="fa-regular fa-eye"></i></span>
                                <span><i class="fa-regular fa-heart"></i></span>
                                <span><i class="fa-solid fa-code-compare"></i></span>
                            </div>
                        </div>
                        <div class="content-card-product">
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                            </div>
                            <h3>Paquete a Machu Picchu</h3>
                            <h4>Desde Mié 25 Set  Hasta Lun 30 Set</h4>
                            <h5>Vuelo directo</h5>
                            <a href="main.jsp" ><span class="add-cart"><i class="fa-solid fa-basket-shopping"></i></span></a>
                            <p class="price">$500.00</p>
                        </div>
                    </div>
                    <!-- Paquete 2 -->
                    <div class="card-product">
                        <div class="container-img">
                            <img src="${pageContext.request.contextPath}/paquetes/amazonas.png" alt="Amazonas" />
                            <div class="button-group">
                                <span><i class="fa-regular fa-eye"></i></span>
                                <span><i class="fa-regular fa-heart"></i></span>
                                <span><i class="fa-solid fa-code-compare"></i></span>
                            </div>
                        </div>
                        <div class="content-card-product">
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                            </div>
                            <h3>Paquete a Amazonas</h3>
                            <h4>Desde Mié 25 Set  Hasta Lun 30 Set</h4>
                            <h5>Vuelo directo</h5>
                            <a href="main.jsp" ><span class="add-cart"><i class="fa-solid fa-basket-shopping"></i></span></a>
                            <p class="price">$700.00</p>
                        </div>
                    </div>
                    <!-- Paquete 3 -->
                    <div class="card-product">
                        <div class="container-img">
                            <img src="${pageContext.request.contextPath}/paquetes/titicaca.jpg" alt="Lago Titicaca" />
                            <div class="button-group">
                                <span><i class="fa-regular fa-eye"></i></span>
                                <span><i class="fa-regular fa-heart"></i></span>
                                <span><i class="fa-solid fa-code-compare"></i></span>
                            </div>
                        </div>
                        <div class="content-card-product">
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                            </div>
                            <h3>Paquete a Lago Titicaca</h3>
                            <h4>Desde Mié 25 Set  Hasta Lun 30 Set</h4>
                            <h5>Vuelo directo</h5>
                            <a href="main.jsp" ><span class="add-cart"><i class="fa-solid fa-basket-shopping"></i></span></a>
                            <p class="price">$600.00</p>
                        </div>
                    </div>
                    <!-- Paquete 4 -->
                    <div class="card-product">
                        <div class="container-img">
                            <img src="${pageContext.request.contextPath}/paquetes/marcahuasi.png" alt="Marcahuasi" />
                            <div class="button-group">
                                <span><i class="fa-regular fa-eye"></i></span>
                                <span><i class="fa-regular fa-heart"></i></span>
                                <span><i class="fa-solid fa-code-compare"></i></span>
                            </div>
                        </div>
                        <div class="content-card-product">
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                            </div>
                            <h3>Paquete a Marcahuasi</h3>
                            <h4>Desde Mié 25 Set  Hasta Lun 30 Set</h4>
                            <h5>Vuelo directo</h5>
                            <a href="main.jsp" ><span class="add-cart"><i class="fa-solid fa-basket-shopping"></i></span></a>
                            <p class="price">$450.00</p>
                        </div>
                    </div>
                    <!-- Paquete 5 -->
                    <div class="card-product">
                        <div class="container-img">
                            <img src="${pageContext.request.contextPath}/paquetes/manu.png" alt="Reserva Nacional del Manu" />
                            <div class="button-group">
                                <span><i class="fa-regular fa-eye"></i></span>
                                <span><i class="fa-regular fa-heart"></i></span>
                                <span><i class="fa-solid fa-code-compare"></i></span>
                            </div>
                        </div>
                        <div class="content-card-product">
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                            </div>
                            <h3>Paquete a Reserva Nacional del Manu</h3>
                            <h4>Desde Mié 25 Set  Hasta Lun 30 Set</h4>
                            <h5>Vuelo directo</h5>
                            <a href="main.jsp" ><span class="add-cart"><i class="fa-solid fa-basket-shopping"></i></span></a>
                            <p class="price">$800.00</p>
                        </div>
                    </div>
                    <!-- Paquete 6 -->
                    <div class="card-product">
                        <div class="container-img">
                            <img src="${pageContext.request.contextPath}/paquetes/choquequirao.png" alt="Choquequirao" />
                            <div class="button-group">
                                <span><i class="fa-regular fa-eye"></i></span>
                                <span><i class="fa-regular fa-heart"></i></span>
                                <span><i class="fa-solid fa-code-compare"></i></span>
                            </div>
                        </div>
                        <div class="content-card-product">
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                            </div>
                            <h3>Paquete a Choquequirao</h3>
                            <h4>Desde Mié 25 Set  Hasta Lun 30 Set</h4>
                            <h5>Vuelo directo</h5>
                            <a href="main.jsp" ><span class="add-cart"><i class="fa-solid fa-basket-shopping"></i></span></a>
                            <p class="price">$600.00</p>
                        </div>
                    </div>

                    <!-- Paquete 7 -->
                    <div class="card-product">
                        <div class="container-img">
                            <img src="${pageContext.request.contextPath}/paquetes/paracas.png" alt="Paracas" />
                            <div class="button-group">
                                <span><i class="fa-regular fa-eye"></i></span>
                                <span><i class="fa-regular fa-heart"></i></span>
                                <span><i class="fa-solid fa-code-compare"></i></span>
                            </div>
                        </div>
                        <div class="content-card-product">
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                            </div>
                            <h3>Paquete a Paracas</h3>
                            <h4>Desde Mié 25 Set  Hasta Lun 30 Set</h4>
                            <h5>Vuelo directo</h5>
                            <a href="main.jsp" ><span class="add-cart"><i class="fa-solid fa-basket-shopping"></i></span></a>
                            <p class="price">$300.00</p>
                        </div>
                    </div>        


                    <!-- Paquete 8 -->
                    <div class="card-product">
                        <div class="container-img">
                            <img src="${pageContext.request.contextPath}/paquetes/lunahuana.png" alt="Lunahuana" />
                            <div class="button-group">
                                <span><i class="fa-regular fa-eye"></i></span>
                                <span><i class="fa-regular fa-heart"></i></span>
                                <span><i class="fa-solid fa-code-compare"></i></span>
                            </div>
                        </div>
                        <div class="content-card-product">
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                            </div>
                            <h3>Paquete a Lunahuana</h3>
                            <h4>Desde Mié 25 Set  Hasta Lun 30 Set</h4>
                            <h5>Directo</h5>
                            <a href="main.jsp" ><span class="add-cart"><i class="fa-solid fa-basket-shopping"></i></span></a>
                            <p class="price">$100.00</p>
                        </div>
                    </div>

                    <!-- Paquete 9 -->
                    <div class="card-product">
                        <div class="container-img">
                            <img src="${pageContext.request.contextPath}/paquetes/chancay.png" alt="Chancay" />
                            <div class="button-group">
                                <span><i class="fa-regular fa-eye"></i></span>
                                <span><i class="fa-regular fa-heart"></i></span>
                                <span><i class="fa-solid fa-code-compare"></i></span>
                            </div>
                        </div>
                        <div class="content-card-product">
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                            </div>
                            <h3>Paquete a Chancay</h3>
                            <h4>Desde Mié 25 Set  Hasta Lun 30 Set</h4>
                            <h5>Directo</h5>
                            <a href="main.jsp" ><span class="add-cart"><i class="fa-solid fa-basket-shopping"></i></span></a>
                            <p class="price">$80.00</p>
                        </div>
                    </div>

                    <!-- Paquete 10 -->
                    <div class="card-product">
                        <div class="container-img">
                            <img src="${pageContext.request.contextPath}/paquetes/canta.png" alt="Canta" />
                            <div class="button-group">
                                <span><i class="fa-regular fa-eye"></i></span>
                                <span><i class="fa-regular fa-heart"></i></span>
                                <span><i class="fa-solid fa-code-compare"></i></span>
                            </div>
                        </div>
                        <div class="content-card-product">
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                            </div>
                            <h3>Paquete a Canta</h3>
                            <h4>Desde Mié 25 Set  Hasta Lun 30 Set</h4>
                            <h5>Directo</h5>
                            <a href="main.jsp" ><span class="add-cart"><i class="fa-solid fa-basket-shopping"></i></span></a>
                            <p class="price">$80.00</p>
                        </div>
                    </div>  

                </div>
            </section>
        </main>
                            
        <!-- Incluir el pie de página -->
        <jsp:include page="footer.jsp"/>
        <script src="https://kit.fontawesome.com/81581fb069.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/js/carrusel.js" type="text/javascript"></script>
    </body>
</html>