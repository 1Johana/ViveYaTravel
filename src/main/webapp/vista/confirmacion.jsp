<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Confirmación de Pago</title>
  <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body { background:#f8f9fa; }
    .page-wrap { max-width: 960px; margin-inline:auto; padding: 24px; }
    .badge-seat { font-size: 1.1rem; }
    .summary-card .totals-row{ display:flex; justify-content:space-between; }
  </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="page-wrap">
  <div class="text-center mb-4">
    <c:choose>
      <c:when test="${ok}">
        <h2 class="text-success fw-bold">¡Pago confirmado con éxito!</h2>
        <p class="text-muted">Tu reserva ha sido registrada correctamente.</p>
      </c:when>
      <c:otherwise>
        <h2 class="text-danger fw-bold">No se pudo completar la reserva</h2>
        <p class="text-muted">El asiento ya fue ocupado. Intenta con otro por favor.</p>
      </c:otherwise>
    </c:choose>
  </div>

  <c:if test="${not empty mensaje}">
    <div class="alert ${ok ? 'alert-success' : 'alert-warning'} text-center">${mensaje}</div>
  </c:if>

  <div class="row g-3">
    <!-- Detalle -->
    <div class="col-lg-7">
      <div class="card shadow-sm h-100">
        <div class="card-header bg-dark text-white">Detalle de la reserva</div>
        <div class="card-body">
          <div class="mb-2">
            <strong>Paquete:</strong>
            <span class="ms-1">${empty nombrePaquete ? 'Promoción seleccionada' : nombrePaquete}</span>
          </div>

          <div class="mb-2">
            <strong>Asiento reservado:</strong>
            <c:choose>
              <c:when test="${not empty numeroAsiento}">
                <span class="badge text-bg-success badge-seat ms-1">Asiento ${numeroAsiento}</span>
              </c:when>
              <c:when test="${not empty sessionScope.numeroAsiento}">
                <span class="badge text-bg-success badge-seat ms-1">Asiento ${sessionScope.numeroAsiento}</span>
              </c:when>
              <c:otherwise>
                <span class="text-danger ms-1">No se detectó asiento.</span>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- Carrito (si aún está en sesión) -->
          <c:if test="${not empty sessionScope.carrito}">
            <hr/>
            <div class="fw-semibold mb-2">Items</div>
            <table class="table table-sm align-middle">
              <thead class="table-light">
                <tr>
                  <th>#</th>
                  <th>Paquete</th>
                  <th>Cant.</th>
                  <th class="text-end">Subtotal</th>
                </tr>
              </thead>
              <tbody>
                <c:set var="sumItems" value="0" scope="page"/>
                <c:forEach var="p" items="${sessionScope.carrito}" varStatus="s">
                  <tr>
                    <td>${s.index + 1}</td>
                    <td>${p.nombrePaquete}</td>
                    <td>${empty p.cantidad ? 1 : p.cantidad}</td>
                    <td class="text-end">
                      S/. <fmt:formatNumber value="${
                        empty p.subtotal
                          ? ( (empty p.precioPaquete ? 0 : p.precioPaquete) * (empty p.cantidad ? 1 : p.cantidad) )
                          : p.subtotal
                      }" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>
                  </tr>
                  <c:set var="sumItems" value="${sumItems + (empty p.subtotal ? ((empty p.precioPaquete ? 0 : p.precioPaquete) * (empty p.cantidad ? 1 : p.cantidad)) : p.subtotal)}" scope="page"/>
                </c:forEach>
              </tbody>
            </table>
          </c:if>
        </div>
      </div>
    </div>

    <!-- Resumen pago -->
    <div class="col-lg-5">
      <div class="card shadow-sm summary-card">
        <div class="card-header bg-primary text-white">Resumen del pago</div>
        <div class="card-body">
          <div class="totals-row">
            <span>Subtotal</span>
            <strong>S/. <fmt:formatNumber value="${empty subtotal ? 0 : subtotal}" minFractionDigits="2" maxFractionDigits="2"/></strong>
          </div>
          <div class="totals-row">
            <span>Extras</span>
            <strong>S/. <fmt:formatNumber value="${empty extras ? 0 : extras}" minFractionDigits="2" maxFractionDigits="2"/></strong>
          </div>

          <c:if test="${(empty seguro ? 0 : seguro) > 0 || (empty mascota ? 0 : mascota) > 0}">
            <div class="small text-muted mt-1">
              <c:if test="${(empty seguro ? 0 : seguro) > 0}">
                Seguro: S/. <fmt:formatNumber value="${seguro}" minFractionDigits="2" maxFractionDigits="2"/> &nbsp;
              </c:if>
              <c:if test="${(empty mascota ? 0 : mascota) > 0}">
                Mascota: S/. <fmt:formatNumber value="${mascota}" minFractionDigits="2" maxFractionDigits="2"/>
              </c:if>
            </div>
          </c:if>

          <hr/>
          <div class="totals-row fs-5">
            <span>Total pagado</span>
            <strong class="text-primary">
              S/. <fmt:formatNumber value="${empty total ? ( (empty subtotal ? 0 : subtotal) + (empty extras ? 0 : extras) ) : total}" minFractionDigits="2" maxFractionDigits="2"/>
            </strong>
          </div>

          <div class="alert alert-light border mt-3">
            <div class="small mb-1 text-muted">Resumen enviado a tu correo (si aplica).</div>
            <div class="small">¡Gracias por tu compra! 🎉</div>
          </div>

          <div class="d-grid gap-2 mt-2">
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/srvPromocion">Seguir comprando</a>
            <a class="btn btn-success" href="${pageContext.request.contextPath}/index.jsp">Volver al inicio</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
