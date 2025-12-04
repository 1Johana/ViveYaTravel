<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="java.util.*,com.mycompany.viveyatravel.modelo.dto.Asiento"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    List<Asiento> asientos = (List<Asiento>) request.getAttribute("asientos");
    int idPaquete = request.getAttribute("idPaquete") != null ? (int) request.getAttribute("idPaquete") : 0;
    int idBus = request.getAttribute("idBus") != null ? (int) request.getAttribute("idBus") : 1;
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Seleccionar Asiento y Pagar</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/css/header.css?v=FINAL" rel="stylesheet" type="text/css"/>

  <style>
    body { background:#f8f9fa; font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", "Liberation Sans"; }

    .page-wrap { max-width: 1200px; margin-inline:auto; padding:24px; }
    .layout {
      display: grid;
      grid-template-columns: minmax(560px, 1fr) 380px;
      gap: 28px;
      align-items: start;
    }
    @media (max-width: 992px) {
      .layout { grid-template-columns: 1fr; }
      .panel-right { position: static; }
    }

    .left { display: flex; gap: 24px; align-items: flex-start; }
    .legend { width: 200px; }
    .legend .box { width:22px; height:22px; border-radius:4px; display:inline-block; margin-right:10px; }

    .bus {
      display: grid;
      grid-template-columns: repeat(4, 70px);
      gap: 12px;
      background:#fff;
      padding: 24px;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0,0,0,0.08);
    }
    .asiento {
      border: none; border-radius: 10px; width: 70px; height: 70px;
      text-align: center; font-weight: 600; cursor: pointer;
      transition: transform .15s ease, background-color .15s ease;
      display:flex; flex-direction:column; align-items:center; justify-content:center;
      user-select:none;
    }
    .asiento svg { width: 26px; height: 26px; margin-bottom: 4px; }
    .libre { background:#4CAF50; color:#fff; }
    .ocupado { background:#E74C3C; color:#fff; cursor:not-allowed; }
    .seleccionado { background:#FFC107; color:#000; }
    .asiento:hover:not(.ocupado) { transform: scale(1.05); }

    .panel-right { width: 100%; position: sticky; top: 16px; }
    .totals-row { display:flex; justify-content:space-between; align-items:center; }
    .small-muted { font-size: .875rem; color: #6c757d; }
  </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="page-wrap">
  <h3 class="text-center mb-4">🚌 Selecciona tu asiento y paga</h3>

  <!-- Form es el contenedor de TODO para enviar junto -->
  <form action="${pageContext.request.contextPath}/srvPromocion?accion=confirmarPago" method="post" id="formAsientoPago">
    <input type="hidden" name="nombrePaquete" value="${requestScope.nombrePaquete}"/>

    <input type="hidden" name="accion" value="confirmarPago"/>
    <input type="hidden" name="idBus" value="<%=idBus%>"/>
    <input type="hidden" name="idPaquete" value="<%=idPaquete%>"/>
    <input type="hidden" name="idAsiento" id="idAsiento"/>
    <input type="hidden" name="numeroAsiento" id="numeroAsiento"/>

    <!-- EXTRAS (hidden que se actualizan con JS) -->
    <input type="hidden" name="seguroPrecio" id="seguroPrecio" value="0"/>
    <input type="hidden" name="mascotaPrecio" id="mascotaPrecio" value="0"/>
    <input type="hidden" name="extrasTotal"  id="extrasTotal"  value="0"/>

    <!-- ================== SUBTOTAL ROBUSTO ================== -->
    <c:set var="subtotal" value="0" scope="page"/>

    <c:choose>
      <c:when test="${not empty sessionScope.carrito}">
        <c:forEach var="p" items="${sessionScope.carrito}">
          <c:set var="itemSub" value="${
            empty p.subtotal
              ? ( (empty p.precioPaquete ? 0 : p.precioPaquete) * (empty p.cantidad ? 1 : p.cantidad) )
              : p.subtotal
          }" scope="page"/>
          <c:set var="subtotal" value="${subtotal + itemSub}" scope="page"/>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <fmt:parseNumber var="precioUnit" value="${
          not empty requestScope.precioPaquete ? requestScope.precioPaquete :
          (not empty param.precioPaquete ? param.precioPaquete : 0)
        }" type="number"/>
        <c:set var="subtotal" value="${precioUnit}" scope="page"/>
      </c:otherwise>
    </c:choose>

    <!-- Hidden para que el backend reciba los totales -->
    <input type="hidden" name="subtotal" id="subtotalHidden" value="${subtotal}"/>
    <input type="hidden" name="total" id="totalHidden" value="${subtotal}"/>
    <!-- 💰 Precio base por pasajero (se usa en JS para multiplicar por la cantidad de pasajeros) -->
    <input type="hidden" id="precioBase" value="${subtotal}"/>

    <!-- ========== DOS COLUMNAS ========== -->
    <div class="layout">

      <!-- IZQUIERDA: leyenda + bus -->
      <section class="left">
        <!-- Leyenda -->
        <div class="legend">
          <h5 class="mb-3">Leyenda</h5>
          <p class="mb-2"><span class="box" style="background:#4CAF50"></span>Libre</p>
          <p class="mb-2"><span class="box" style="background:#E74C3C"></span>Ocupado</p>
          <p class="mb-2"><span class="box" style="background:#FFC107"></span>Seleccionado</p>
        </div>

        <!-- Bus -->
        <div class="bus" id="bus">
          <div class="text-center" style="grid-column: span 4; margin-bottom:6px;">🧑‍✈️ PILOTO</div>

          <% if (asientos != null && !asientos.isEmpty()) {
               for (Asiento a : asientos) {
                 String clase = a.isOcupado() ? "ocupado" : "libre";
          %>
            <button type="button"
                    class="asiento <%=clase%>"
                    data-id="<%=a.getIdAsiento()%>"
                    data-codigo="<%=a.getNumero()%>"
                    <%= a.isOcupado() ? "disabled" : "" %>>
              <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16" aria-hidden="true">
                <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                <path fill-rule="evenodd" d="M8 9a7 7 0 0 0-5.468 2.795C2.11 12.09 3.523 13 5 13h6c1.477 0 2.89-.91 2.468-1.205A7 7 0 0 0 8 9z"/>
              </svg>
              <div><%=a.getNumero()%></div>
            </button>
          <% }
             } else { %>
             <div class="text-danger text-center" style="grid-column: span 4;">No hay asientos disponibles.</div>
          <% } %>
        </div>
      </section>

      <!-- DERECHA: resumen + extras + pago -->
      <aside class="panel-right">
        <div class="card shadow-sm">
          <div class="card-header bg-primary text-white">Resumen y pago</div>
          <div class="card-body">

            <!-- Info general -->
            <div class="mb-2"><strong>Paquete:</strong>
              <c:choose>
                <c:when test="${not empty requestScope.nombrePaquete}">${requestScope.nombrePaquete}</c:when>
                <c:otherwise><%=idPaquete%></c:otherwise>
              </c:choose>
            </div>

            <div class="mb-2"><strong>Bus:</strong> <%=idBus%></div>

            <!-- 🔢 Cantidad de pasajeros (único bloque) -->
            <div class="mb-3">
              <label class="form-label fw-semibold d-block" for="cantidadPasajeros">
                Pasajeros
              </label>
              <div class="input-group" style="max-width: 220px;">
                <button type="button" class="btn btn-outline-secondary" id="btnMenosPasajeros">−</button>
                <input
                  type="text"
                  class="form-control text-center"
                  id="cantidadPasajeros"
                  name="cantidadPasajeros"
                  value="1"
                  readonly
                />
                <button type="button" class="btn btn-outline-secondary" id="btnMasPasajeros">+</button>
              </div>
              <div class="form-text">
                Selecciona un asiento por cada pasajero.
              </div>
            </div>

            <div class="mb-3">
              <strong>Asiento seleccionado:</strong>
              <span id="asientoSeleccionado" class="badge text-bg-secondary">Ninguno</span>
            </div>

            <!-- Carrito compacto o promo seleccionada -->
            <c:choose>
              <c:when test="${not empty sessionScope.carrito}">
                <div class="mb-3">
                  <div class="fw-semibold mb-1">Tu carrito</div>
                  <ul class="list-group small">
                    <c:forEach var="p" items="${sessionScope.carrito}">
                      <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span>${p.nombrePaquete} × ${empty p.cantidad ? 1 : p.cantidad}</span>
                        <span>
                          S/.
                          <fmt:formatNumber value="${
                            empty p.subtotal
                              ? ( (empty p.precioPaquete ? 0 : p.precioPaquete) * (empty p.cantidad ? 1 : p.cantidad) )
                              : p.subtotal
                          }" minFractionDigits="2" maxFractionDigits="2"/>
                        </span>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </c:when>
              <c:otherwise>
                <div class="mb-3">
                  <div class="fw-semibold mb-1">Paquete seleccionado</div>
                  <ul class="list-group small">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                      <span>${empty requestScope.nombrePaquete ? 'Promoción' : requestScope.nombrePaquete}</span>
                      <span>S/. 
                        <fmt:formatNumber value="${subtotal}" minFractionDigits="2" maxFractionDigits="2"/>
                      </span>
                    </li>
                  </ul>
                </div>
              </c:otherwise>
            </c:choose>

            <!-- Extras -->
            <hr/>
            <h6 class="mb-2">Extras</h6>
            <div class="form-check">
              <input class="form-check-input extra" type="checkbox" id="chkSeguro" data-precio="15.00">
              <label class="form-check-label" for="chkSeguro">Seguro de viaje (+ S/. 15.00)</label>
            </div>
            <div class="form-check mt-2">
              <input class="form-check-input extra" type="checkbox" id="chkMascota" data-precio="20.00">
              <label class="form-check-label" for="chkMascota">Viaja con mascota (+ S/. 20.00)</label>
            </div>

            <!-- Totales -->
            <div class="mt-3">
              <div class="totals-row">
                <span>Subtotal</span>
                <strong>S/. <span id="subtotalLabel"><fmt:formatNumber value="${subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span></strong>
              </div>
              <div class="totals-row">
                <span>Extras</span>
                <strong>S/. <span id="extrasLabel">0.00</span></strong>
              </div>
              <hr class="my-2"/>
              <div class="totals-row fs-5">
                <span>Total</span>
                <strong class="text-primary">S/. <span id="totalLabel"><fmt:formatNumber value="${subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span></strong>
              </div>
              <div class="small-muted mt-1">
                * Los totales incluyen los extras seleccionados.
              </div>
            </div>

            <!-- Pago (simulado) -->
            <hr/>
            <div class="fw-semibold mb-2">Datos de pago</div>
            <div class="mb-2">
              <label for="nombreTarjeta" class="form-label">Nombre en la tarjeta</label>
              <input type="text" id="nombreTarjeta" name="nombreTarjeta" class="form-control" required>
            </div>
            <div class="mb-2">
              <label for="numTarjeta" class="form-label">Número de tarjeta</label>
              <input type="text" id="numTarjeta" name="numTarjeta" class="form-control" placeholder="4111 1111 1111 1111" required>
            </div>
            <div class="row g-2">
              <div class="col">
                <label for="exp" class="form-label">Exp.</label>
                <input type="text" id="exp" name="exp" class="form-control" placeholder="MM/AA" required>
              </div>
              <div class="col">
                <label for="cvv" class="form-label">CVV</label>
                <input type="text" id="cvv" name="cvv" class="form-control" placeholder="123" required>
              </div>
            </div>

            <!-- Acciones -->
            <div class="mt-3 d-grid gap-2">
              <a href="${pageContext.request.contextPath}/srvPromocion?accion=verCarrito" class="btn btn-outline-secondary">
                Volver al carrito
              </a>
              <button type="submit" class="btn btn-success" id="btnPagar" disabled>
                Pagar y reservar asiento
              </button>
            </div>

          </div>
        </div>
      </aside>
    </div>
    <!-- ========== /DOS COLUMNAS ========== -->

  </form>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Referencias básicas
  const botones = document.querySelectorAll('.asiento');
  const spanSeleccionado = document.getElementById('asientoSeleccionado');
  const idAsientoInput = document.getElementById('idAsiento');
  const numeroAsientoInput = document.getElementById('numeroAsiento');
  const btnPagar = document.getElementById('btnPagar');

  const extrasLabel = document.getElementById('extrasLabel');
  const totalLabel = document.getElementById('totalLabel');
  const seguroPrecio = document.getElementById('seguroPrecio');
  const mascotaPrecio = document.getElementById('mascotaPrecio');
  const extrasTotal = document.getElementById('extrasTotal');
  const subtotalHidden = document.getElementById('subtotalHidden');
  const totalHidden = document.getElementById('totalHidden');
  const precioBaseInput = document.getElementById('precioBase');

  // Pasajeros (+ / -)
  let cantidadPasajeros = 1;
  const MAX_PASAJEROS = 6;
  const MIN_PASAJEROS = 1;

  const cantidadPasajerosInput = document.getElementById('cantidadPasajeros');
  const btnMasPasajeros = document.getElementById('btnMasPasajeros');
  const btnMenosPasajeros = document.getElementById('btnMenosPasajeros');

  // Asientos seleccionados
  const seleccionados = new Set();

  function recalcularExtras() {
    const seguro = document.getElementById('chkSeguro');
    const mascota = document.getElementById('chkMascota');
    const s = seguro && seguro.checked ? parseFloat(seguro.dataset.precio) : 0;
    const m = mascota && mascota.checked ? parseFloat(mascota.dataset.precio) : 0;
    const extras = s + m;

    const subtotal = parseFloat(subtotalHidden.value || '0');
    const total = subtotal + extras;

    extrasLabel.textContent = extras.toFixed(2);
    totalLabel.textContent = total.toFixed(2);

    // Enviar al backend
    seguroPrecio.value = s.toFixed(2);
    mascotaPrecio.value = m.toFixed(2);
    extrasTotal.value  = extras.toFixed(2);
    totalHidden.value  = total.toFixed(2);
  }

  // 🔁 Subtotal en función de la cantidad de pasajeros
  function recalcularSubtotalPasajeros() {
    const precioBase = parseFloat(precioBaseInput.value || '0'); // precio por pasajero
    const nuevoSubtotal = precioBase * cantidadPasajeros;

    subtotalHidden.value = nuevoSubtotal.toFixed(2);
    document.getElementById('subtotalLabel').textContent = nuevoSubtotal.toFixed(2);

    // Recalcular total con los extras actuales
    recalcularExtras();
  }

  function actualizarCantidadPasajeros(nuevaCantidad) {
    if (nuevaCantidad < MIN_PASAJEROS) nuevaCantidad = MIN_PASAJEROS;
    if (nuevaCantidad > MAX_PASAJEROS) nuevaCantidad = MAX_PASAJEROS;

    cantidadPasajeros = nuevaCantidad;
    cantidadPasajerosInput.value = nuevaCantidad;

    // Si hay más asientos seleccionados que pasajeros, deseleccionamos algunos
    while (seleccionados.size > cantidadPasajeros) {
      const id = Array.from(seleccionados).pop();
      seleccionados.delete(id);
      const btn = document.querySelector('.asiento[data-id="' + id + '"]');
      if (btn) btn.classList.remove('seleccionado');
    }

    actualizarResumenAsientos();
    recalcularSubtotalPasajeros();
  }

  if (btnMasPasajeros && btnMenosPasajeros && cantidadPasajerosInput) {
    btnMasPasajeros.addEventListener('click', () => {
      actualizarCantidadPasajeros(cantidadPasajeros + 1);
    });

    btnMenosPasajeros.addEventListener('click', () => {
      actualizarCantidadPasajeros(cantidadPasajeros - 1);
    });
  }

  function actualizarResumenAsientos() {
    if (seleccionados.size === 0) {
      spanSeleccionado.textContent = 'Ninguno';
      spanSeleccionado.classList.remove('text-bg-success');
      spanSeleccionado.classList.add('text-bg-secondary');

      idAsientoInput.value = '';
      numeroAsientoInput.value = '';
      btnPagar.disabled = true;
      return;
    }

    const ids = Array.from(seleccionados);
    const codigos = ids.map(id => {
      const btn = document.querySelector('.asiento[data-id="' + id + '"]');
      return btn ? btn.dataset.codigo : '';
    }).filter(Boolean);

    spanSeleccionado.textContent = 'Asientos ' + codigos.join(', ');
    spanSeleccionado.classList.remove('text-bg-secondary');
    spanSeleccionado.classList.add('text-bg-success');

    // Enviamos al backend como CSV
    idAsientoInput.value = ids.join(',');
    numeroAsientoInput.value = codigos.join(',');

    // Solo habilitamos pagar si la cantidad de asientos = cantidad de pasajeros
    btnPagar.disabled = (seleccionados.size !== cantidadPasajeros);
  }

  document.querySelectorAll('.extra').forEach(x => x.addEventListener('change', recalcularExtras));

  // Selección de asientos (multi, hasta cantidadPasajeros)
  botones.forEach(btn => {
    btn.addEventListener('click', () => {
      if (btn.classList.contains('ocupado')) return;

      const id = btn.dataset.id;

      if (seleccionados.has(id)) {
        seleccionados.delete(id);
        btn.classList.remove('seleccionado');
      } else {
        if (seleccionados.size >= cantidadPasajeros) {
          alert('Ya seleccionaste los ' + cantidadPasajeros + ' asientos para tus pasajeros.');
          return;
        }
        seleccionados.add(id);
        btn.classList.add('seleccionado');
      }

      actualizarResumenAsientos();
    });
  });

  // Validación al enviar
  document.getElementById('formAsientoPago').addEventListener('submit', (e) => {
    if (seleccionados.size === 0) {
      e.preventDefault();
      alert('Por favor, selecciona al menos un asiento.');
      return;
    }
    if (seleccionados.size !== cantidadPasajeros) {
      e.preventDefault();
      alert('Debes seleccionar ' + cantidadPasajeros + ' asientos (uno por pasajero).');
      return;
    }
  });

  // Inicializar
  cantidadPasajerosInput.value = cantidadPasajeros;
  recalcularSubtotalPasajeros(); // esto también llama a recalcularExtras()
  btnPagar.disabled = true;
</script>
</body>
</html>
