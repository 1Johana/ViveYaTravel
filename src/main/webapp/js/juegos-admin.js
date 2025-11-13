/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
// === SECCIÓN DE JUEGOS ===
// === SECCIÓN DE JUEGOS ===
// === SECCIÓN DE JUEGOS ===
document.addEventListener("DOMContentLoaded", () => {
    const btnJuegos = document.getElementById('btnJuegos');
    const panelPrincipal = document.getElementById('panelPrincipal');
    const zonaJuegos = document.getElementById('zonaJuegos');

    if (!btnJuegos || !zonaJuegos || !panelPrincipal) return;

    btnJuegos.addEventListener('click', () => {
        // Oculta el panel principal y muestra la zona de juegos
        panelPrincipal.style.display = 'none';
        zonaJuegos.style.display = 'block';
        zonaJuegos.classList.add('juego-activo');

        zonaJuegos.innerHTML = `
            <h2 class="text-center">🎮 Juegos del Administrador</h2>
            <div id="gameMenu" class="text-center">
                <button class="btn btn-primary" onclick="initClicker()">Juego de Clicks</button>
                <button class="btn btn-success" onclick="initSnake()">Snake</button>
                <button class="btn btn-danger" onclick="initPong()">Pong</button>
            </div>
            <canvas id="gameCanvas" width="400" height="400"></canvas>
            <p class="text-center mt-3">
                <button class="btn btn-secondary" onclick="clearGame()">Salir del juego</button>
            </p>
        `;
    });
});

// === Variables globales ===
let currentGameInterval = null;
let currentKeyListeners = [];

// === Limpieza general antes de iniciar otro juego ===
function resetGameEnvironment() {
    if (currentGameInterval) {
        clearInterval(currentGameInterval);
        currentGameInterval = null;
    }

    // Eliminar todos los eventos previos
    currentKeyListeners.forEach(listener => {
        document.removeEventListener(listener.type, listener.fn);
    });
    currentKeyListeners = [];

    // Limpiar el canvas
    const canvas = document.getElementById('gameCanvas');
    if (canvas) {
        const ctx = canvas.getContext('2d');
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    }
}

// === JUEGO 1: Clicker ===
function initClicker() {
    resetGameEnvironment();

    const canvas = document.getElementById('gameCanvas');
    const ctx = canvas.getContext('2d');
    let score = 0;

    canvas.onclick = () => {
        score++;
        draw();
    };

    function draw() {
        ctx.fillStyle = "#000";
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        ctx.fillStyle = "#fff";
        ctx.font = "30px Arial";
        ctx.fillText("Puntos: " + score, 120, 200);
    }

    draw();
}

// === JUEGO 2: Snake ===
function initSnake() {
    resetGameEnvironment();

    const canvas = document.getElementById('gameCanvas');
    const ctx = canvas.getContext('2d');
    const box = 20;
    let snake = [{x: 9 * box, y: 10 * box}];
    let food = {x: Math.floor(Math.random() * 19) * box, y: Math.floor(Math.random() * 19) * box};
    let dir = null;

    function direction(event) {
        if(event.keyCode == 37 && dir != "RIGHT") dir = "LEFT";
        else if(event.keyCode == 38 && dir != "DOWN") dir = "UP";
        else if(event.keyCode == 39 && dir != "LEFT") dir = "RIGHT";
        else if(event.keyCode == 40 && dir != "UP") dir = "DOWN";
    }

    document.addEventListener("keydown", direction);
    currentKeyListeners.push({ type: "keydown", fn: direction });

    function collision(head, array){
        return array.some(segment => head.x === segment.x && head.y === segment.y);
    }

    function draw() {
        ctx.fillStyle = "black";
        ctx.fillRect(0, 0, 400, 400);

        for(let i = 0; i < snake.length; i++){
            ctx.fillStyle = (i == 0)? "lime" : "white";
            ctx.fillRect(snake[i].x, snake[i].y, box, box);
        }

        ctx.fillStyle = "red";
        ctx.fillRect(food.x, food.y, box, box);

        let snakeX = snake[0].x;
        let snakeY = snake[0].y;

        if(dir === "LEFT") snakeX -= box;
        if(dir === "UP") snakeY -= box;
        if(dir === "RIGHT") snakeX += box;
        if(dir === "DOWN") snakeY += box;

        if(snakeX == food.x && snakeY == food.y){
            food = {x: Math.floor(Math.random() * 19) * box, y: Math.floor(Math.random() * 19) * box};
        } else {
            snake.pop();
        }

        const newHead = {x: snakeX, y: snakeY};

        if (dir && (snakeX < 0 || snakeY < 0 || snakeX >= 400 || snakeY >= 400 || collision(newHead, snake))) {
            clearInterval(currentGameInterval);
            if (confirm("💀 Perdiste\n¿Deseas jugar de nuevo?")) {
                initSnake();
            }
            return;
        }

        snake.unshift(newHead);
    }

    currentGameInterval = setInterval(draw, 100);
}

// === JUEGO 3: Pong ===
function initPong() {
    resetGameEnvironment();

    const canvas = document.getElementById('gameCanvas');
    const ctx = canvas.getContext('2d');
    let ball = {x: 200, y: 200, dx: 2, dy: 2, r: 10};
    let paddle = {x: 150, y: 380, w: 100, h: 10};
    let rightPressed = false, leftPressed = false;

    function keyDown(e){ 
        if(e.key === "ArrowRight") rightPressed = true; 
        else if(e.key === "ArrowLeft") leftPressed = true; 
    }
    function keyUp(e){ 
        if(e.key === "ArrowRight") rightPressed = false; 
        else if(e.key === "ArrowLeft") leftPressed = false; 
    }

    document.addEventListener("keydown", keyDown);
    document.addEventListener("keyup", keyUp);
    currentKeyListeners.push({ type: "keydown", fn: keyDown });
    currentKeyListeners.push({ type: "keyup", fn: keyUp });

    function draw() {
        ctx.clearRect(0, 0, 400, 400);
        ctx.fillStyle = "#000";
        ctx.fillRect(0, 0, 400, 400);

        // Bola
        ctx.beginPath();
        ctx.arc(ball.x, ball.y, ball.r, 0, Math.PI * 2);
        ctx.fillStyle = "#fff";
        ctx.fill();

        // Paleta
        ctx.fillRect(paddle.x, paddle.y, paddle.w, paddle.h);
        ctx.closePath();

        // Rebotes
        if (ball.x + ball.dx > 400 - ball.r || ball.x + ball.dx < ball.r) ball.dx = -ball.dx;

        if (ball.y + ball.dy < ball.r) ball.dy = -ball.dy;
        else if (ball.y + ball.dy > 400 - ball.r) {
            if (ball.x > paddle.x && ball.x < paddle.x + paddle.w) {
                ball.dy = -ball.dy;
            } else {
                clearInterval(currentGameInterval);
                if (confirm("🏓 Perdiste\n¿Deseas jugar de nuevo?")) {
                    initPong();
                }
                return;
            }
        }

        ball.x += ball.dx;
        ball.y += ball.dy;

        if(rightPressed && paddle.x < 400 - paddle.w) paddle.x += 5;
        else if(leftPressed && paddle.x > 0) paddle.x -= 5;
    }

    currentGameInterval = setInterval(draw, 10);
}

// === Salir del juego ===
function clearGame(){
    resetGameEnvironment();
    const panelPrincipal = document.getElementById('panelPrincipal');
    const zonaJuegos = document.getElementById('zonaJuegos');
    zonaJuegos.style.display = 'none';
    panelPrincipal.style.display = 'block';
    zonaJuegos.innerHTML = '';
}
