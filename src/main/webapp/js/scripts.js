/* global bootstrap */

const Clickbutton = document.querySelectorAll('.button');
const tbody = document.querySelector('.tbody');
let carrito = [];
let total = 0;

// Event listeners para los botones de añadir al carrito
Clickbutton.forEach(btn => {
    btn.addEventListener('click', addToCarritoItem);
});

function addToCarritoItem(e) {
    const button = e.target;
    const item = button.closest('.card');
    const itemTitle = item.querySelector('.card-title').textContent;
    const itemPrice = item.querySelector('.precio').textContent;
    const itemImg = item.querySelector('.card-img-top').src;

    const newItem = {
        title: itemTitle,
        price: itemPrice,
        img: itemImg,
        cantidad: 1
    };

    addItemCarrito(newItem);
}

function addItemCarrito(newItem) {
    const alert = document.querySelector('.alert');

    setTimeout(() => {
        alert.classList.add('hide');
    }, 2000);
    alert.classList.remove('hide');

    const InputElemnto = tbody.getElementsByClassName('input__elemento');
    for (let i = 0; i < carrito.length; i++) {
        if (carrito[i].title.trim() === newItem.title.trim()) {
            carrito[i].cantidad++;
            const inputValue = InputElemnto[i];
            inputValue.value++;
            CarritoTotal();
            return null;
        }
    }

    carrito.push(newItem);
    renderCarrito();
}

function renderCarrito() {
    tbody.innerHTML = '';
    carrito.forEach((item, index) => {
        const tr = document.createElement('tr');
        tr.classList.add('ItemCarrito');
        const Content = `
            <th scope="row">${index + 1}</th>
            <td class="table__productos">
                <img src="${item.img}" alt="" width="50">
                <h6 class="title">${item.title}</h6>
            </td>
            <td class="table__price"><p>${item.price}</p></td>
            <td class="table__cantidad">
                <input type="number" min="1" value="${item.cantidad}" class="input__elemento">
                <button class="delete btn btn-danger">x</button>
            </td>
        `;
        tr.innerHTML = Content;
        tbody.append(tr);

        tr.querySelector('.delete').addEventListener('click', removeItemCarrito);
        tr.querySelector('.input__elemento').addEventListener('change', sumaCantidad);
    });
    CarritoTotal();
}

function CarritoTotal() {
    let Total = 0;
    const itemCartTotal = document.querySelector('.itemCartTotal');
    carrito.forEach((item) => {
        const precio = Number(item.price.replace("$", ''));
        Total += precio * item.cantidad;
    });

    itemCartTotal.innerHTML = `Total $${Total}`;
    addLocalStorage();
}

function removeItemCarrito(e) {
    const buttonDelete = e.target;
    const tr = buttonDelete.closest('.ItemCarrito');
    const title = tr.querySelector('.title').textContent;
    carrito = carrito.filter(item => item.title.trim() !== title.trim());

    const alert = document.querySelector('.remove');

    setTimeout(() => {
        alert.classList.add('remove');
    }, 2000);
    alert.classList.remove('remove');

    tr.remove();
    CarritoTotal();
}

function sumaCantidad(e) {
    const sumaInput = e.target;
    const tr = sumaInput.closest('.ItemCarrito');
    const title = tr.querySelector('.title').textContent;
    carrito.forEach(item => {
        if (item.title.trim() === title.trim()) {
            sumaInput.value < 1 ? (sumaInput.value = 1) : sumaInput.value;
            item.cantidad = sumaInput.value;
            CarritoTotal();
        }
    });
}

// Función para agregar productos al carrito y guardarlos en el localStorage
function addLocalStorage() {
    localStorage.setItem('carrito', JSON.stringify(carrito));
}



window.onload = function () {
    const storage = JSON.parse(localStorage.getItem('carrito'));
    if (storage) {
        carrito = storage;
        renderCarrito();
    }
};

// Función para mostrar alertas
// Elimina cualquier evento que redirija al usuario
document.getElementById('comprar-btn').removeEventListener('click');

// Actualiza el script para mostrar solo el mensaje de compra exitosa
document.getElementById('comprar-btn').addEventListener('click', function() {
    // Simular una compra exitosa mostrando un mensaje en el DOM
    const mensajeCompraExitosa = document.createElement('div');
    mensajeCompraExitosa.classList.add('mensaje-compra-exitosa');
    mensajeCompraExitosa.textContent = 'Compra exitosa';

    // Agregar el mensaje al body del documento
    document.body.appendChild(mensajeCompraExitosa);

    // Desaparecer el mensaje después de 3 segundos
    setTimeout(() => {
        mensajeCompraExitosa.remove();
    }, 3000); // Cambia el valor 3000 por el número de milisegundos que quieras que dure el mensaje
});

// Actualización del carrito al cargar la página
updateCart();

function updateCart() {
    const tbody = document.querySelector(".tbody");
    const carrito = JSON.parse(localStorage.getItem("carrito")) || [];
    tbody.innerHTML = "";

    let total = 0;
    carrito.forEach((item, index) => {
        const tr = document.createElement("tr");
        tr.innerHTML = `
            <th scope="row">${index + 1}</th>
            <td class="table__productos">
                <img src="${item.img}" alt="" width="50">
                <h6 class="title">${item.title}</h6>
            </td>
            <td class="table__price">${item.price}</td>
            <td class="table__cantidad">${item.cantidad}</td>
        `;
        tbody.appendChild(tr);
        total += item.cantidad * parseFloat(item.price.replace("$", ""));
    });

    document.querySelector(".itemCartTotal").innerText = `Total: $${total.toFixed(2)}`;
}




// JavaScript para manejar la apertura del modal y mostrar los detalles de la compra
document.addEventListener('DOMContentLoaded', function () {
    // Event listener para cargar los detalles al abrir el modal
    document.getElementById('ver-detalle-btn').addEventListener('click', function () {
        // Limpiar el cuerpo del modal antes de agregar nuevos detalles
        document.getElementById('detalle-compra-body').innerHTML = '';
        let total = 0;

        // Iterar sobre los elementos del carrito y agregarlos al modal
        carrito.forEach((item, index) => {
            const row = `
                <tr>
                    <th scope="row">${index + 1}</th>
                    <td>${item.title}</td>
                    <td>${item.price}</td>
                    <td>${item.cantidad}</td>
                </tr>
            `;
            total += item.price * item.cantidad; // Calcular el total
            document.getElementById('detalle-compra-body').innerHTML += row;
        });

        // Mostrar el total en el modal
        document.getElementById('modal-total').textContent = `Total: ${total}`;

        // Mostrar el modal
        const myModal = new bootstrap.Modal(document.getElementById('detalleCompraModal'));
        myModal.show();
    });

    // Event listener para el botón "Comprar" dentro del modal
    document.getElementById('comprar-modal-btn').addEventListener('click', function () {
        // Aquí puedes agregar la lógica para procesar la compra desde el modal
        alert('Compra realizada desde el modal');
        
        // Cerrar el modal después de la compra
        const myModal = new bootstrap.Modal(document.getElementById('detalleCompraModal'));
        myModal.hide();
    });
});
