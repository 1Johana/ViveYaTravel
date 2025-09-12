<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Factura</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
        <style>
            body {
                background: #1d2630;
                color: #fff;
            }

            @media print {
                body {
                    background: #fff;
                    color: #000;
                }

                .container {
                    width: 100%;
                    padding: 0;
                    margin: 0;
                    margin-top: 50px;
                }

                .form-group, .row hr, #printButton, #crudTable th:last-child, #crudTable td:last-child, .btn , #printButton{
                    display: none;
                }

                #logo, #companyInfo, #invoiceInfo, #clientInfo {
                    text-align: center;
                    margin-bottom: 30px;
                }

                #crudTable {
                    border: 1px solid #000;
                }

                #crudTable th, #crudTable td {
                    border: 1px solid #000;
                    padding: 10px;
                    text-align: left;
                }
                #additionalInfo {
                    margin-top: 30px;
                }
            }

            #logo {
                text-align: center;
                margin: 20px 0;
            }

            #companyInfo, #invoiceInfo, #clientInfo {
                text-align: center;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <div class="container">

            <div id="companyInfo" style="text-align: center">
                <div style="position: absolute; top: 20px; right: 20px; border: 1px solid #000; padding: 10px;">
        Nº de Factura: 00123 
    </div>
                <img src="${pageContext.request.contextPath}/img/logovyt.png" alt="Logo de Vive Ya Travel" style="margin-bottom: 20px;">
                <h2 style="margin-bottom: 10px;">Vive Ya Travel</h2>
                <div id="invoiceInfo" class="text-center mb-3">
                    <p>Fecha: <span id="fecha"></span></p>
                    <p>Hora: <span id="hora"></span></p>
                </div>
                <div class="text-center mb-3" >
                    <div class="d-inline-block" style="text-align: left">
                        <p>Dirección: Calle Falsa 123, Ciudad, País</p>
                        <p>Teléfono: +123 456 7890</p>
                        <p>Email: contacto@viveyatravel.com</p>
                        <p>RUC: 12345678</p>
                        <p>Pagina: www.viveyatravel.com</p>
                        <p>IGV: 18%</p>
                        <p>Descuento: 25%</p>
                        <p>Perú - Lima</p>
                    </div>
                </div>           
            </div>
                
            <h2 class="mt-5 mb-5">Factura de agencia de viajes</h2>
            <div class="mb-5">
                <div class="row">
                    <div class="form-group col-md-6 mb-3">
                        <label for="name">Nombre</label>
                        <input type="text" name="name" class="form-control" id="name" placeholder="Ingrese Nombre"/>
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="ape">Apellido</label>
                        <input type="text" name="ape" class="form-control" id="ape" placeholder="Ingrese Apellido"/>
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="dir">Dirección</label>
                        <input type="text" name="dir" class="form-control" id="dir" placeholder="Ingrese Dirección"/>
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="email">Email</label>
                        <input type="text" name="email" class="form-control" id="email" placeholder="Ingrese Email"/>
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="ruc">RUC</label>
                        <input type="text" name="ruc" class="form-control" id="ruc" placeholder="Ingrese RUC"/>
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="can">Cantidad</label>
                        <input type="number" name="can" class="form-control" id="can" placeholder="Ingrese Cantidad"/>
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="total">Total</label>
                        <input type="number" name="total" class="form-control" id="total" placeholder="Ingrese Total"/>
                    </div>
                    <div class="col-lg-12 mt-5">
                        <button class="btn btn-success" id="Submit" onclick="AddData()">
                            Agregar Datos
                        </button>
                        <button class="btn btn-primary" id="Update">
                            Actualizar
                        </button>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row mt-5">
                <div class="col-12">
                    <table class="table table-bordered" id="crudTable">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Dirección</th>
                                <th>Email</th>
                                <th>RUC</th>
                                <th>Cantidad</th>
                                <th>Precio Bruto</th>
                                <th>IGV (18%)</th>
                                <th>Total</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>

            <button class="btn btn-secondary mt-3" id="printButton" onclick="window.print()">Imprimir Factura</button>
        </div>


        <script>
            function validateForm() {
                var name = document.getElementById("name").value;
                var ape = document.getElementById("ape").value;
                var dir = document.getElementById("dir").value;
                var email = document.getElementById("email").value;
                var ruc = document.getElementById("ruc").value;
                var can = document.getElementById("can").value;
                var total = document.getElementById("total").value;

                if (name === "" || ape === "" || dir === "" || email === "" || ruc === "" || can === "" || total === "") {
                    alert("Todos los campos son obligatorios");
                    return false;
                }
                if (!email.includes("@")) {
                    alert("Correo inválido");
                    return false;
                }
                if (isNaN(can) || can <= 0) {
                    alert("La cantidad debe ser un número positivo");
                    return false;
                }
                if (isNaN(total) || total <= 0) {
                    alert("El total debe ser un número positivo");
                    return false;
                }

                validarYCalcularDescuento(can, total);
                return true;
            }

            function validarYCalcularDescuento(can, total) {
                if (can >= 10) {
                    var descuento = total * 0.25;
                    var nuevoTotal = total - descuento;
                    alert("Se ha aplicado un descuento del 25%. El nuevo total es: " + nuevoTotal.toFixed(2));
                    document.getElementById("total").value = nuevoTotal.toFixed(2);
                }
            }

            function showData() {
                var peopleList;
                if (localStorage.getItem("peopleList") == null) {
                    peopleList = [];
                } else {
                    peopleList = JSON.parse(localStorage.getItem("peopleList"));
                }

                var html = "";
                peopleList.forEach(function (element, index) {
                    var subtotal = element.total;
                    var igv = subtotal * 0.18;
                    var total = subtotal + igv;

                    html += "<tr>";
                    html += "<td>" + element.name + "</td>";
                    html += "<td>" + element.ape + "</td>";
                    html += "<td>" + element.dir + "</td>";
                    html += "<td>" + element.email + "</td>";
                    html += "<td>" + element.ruc + "</td>";
                    html += "<td>" + element.can + "</td>";
                    html += "<td>" + subtotal.toFixed(2) + "</td>";
                    html += "<td>" + igv.toFixed(2) + "</td>";
                    html += "<td>" + total.toFixed(2) + "</td>";
                    html +=
                            '<td><button onclick="deleteData(' + index + ')" class="btn btn-danger">Eliminar</button><button onclick="updateData(' + index + ')" class="btn btn-warning m-2">Editar</button></td>';
                    html += "</tr>";
                });

                document.querySelector("#crudTable tbody").innerHTML = html;

                mostrarFechaYHora();
            }

            document.onload = showData();

            function AddData() {
                if (validateForm() === true) {
                    var name = document.getElementById("name").value;
                    var ape = document.getElementById("ape").value;
                    var dir = document.getElementById("dir").value;
                    var email = document.getElementById("email").value;
                    var ruc = document.getElementById("ruc").value;
                    var can = document.getElementById("can").value;
                    var total = parseFloat(document.getElementById("total").value);
                    var subtotal = total;
                    var igv = subtotal * 0.18;
                    var total = subtotal + igv;

                    var peopleList;
                    if (localStorage.getItem("peopleList") == null) {
                        peopleList = [];
                    } else {
                        peopleList = JSON.parse(localStorage.getItem("peopleList"));
                    }

                    peopleList.push({
                        name: name,
                        ape: ape,
                        dir: dir,
                        email: email,
                        ruc: ruc,
                        can: can,
                        total: total,
                    });

                    localStorage.setItem("peopleList", JSON.stringify(peopleList));
                    showData();

                    document.getElementById("name").value = "";
                    document.getElementById("ape").value = "";
                    document.getElementById("dir").value = "";
                    document.getElementById("email").value = "";
                    document.getElementById("ruc").value = "";
                    document.getElementById("can").value = "";
                    document.getElementById("total").value = "";
                }
            }

            function deleteData(index) {
                var peopleList;
                if (localStorage.getItem("peopleList") == null) {
                    peopleList = [];
                } else {
                    peopleList = JSON.parse(localStorage.getItem("peopleList"));
                }

                peopleList.splice(index, 1);
                localStorage.setItem("peopleList", JSON.stringify(peopleList));
                showData();
            }

            function updateData(index) {
                var peopleList;
                if (localStorage.getItem("peopleList") == null) {
                    peopleList = [];
                } else {
                    peopleList = JSON.parse(localStorage.getItem("peopleList"));
                }

                document.getElementById("name").value = peopleList[index].name;
                document.getElementById("ape").value = peopleList[index].ape;
                document.getElementById("dir").value = peopleList[index].dir;
                document.getElementById("email").value = peopleList[index].email;
                document.getElementById("ruc").value = peopleList[index].ruc;
                document.getElementById("can").value = peopleList[index].can;
                document.getElementById("total").value = peopleList[index].total;

                document.getElementById("Submit").style.display = "none";
                document.getElementById("Update").style.display = "block";

                document.getElementById("Update").onclick = function () {
                    if (validateForm() === true) {
                        var subtotal = parseFloat(document.getElementById("total").value);
                        var igv = subtotal * 0.18;
                        var total = subtotal + igv;

                        peopleList[index].name = document.getElementById("name").value;
                        peopleList[index].ape = document.getElementById("ape").value;
                        peopleList[index].dir = document.getElementById("dir").value;
                        peopleList[index].email = document.getElementById("email").value;
                        peopleList[index].ruc = document.getElementById("ruc").value;
                        peopleList[index].can = document.getElementById("can").value;
                        peopleList[index].total = total;

                        localStorage.setItem("peopleList", JSON.stringify(peopleList));
                        showData();

                        document.getElementById("name").value = "";
                        document.getElementById("ape").value = "";
                        document.getElementById("dir").value = "";
                        document.getElementById("email").value = "";
                        document.getElementById("ruc").value = "";
                        document.getElementById("can").value = "";
                        document.getElementById("total").value = "";

                        document.getElementById("Submit").style.display = "block";
                        document.getElementById("Update").style.display = "none";
                    }
                }
            }

            function mostrarFechaYHora() {
                var fechaActual = new Date();
                var fecha = fechaActual.toLocaleDateString();
                var hora = fechaActual.toLocaleTimeString();
                document.getElementById("fecha").textContent = fecha;
                document.getElementById("hora").textContent = hora;
            }
        </script>

    </body>
</html>
