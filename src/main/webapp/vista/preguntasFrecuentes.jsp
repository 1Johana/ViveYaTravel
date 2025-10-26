<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Preguntas Frecuentes | Vive Ya Travel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/header.css" rel="stylesheet" type="text/css"/>
    <link href="../css/footer.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="../css/preguntas.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
    <body>
        <jsp:include page="header.jsp"/>
        <div style="height: 80px;"></div> 

        <div class="container faq-container mt-5">
        <div class="row g-0">
            
            <div class="col-md-4 faq-sidebar">
                <h5></h5>
                <nav class="nav flex-column" id="faq-categories">
                    <a class="nav-link active" href="#paquetes" data-bs-toggle="tab">Paquetes</a>
                    <a class="nav-link" href="#equipaje" data-bs-toggle="tab">Equipaje y asientos</a>
                    <a class="nav-link" href="#devoluciones" data-bs-toggle="tab">Devoluciones y cancelaciones</a>
                    <a class="nav-link" href="#cuenta" data-bs-toggle="tab">Mi cuenta</a>
                    <a class="nav-link" href="#reserva" data-bs-toggle="tab">Mi reserva</a>
                </nav>
            </div>

            <div class="col-md-8 faq-content tab-content">
                <h2 class="faq-title">Preguntas Frecuentes</h2>

                <!-- Paquetes -->
                <div class="tab-pane fade show active" id="paquetes">
                    <div class="accordion" id="accordionPaquetes">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#paq1">
                                    ¿Qué incluye un paquete turístico?
                                </button>
                            </h2>
                            <div id="paq1" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Nuestros paquetes incluyen transporte, alojamiento en hoteles seleccionados y,
                                    dependiendo del destino, actividades o excursiones. Los detalles exactos se especifican en 
                                    la descripción de cada paquete.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#paq2">
                                    ¿Puedo personalizar mi paquete?
                                </button>
                            </h2>
                            <div id="paq2" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    La mayoría de nuestros paquetes son flexibles. Puedes solicitar añadir o eliminar noches de hotel, 
                                    cambiar la categoría de alojamiento, o incluir excursiones locales adicionales contactando 
                                    a nuestros agentes.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#paq3">
                                    ¿Necesito pasaporte o visa para reservar?
                                </button>
                            </h2>
                            <div id="paq3" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Para viajes internacionales, el pasaporte es obligatorio con validez mínima de 6 meses post-viaje, 
                                    y la visa depende de su nacionalidad y destino. Para viajes nacionales, solo se requiere una 
                                    identificación oficial vigente
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#paq4">
                                    ¿Los paquetes incluyen seguro de viaje?
                                </button>
                            </h2>
                            <div id="paq4" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Los paquetes internacionales de alta gama suelen incluir seguro. Para el resto, 
                                    recomendamos enfáticamente añadir una póliza de asistencia al viajero que cubra emergencias médicas,
                                    cancelaciones y pérdida de equipaje en cualquier destino.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#paq5">
                                    ¿El precio de los paquetes incluye impuestos?
                                </button>
                            </h2>
                            <div id="paq5" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Sí, el precio final mostrado en nuestra web incluye la mayoría de las tasas aéreas e impuestos 
                                    obligatorios. Las excepciones (como impuestos turísticos locales pagaderos en destino) se especifican 
                                    claramente en el voucher.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#paq6">
                                    ¿Qué sucede si necesito hacer una escala o conexión en mi ruta?
                                </button>
                            </h2>
                            <div id="paq6" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Si su itinerario incluye escalas, el paquete cubre todos los tramos. Es su responsabilidad conocer 
                                    y cumplir las regulaciones de tránsito o visa del país de escala, especialmente en rutas internacionales.
                                </div>
                            </div>
                        </div>  
                    </div>
                </div>

                <!-- Equipaje y asientos -->
                <div class="tab-pane fade" id="equipaje">
                    <div class="accordion" id="accordionEquipaje">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#eq1">
                                    ¿Cuánto equipaje está permitido en mi viaje internacional/nacional?
                                </button>
                            </h2>
                            <div id="eq1" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Depende de la aerolínea y la tarifa. La mayoría de los vuelos incluyen una maleta de mano. 
                                    El equipaje facturado (documentado) es extra en tarifas económicas. 
                                    Siempre verifique los límites específicos en su voucher o directamente con la aerolínea.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#eq2">
                                    ¿Cuáles son las restricciones de líquidos para vuelos internacionales?
                                </button>
                            </h2>
                            <div id="eq2" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    La norma estándar internacional es de 100 ml por envase, y todos deben caber en una bolsa transparente
                                    de 1 litro. Las regulaciones nacionales suelen ser menos estrictas, pero es recomendable seguir la 
                                    regla de los 100 ml en cabina.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#eq3">
                                    ¿Cómo puedo seleccionar mis asientos en el avión?
                                </button>
                            </h2>
                            <div id="eq3" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Puede hacerlo durante la reserva o utilizando el código localizador de la aerolínea en su sitio web. 
                                    Algunas aerolíneas permiten la selección gratuita durante el check-in online (24 horas antes del vuelo);
                                    la selección anticipada puede tener costo.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#eq4">
                                    ¿Qué hago si mi equipaje se pierde en un destino extranjero o nacional?
                                </button>
                            </h2>
                            <div id="eq4" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Reporte el incidente inmediatamente en el mostrador de la aerolínea en el aeropuerto antes de salir. 
                                    Guarde su talón de equipaje y el P.I.R. (Parte de Irregularidad) para tramitar la compensación por la
                                    aerolínea o el seguro.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#eq5">
                                    ¿Se puede llevar mascotas en los viajes
                                </button>
                            </h2>
                            <div id="eq5" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    La política varía. Se requiere documentación y jaulas especiales. Las mascotas pequeñas suelen ir en 
                                    cabina con costo adicional; las grandes, en bodega. Solo se aceptan previa aprobación de la 
                                    aerolínea/hotel.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#eq6">
                                    ¿El traslado entre el aeropuerto y el hotel está siempre incluido?
                                </button>
                            </h2>
                            <div id="eq6" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    No siempre. Revise su voucher: si incluye "Traslados", sí. Si no, podemos cotizar y añadir servicios 
                                    de transporte privado o compartido en su destino.
                                </div>
                            </div>
                        </div>                       
                    </div>
                </div>

                <!-- Devoluciones y cancelaciones -->
                <div class="tab-pane fade" id="devoluciones">
                    <div class="accordion" id="accordionDevoluciones">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#dev1">
                                    ¿Cómo solicito un cambio o cancelación de mi viaje?
                                </button>
                            </h2>
                            <div id="dev1" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Todas las solicitudes deben hacerse por escrito a su asesor de viajes. La fecha de recepción de su
                                    email es considerada la fecha de cancelación formal para calcular las penalidades.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#dev2">
                                    ¿Cuánto tiempo tarda en procesarse un reembolso?
                                </button>
                            </h2>
                            <div id="dev2" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Tras la aprobación del proveedor (aerolínea/hotel), el proceso puede tomar entre 15 y 45 días hábiles
                                    para verse reflejado en su cuenta, dependiendo del sistema bancario y del proveedor involucrado.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#dev3">
                                    ¿Se pueden cambiar los nombres de los pasajeros en una reserva?
                                </button>
                            </h2>
                            <div id="dev3" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Los cambios de nombre en billetes aéreos (nacionales e internacionales) suelen estar prohibidos o 
                                    acarrear una alta penalidad. Es vital que los nombres en la reserva coincidan exactamente con el 
                                    documento de identidad/pasaporte.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#dev4">
                                    ¿Qué sucede si mi vuelo internacional/nacional es cancelado por la aerolínea?
                                </button>
                            </h2>
                            <div id="dev4" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Si la aerolínea cancela, le ofreceremos alternativas (otro vuelo, misma ruta) o un reembolso completo
                                    del tramo aéreo afectado, según las regulaciones internacionales y de consumo.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#dev5">
                                    ¿Cubre mi seguro de viaje las cancelaciones por causas personales (enfermedad)?
                                </button>
                            </h2>
                            <div id="dev5" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Si contrató un seguro con cobertura de cancelación "por cualquier causa" o "por motivos de salud", sí.
                                    Debe presentar la documentación médica requerida directamente a la aseguradora para iniciar el reclamo.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#dev6">
                                    ¿Las reservas de último minuto tienen políticas de cancelación diferentes?
                                </button>
                            </h2>
                            <div id="dev6" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Sí, las reservas realizadas con pocos días de antelación suelen tener políticas más estrictas y, 
                                    a menudo, son de pago total e inmediato, sin posibilidad de reembolso si se cancelan.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Mi cuenta -->
                <div class="tab-pane fade" id="cuenta">
                    <div class="accordion" id="accordionCuenta">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#cuenta1">
                                    ¿Cómo puedo actualizar mis datos personales?
                                </button>
                            </h2>
                            <div id="cuenta1" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Puedes hacerlo desde la sección “Mi cuenta” iniciando sesión, o contactando con nuestro equipo 
                                    de soporte si olvidaste tus credenciales.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#cuenta2">
                                    ¿Cómo recupero mi contraseña si la olvidé?
                                </button>
                            </h2>
                            <div id="cuenta2" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    En la pantalla de inicio de sesión, haga clic en "¿Olvidaste tu contraseña?". 
                                    Le enviaremos un enlace a su correo electrónico para crear una nueva de inmediato.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#cuenta3">
                                    ¿Es obligatorio registrarse para comprar un paquete?
                                </button>
                            </h2>
                            <div id="cuenta3" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    No. Puede comprar como invitado, pero le recomendamos registrarse para simplificar futuras reservas 
                                    y acceder a su historial de viajes.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#cuenta4">
                                    ¿Dónde veo mis viajes que ya reservé?
                                </button>
                            </h2>
                            <div id="cuenta4" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Inicie sesión y haga clic en la sección "Mis Reservas". Ahí encontrará el estado y los detalles de todos 
                                    sus viajes activos y pasados.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#cuenta5">
                                    ¿Cómo puedo cambiar mi teléfono o email?
                                </button>
                            </h2>
                            <div id="cuenta5" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    En la pantalla de "Mi Cuenta" y luego a la sección "Editar Perfil". 
                                    Simplemente actualice la información y guarde los cambios.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#cuenta6">
                                    ¿Mi información de pasaporte y pago está segura?
                                </button>
                            </h2>
                            <div id="cuenta6" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Sí. Toda la información sensible que guarde está protegida con cifrado avanzado, 
                                    garantizando su total seguridad y privacidad.
                                </div>
                            </div>
                        </div>                      
                    </div>
                </div>
                
                <!-- Mi reserva -->
                <div class="tab-pane fade" id="reserva">
                    <div class="accordion" id="accordionReserva">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#res1">
                                    ¿Cómo y cuándo recibiré mis documentos de viaje (vouchers y billetes)?
                                </button>
                            </h2>
                            <div id="res1" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Los documentos finales se envían por correo electrónico generalmente entre 7 y 14 días antes de la 
                                    salida, una vez que el pago total del paquete ha sido liquidado y todos los servicios han sido 
                                    emitidos por los proveedores.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#res2">
                                    ¿Qué tipo de documentos necesito llevar para viajar al extranjero?
                                </button>
                            </h2>
                            <div id="res2" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Necesitará su pasaporte original, cualquier visa requerida, el billete de avión electrónico 
                                    (e-ticket), el voucher de hotel y, a menudo, prueba de un seguro de viaje válido.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#res3">
                                    ¿Es necesario reconfirmar mi vuelo o reserva de hotel?
                                </button>
                            </h2>
                            <div id="res3" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Se recomienda encarecidamente reconfirmar su vuelo (especialmente los internacionales) 24 horas antes
                                    de la salida. Nosotros nos encargamos de confirmar las reservas de hotel por usted.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#res4">
                                    ¿Qué debo hacer si hay una discrepancia en mi reserva al llegar al hotel o aeropuerto?
                                </button>
                            </h2>
                            <div id="res4" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Muestre su voucher o billete electrónico. Si el problema persiste, llame de inmediato a nuestro número de 
                                    soporte de emergencia (disponible 24/7 en su voucher) para que nuestro equipo lo resuelva con el proveedor.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#res5">
                                    ¿Se requiere algún tipo de vacunación para mi destino internacional?
                                </button>
                            </h2>
                            <div id="res5" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    Algunos países requieren vacunas específicas (ej. Fiebre Amarilla). Consulte las recomendaciones del 
                                    Ministerio de Salud de su país y la información de la embajada del destino antes de viajar.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#res6">
                                    ¿Cómo se realiza el pago en moneda extranjera para mi paquete internacional?
                                </button>
                            </h2>
                            <div id="res6" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    El pago se procesa en su moneda local, utilizando la tasa de cambio vigente del día de la transacción.
                                    Si usa tarjeta internacional, su banco aplicará su propia tasa de conversión.
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
    </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
