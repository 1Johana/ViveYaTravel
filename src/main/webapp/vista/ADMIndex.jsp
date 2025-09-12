<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/carrusel.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet" type="text/css"/>
    </head>
    <jsp:include page="ADMIHeader.jsp"/>
    <body>
        <main>
        </main>

        <!-- carrusel de imagenes -->
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
                <div class="btn-left"><i class='bx bxs-chevron-left'></i></div>
                <div class="btn-right"><i class='bx bxs-chevron-right'></i></div>
            </div>
        </div>
                    
                    
         
          <!-- Script Pedroooo... -->           
                    
        <section class="container top-categories">
            <h1 class="heading-1">Destinos Populares en Perú</h1>
            <div class="container-categories">
                <div class="card-category category-machu-picchu">  
                    <p>Machu Picchu</p>
                    <span>Ver más</span>
                </div>
                <div class="card-category category-amazonas">
                    <p>Amazonas</p>
                    <span>Ver más</span>
                </div>
                <div class="card-category category-lago-titicaca">
                    <p>Lago Titicaca</p>
                    <span>Ver más</span>
                </div>
            </div>
        </section>

        <section class="container top-products">
            <h1 class="heading-1">Paquetes Turísticos</h1>

            <div class="container-options">
                <span>Aventura</span>
                <span>Cultura</span>
                <span>Naturaleza</span>
            </div>

            <div class="container-products">
                <!-- Paquete 1 -->
                <div class="card-product">
                    <div class="container-img">
                        <img src="${pageContext.request.contextPath}/paquetes/machu_picchu.jpg" alt="Machu Picchu" />
                        <div class="button-group">
                            <span>
                                <i class="fa-regular fa-eye"></i>
                            </span>
                            <span>
                                <i class="fa-regular fa-heart"></i>
                            </span>
                            <span>
                                <i class="fa-solid fa-code-compare"></i>
                            </span>
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
                        <h3>Machu Picchu</h3>
                        <span class="add-cart">
                            <i class="fa-solid fa-basket-shopping"></i>
                        </span>
                        <p class="price">$500</p>
                    </div>
                </div>
                <!-- Paquete 2 -->
                <div class="card-product">
                    <div class="container-img">
                        <img src="${pageContext.request.contextPath}/paquetes/amazonas.png" alt="Amazonas" />
                        <div class="button-group">
                            <span>
                                <i class="fa-regular fa-eye"></i>
                            </span>
                            <span>
                                <i class="fa-regular fa-heart"></i>
                            </span>
                            <span>
                                <i class="fa-solid fa-code-compare"></i>
                            </span>
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
                        <h3>Amazonas</h3>
                        <span class="add-cart">
                            <i class="fa-solid fa-basket-shopping"></i>
                        </span>
                        <p class="price">$700</p>
                    </div>
                </div>
                <!-- Paquete 3 -->
                <div class="card-product">
                    <div class="container-img">
                        <img src="${pageContext.request.contextPath}/paquetes/titicaca.png" alt="Lago Titicaca" />
                        <div class="button-group">
                            <span>
                                <i class="fa-regular fa-eye"></i>
                            </span>
                            <span>
                                <i class="fa-regular fa-heart"></i>
                            </span>
                            <span>
                                <i class="fa-solid fa-code-compare"></i>
                            </span>
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
                        <h3>Lago Titicaca</h3>
                        <span class="add-cart">
                            <i class="fa-solid fa-basket-shopping"></i>
                        </span>
                        <p class="price">$600</p>
                    </div>
                </div>
                <!-- Paquete 4 -->
                <div class="card-product">
                    <div class="container-img">
                        <img src="${pageContext.request.contextPath}/paquetes/marcahuasi.png" alt="Marcahuasi" />
                        <div class="button-group">
                            <span>
                                <i class="fa-regular fa-eye"></i>
                            </span>
                            <span>
                                <i class="fa-regular fa-heart"></i>
                            </span>
                            <span>
                                <i class="fa-solid fa-code-compare"></i>
                            </span>
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
                        <h3>Marcahuasi</h3>
                        <span class="add-cart">
                            <i class="fa-solid fa-basket-shopping"></i>
                        </span>
                        <p class="price">$450</p>
                    </div>
                </div>
                <!-- Paquete 5 -->
                <div class="card-product">
                    <div class="container-img">
                        <img src="${pageContext.request.contextPath}/paquetes/manu.png" alt="Reserva Nacional del Manu" />
                        <div class="button-group">
                            <span>
                                <i class="fa-regular fa-eye"></i>
                            </span>
                            <span>
                                <i class="fa-regular fa-heart"></i>
                            </span>
                            <span>
                                <i class="fa-solid fa-code-compare"></i>
                            </span>
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
                        <h3>Reserva Nacional del Manu</h3>
                        <span class="add-cart">
                            <i class="fa-solid fa-basket-shopping"></i>
                        </span>
                        <p class="price">$800</p>
                    </div>
                </div>
                <!-- Paquete 6 -->
                <div class="card-product">
                    <div class="container-img">
                        <img src="${pageContext.request.contextPath}/paquetes/choquequirao.png" alt="Choquequirao" />
                        <div class="button-group">
                            <span>
                                <i class="fa-regular fa-eye"></i>
                            </span>
                            <span>
                                <i class="fa-regular fa-heart"></i>
                            </span>
                            <span>
                                <i class="fa-solid fa-code-compare"></i>
                            </span>
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
                        <h3>Choquequirao</h3>
                        <span class="add-cart">
                            <i class="fa-solid fa-basket-shopping"></i>
                        </span>
                        <p class="price">$600</p>
                    </div>
                </div>
                        
            </div>
                  </section>
                        
        <!-- Script Pedroooo... --> 
        
    </body>
    <script src="${pageContext.request.contextPath}/js/carrusel.js" type="text/javascript"></script>
    <jsp:include page="footer.jsp"/>
</html>
