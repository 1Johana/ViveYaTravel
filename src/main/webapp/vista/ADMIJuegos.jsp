<%-- 
    Document   : ADMIJuegos
    Created on : 18 nov. 2025, 10:12:48
    Author     : Lenovo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title> 🎮 Zona de Juegos</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
  body { background:#f4f6f8; }
  .game-btn { border-radius:10px; font-size:1.05rem; background:white; transition:.15s; }
  .game-btn:hover { transform:translateY(-2px); }
  #canvasWrap { display:flex; justify-content:center; }
  #gameCanvas { background:black; width:100%; max-width:700px; height:auto; border-radius:6px; box-shadow:0 6px 18px rgba(0,0,0,.2); }
  .top-bar { display:flex; justify-content:space-between; align-items:center; gap:10px; margin-bottom:14px; flex-wrap:wrap; }
  .score-box { background:#fff; padding:8px 12px; border-radius:8px; box-shadow:0 2px 6px rgba(0,0,0,.06); min-width:120px; text-align:center; }
  .hint { color:#666; font-size:0.95rem; }
  .pause-overlay {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%,-50%);
    color: #fff;
    background: rgba(0,0,0,0.6);
    padding: 18px 26px;
    border-radius: 10px;
    font-size: 20px;
    display: none;
    text-align: center;
  }
  .canvas-container { position: relative; display:inline-block; }
</style>
</head>
<body class="bg-light">

<div class="container mt-4">
  <div class="text-center mb-3">
    <h2 class="fw-bold"><i class="fa-solid fa-gamepad me-2"></i> Zona de Juegos</h2>
  </div>

  <div class="d-flex justify-content-center gap-3 flex-wrap mb-3">
    <button class="btn btn-light border shadow-sm px-4 py-3 game-btn" onclick="loadGame('snake')">
      <i class="fa-solid fa-rotate-left me-2 text-success"></i> Snake
    </button>
    <button class="btn btn-light border shadow-sm px-4 py-3 game-btn" onclick="loadGame('pong')">
      <i class="fa-solid fa-table-tennis-paddle-ball me-2 text-danger"></i> Ping Pong
    </button>
    <button class="btn btn-light border shadow-sm px-4 py-3 game-btn" onclick="loadGame('tetris')">
      <i class="fa-solid fa-gamepad me-2 text-primary"></i> Tetris
    </button>
  </div>

  <div class="top-bar">
    <div class="score-box"><strong>Juego:</strong> <span id="gameName">—</span></div>
    <div class="score-box"><strong>Puntaje:</strong> <span id="score">0</span></div>
    <div class="score-box"><strong>Récord:</strong> <span id="highScore">0</span></div>
    <div class="score-box"><strong>Nivel:</strong> <span id="level">0</span></div>
    <div class="score-box"><span id="hint" class="hint">Indicaciones: Selecciona un juego y haz clic en el canvas para empezar — Espacio = Pausa</span></div>
  </div>

  <div id="canvasWrap" class="d-flex justify-content-center">
    <div class="canvas-container">
      <!-- Important: width/height attributes control drawing buffer -->
      <canvas id="gameCanvas" width="700" height="450"></canvas>
      <div id="pauseOverlay" class="pause-overlay">PAUSA<br><small>Presiona ESPACIO para continuar</small></div>
    </div>
  </div>
</div>

<script>
/* ---------- GLOBALES ---------- */
const canvas = document.getElementById('gameCanvas');
const ctx = canvas.getContext('2d');
const scoreEl = document.getElementById('score');
const highEl = document.getElementById('highScore');
const levelEl = document.getElementById('level');
const gameNameEl = document.getElementById('gameName');
const hintEl = document.getElementById('hint');
const pauseOverlay = document.getElementById('pauseOverlay');

let currentGameKey = null;
let waitingToStart = false;
let startGameFunction = null;
let animId = null;
let paused = false;

/* Audio simple */
const AudioCtx = window.AudioContext || window.webkitAudioContext;
let audioCtx = null;
function beep(freq=440, time=0.06, type='sine', vol=0.05) {
  if (!audioCtx) audioCtx = new AudioCtx();
  const o = audioCtx.createOscillator();
  const g = audioCtx.createGain();
  o.type = type;
  o.frequency.value = freq;
  g.gain.value = vol;
  o.connect(g); g.connect(audioCtx.destination);
  o.start();
  o.stop(audioCtx.currentTime + time);
}

/* Helpers */
function clearCanvas(){ ctx.clearRect(0,0,canvas.width,canvas.height); }
function drawCentered(text, size=28, color='white'){ ctx.fillStyle=color; ctx.font=`${size}px Arial`; ctx.textAlign='center'; ctx.textBaseline='middle'; ctx.fillText(text, canvas.width/2, canvas.height/2); }

/* Stop / start */
function stopCurrentGame(){
  if (animId) cancelAnimationFrame(animId);
  animId = null;
  document.onkeydown = null;
  document.onmousemove = null;
  waitingToStart = false;
  startGameFunction = null;
  paused = false;
  pauseOverlay.style.display = 'none';
}

/* Load game and wait click */
function loadGame(key){
  stopCurrentGame();
  currentGameKey = key;
  gameNameEl.textContent = key.toUpperCase();
  scoreEl.textContent = '0';
  levelEl.textContent = '0';
  // Load highscore from localStorage
  let high = 0;
  if (key === 'snake') high = parseInt(localStorage.getItem('snake_high')||'0',10);
  if (key === 'pong') high = parseInt(localStorage.getItem('pong_high')||'0',10);
  if (key === 'tetris') high = parseInt(localStorage.getItem('tetris_high')||'0',10);
  highEl.textContent = high;
  hintEl.textContent = 'Haz clic en el canvas para iniciar — Espacio = Pausa';
  if (key === 'snake') startGameFunction = startSnake;
  if (key === 'pong') startGameFunction = startPong;
  if (key === 'tetris') startGameFunction = startTetris;
  waitingToStart = true;
  clearCanvas();
  drawCentered(`Haz clic para iniciar: ${key.toUpperCase()}`, 26);
  ctx.font = '14px Arial'; ctx.fillStyle = '#ccc'; ctx.fillText('(Presiona teclas del juego después de iniciar)', canvas.width/2, canvas.height/2 + 36);
}

/* Canvas click */
canvas.addEventListener('click', () => {
  if (waitingToStart && typeof startGameFunction === 'function') {
    waitingToStart = false;
    hintEl.textContent = 'Juego en curso — Espacio = Pausa';
    startGameFunction();
  }
});

/* Global pause toggle */
function togglePause() {
  if (!startGameFunction) return; // no hay juego iniciado

  paused = !paused;

  if (paused) {
    pauseOverlay.style.display = "block";

    // detener animación sin borrar estado
    if (animId) cancelAnimationFrame(animId);
    animId = null;

  } else {
    pauseOverlay.style.display = "none";

    // REANUDAR según el juego activo
    if (currentGameKey === "snake" && typeof resumeSnake === "function") {
      resumeSnake();
    }

    if (currentGameKey === "pong" && typeof resumePong === "function") {
      resumePong();
    }
    if (currentGameKey === "tetris" && typeof resumeTetris === "function") {
       resumeTetris(pausedDuration);
    }
  }
}

/* Space toggles pause */
document.addEventListener('keydown', (e) => {
  if (e.code === 'Space') {
    // prevent scrolling
    e.preventDefault();
    togglePause();
  }
});

/* ---------- SNAKE (mejorado con niveles + highscore) ---------- */
function startSnake() {
  beep(880,0.06);
  const tile = 20;
  const cols = Math.floor(canvas.width / tile);
  const rows = Math.floor(canvas.height / tile);

  let snake = [{x: Math.floor(cols/2), y: Math.floor(rows/2)}];
  let dir = {x:1,y:0};
  let food = spawnFood();
  let baseSpeed = 8; // ticks per second at level1
  let speed = baseSpeed;
  let tickInterval = 1000 / speed;
  let lastTick = 0;
  let points = 0;
  let level = 1;
  let high = parseInt(localStorage.getItem('snake_high')||'0',10);

  function spawnFood(){
    return { x: Math.floor(Math.random()*cols), y: Math.floor(Math.random()*rows) };
  }

  document.onkeydown = (e) => {
    if (e.code === 'Space') return; // handled globally
    if (e.key === 'ArrowUp' && dir.y !== 1) dir = {x:0,y:-1};
    if (e.key === 'ArrowDown' && dir.y !== -1) dir = {x:0,y:1};
    if (e.key === 'ArrowLeft' && dir.x !== 1) dir = {x:-1,y:0};
    if (e.key === 'ArrowRight' && dir.x !== -1) dir = {x:1,y:0};
  };

  function saveHigh() {
    if (points > high) {
      high = points;
      localStorage.setItem('snake_high', String(high));
      highEl.textContent = high;
    }
  }

  function gameOver() {
    if (animId) cancelAnimationFrame(animId);
    animId = null;
    saveHigh();
    beep(180,0.4,'sawtooth',0.08);
    const restart = confirm(`¡Perdiste! Puntaje: ${points}\nRécord: ${high}\n¿Quieres jugar de nuevo?`);
    if (restart) startSnake(); else loadGame('snake');
  }

  function update(ts) {
    if (paused) { animId = null; return; } // loop will be resumed via resumeSnake
    animId = requestAnimationFrame(update);
    if (!lastTick) lastTick = ts;
    if (ts - lastTick < tickInterval) return;
    lastTick = ts;

    // advance
    const head = { x: snake[0].x + dir.x, y: snake[0].y + dir.y };

    // collisions with walls
    if (head.x < 0 || head.x >= cols || head.y < 0 || head.y >= rows) { gameOver(); return; }
    // self collision
    if (snake.some(s => s.x === head.x && s.y === head.y)) { gameOver(); return; }

    snake.unshift(head);
    if (head.x === food.x && head.y === food.y) {
      points += 10;
      scoreEl.textContent = points;
      beep(1200,0.06);
      food = spawnFood();
      // update level every 50 points
      const newLevel = Math.floor(points / 50) + 1;
      if (newLevel !== level) {
        level = newLevel;
        levelEl.textContent = level;
        // increase speed moderately with level
        speed = baseSpeed + (level - 1) * 1.5;
        tickInterval = 1000 / speed;
        beep(1000,0.08);
      }
      saveHigh();
    } else {
      snake.pop();
    }

    // draw
    ctx.fillStyle = 'black';
    ctx.fillRect(0,0,canvas.width,canvas.height);
    ctx.fillStyle = 'lime';
    snake.forEach(s => ctx.fillRect(s.x*tile, s.y*tile, tile-1, tile-1));
    ctx.fillStyle = 'red';
    ctx.fillRect(food.x*tile, food.y*tile, tile-1, tile-1);
  }

  // initialize UI
  scoreEl.textContent = points;
  levelEl.textContent = level;
  highEl.textContent = high;

  paused = false;
  pauseOverlay.style.display = 'none';
  lastTick = 0;
  animId = requestAnimationFrame(update);

  // resume function (called when unpausing)
  window.resumeSnake = function(){
    lastTick = performance.now();
    animId = requestAnimationFrame(update);
  };
}

/* ---------- PONG (mejor IA, niveles y highscore) ---------- */
function startPong() {
  beep(660,0.06);
  // paddles and ball
  let paddle = { x: 20, y: canvas.height/2 - 40, w: 10, h: 80 };
  let ai = { x: canvas.width - 30, y: canvas.height/2 - 40, w: 10, h: 80, speed: 3 };
  let ball = { x: canvas.width/2, y: canvas.height/2, r: 8, vx: 5, vy: 3 };
  let points = 0;
  let level = 1;
  const baseAiSpeed = 3;
  const baseBallSpeed = 5;
  let high = parseInt(localStorage.getItem('pong_high')||'0',10);

  function saveHigh() {
    if (points > high) {
      high = points;
      localStorage.setItem('pong_high', String(high));
      highEl.textContent = high;
    }
  }

  document.onmousemove = (e) => {
    const rect = canvas.getBoundingClientRect();
    paddle.y = e.clientY - rect.top - paddle.h/2;
    if (paddle.y < 0) paddle.y = 0;
    if (paddle.y + paddle.h > canvas.height) paddle.y = canvas.height - paddle.h;
  };

  // better AI: predictive + smoothing, scaled by level
  function aiUpdate() {
    // Predict where ball will be when it reaches ai.x using current velocities (simple simulation)
    const predictionSteps = 300;
    let simX = ball.x, simY = ball.y, vx = ball.vx, vy = ball.vy;
    for (let i=0;i<predictionSteps;i++){
      simX += vx;
      simY += vy;
      if (simY - ball.r < 0 || simY + ball.r > canvas.height) vy *= -1;
      // stop when we pass AI x or go far right
      if (vx > 0 && simX >= ai.x) break;
      if (vx < 0 && simX <= ai.x) break;
    }
    // target center for AI
    let targetY = simY;
    // smoothing: move AI toward target with speed based on ai.speed and level
    const difficultyFactor = 1 + (level - 1) * 0.18; // increases difficulty
    const desiredSpeed = ai.speed * difficultyFactor;
    const aiCenter = ai.y + ai.h/2;
    const delta = targetY - aiCenter;
    // clamp movement for smoothness
    ai.y += Math.max(-desiredSpeed, Math.min(desiredSpeed, delta * 0.12));
    // keep inside bounds
    if (ai.y < 0) ai.y = 0;
    if (ai.y + ai.h > canvas.height) ai.y = canvas.height - ai.h;
  }

  function gameOver() {
    if (animId) cancelAnimationFrame(animId);
    animId = null;
    saveHigh();
    beep(200,0.4,'sawtooth',0.08);
    const restart = confirm(`¡Perdiste! Puntaje: ${points}\nRécord: ${high}\n¿Quieres jugar otra vez?`);
    if (restart) startPong(); else loadGame('pong');
  }

  function update() {
    if (paused) { animId = null; return; } // will resume via resumePong
    animId = requestAnimationFrame(update);

    // move ball
    ball.x += ball.vx;
    ball.y += ball.vy;

    // wall bounce
    if (ball.y - ball.r < 0 || ball.y + ball.r > canvas.height) {
      ball.vy *= -1;
    }

    // player paddle collision
    if (ball.x - ball.r < paddle.x + paddle.w &&
        ball.y > paddle.y && ball.y < paddle.y + paddle.h && ball.vx < 0) {
      ball.vx = -ball.vx * 1.04; // speed up a bit
      // alter vy based on hit position
      const hit = (ball.y - (paddle.y + paddle.h/2)) / (paddle.h/2);
      ball.vy += hit * 2;
      points += 1;
      scoreEl.textContent = points;
      beep(900,0.04);
      // level up each 8 points
      const newLevel = Math.floor(points / 8) + 1;
      if (newLevel !== level) {
        level = newLevel;
        levelEl.textContent = level;
        // increase ball speed gradually
        const signX = Math.sign(ball.vx) || 1;
        const signY = Math.sign(ball.vy) || 1;
        ball.vx = signX * (baseBallSpeed + (level-1)*0.9);
        ball.vy = signY * (Math.abs(ball.vy) + (level-1)*0.2);
        // increase ai speed
        ai.speed = baseAiSpeed + (level-1) * 0.7;
        beep(1000,0.08);
      }
      saveHigh();
    }

    // ai update and collision
    aiUpdate();
    if (ball.x + ball.r > ai.x &&
        ball.y > ai.y && ball.y < ai.y + ai.h && ball.vx > 0) {
      ball.vx = -ball.vx * 1.02;
      const hit = (ball.y - (ai.y + ai.h/2)) / (ai.h/2);
      ball.vy += hit * 1.6;
      beep(700,0.04);
    }

    // check lose: ball goes off left side
    if (ball.x < -50) { gameOver(); return; }

    // draw
    ctx.fillStyle = 'black';
    ctx.fillRect(0,0,canvas.width,canvas.height);
    // center line
    ctx.strokeStyle = '#444';
    ctx.setLineDash([8,8]);
    ctx.beginPath();
    ctx.moveTo(canvas.width/2, 0);
    ctx.lineTo(canvas.width/2, canvas.height);
    ctx.stroke();
    ctx.setLineDash([]);

    ctx.fillStyle = 'white';
    // ball
    ctx.beginPath();
    ctx.arc(ball.x, ball.y, ball.r, 0, Math.PI*2);
    ctx.fill();
    // paddles
    ctx.fillRect(paddle.x, paddle.y, paddle.w, paddle.h);
    ctx.fillRect(ai.x, ai.y, ai.w, ai.h);
  }

  // reset values & UI
  points = 0; level = 1; ai.speed = baseAiSpeed;
  ball.x = canvas.width/2; ball.y = canvas.height/2;
  ball.vx = baseBallSpeed * (Math.random()<0.5 ? 1 : -1);
  ball.vy = (Math.random()*2-1) * 3;
  scoreEl.textContent = points;
  levelEl.textContent = level;
  highEl.textContent = high;

  paused = false; pauseOverlay.style.display = 'none';
  animId = requestAnimationFrame(update);

  window.resumePong = function(){ animId = requestAnimationFrame(update); };
}
/* ------------------ TETRIS ------------------ */
function startTetris() {
  beep(520, 0.06);
  const COLS = 10;
  const ROWS = 20;
  const BLOCK = Math.floor(canvas.height / ROWS);
  const startX = Math.floor((canvas.width - COLS*BLOCK)/2);

  let grid = createGrid(ROWS, COLS);
  let current = randomPiece();
  let next = randomPiece();

  let dropCounter = 0;
  let dropInterval = 800;
  let lastTime = null;
  let points = 0;
  

  scoreEl.textContent = 0;

  /* --- CONTROLES --- */
  document.onkeydown = (e) => {
    if (paused) return; // Bloquear controles si está pausado

    if (e.key === 'ArrowLeft') { move(-1); }
    if (e.key === 'ArrowRight') { move(1); }
    if (e.key === 'ArrowDown') { drop(); }
    if (e.key === 'ArrowUp') { rotate(); beep(1000,0.03); }
    if (e.key === ' ') { hardDrop(); }
  };

  /* --- FUNCIONES BASE --- */
  function createGrid(r, c) {
    return Array.from({length:r},()=>Array(c).fill(0));
  }

  function collide(grid, piece, offY=0, offX=0) {
    for (let y=0;y<piece.shape.length;y++) {
      for (let x=0;x<piece.shape[y].length;x++) {
        if (!piece.shape[y][x]) continue;
        const newY = piece.y + y + offY;
        const newX = piece.x + x + offX;
        if (newY < 0 || newY >= grid.length || newX < 0 || newX >= COLS ||
            grid[newY][newX] !== 0) return true;
      }
    }
    return false;
  }

  function merge(grid, piece) {
    for (let y=0;y<piece.shape.length;y++)
      for (let x=0;x<piece.shape[y].length;x++)
        if (piece.shape[y][x])
          grid[piece.y+y][piece.x+x] = piece.color;
  }

  function move(dir) {
    current.x += dir;
    if (collide(grid, current)) current.x -= dir;
  }

  function rotateMatrix(m) {
    return m[0].map((_,i)=>m.map(r=>r[i]).reverse());
  }

  function rotate() {
    const old = current.shape;
    current.shape = rotateMatrix(current.shape);
    if (collide(grid, current)) current.shape = old;
  }

  function lineClear() {
    let lines = 0;
    for (let y=grid.length-1; y>=0; y--) {
      if (grid[y].every(v => v !== 0)) {
        grid.splice(y,1);
        grid.unshift(Array(COLS).fill(0));
        lines++;
        y++;
      }
    }
    if (lines>0) {
      points += lines * 100;
      scoreEl.textContent = points;
      beep(1200,0.06);
      dropInterval = Math.max(120, dropInterval - lines * 10);
    }
  }

  function randomPiece() {
    const pieces = {
      I: { shape:[[1,1,1,1]], color: 'cyan' },
      J: { shape:[[1,0,0],[1,1,1]], color: 'blue' },
      L: { shape:[[0,0,1],[1,1,1]], color: 'orange' },
      O: { shape:[[1,1],[1,1]], color: 'yellow' },
      S: { shape:[[0,1,1],[1,1,0]], color: 'green' },
      T: { shape:[[0,1,0],[1,1,1]], color: 'purple' },
      Z: { shape:[[1,1,0],[0,1,1]], color: 'red' }
    };
    const keys = Object.keys(pieces);
    const k = keys[Math.floor(Math.random()*keys.length)];
    const p = pieces[k];

    return {
      x: Math.floor(COLS/2)-1,
      y: 0,
      shape: p.shape.map(r=>r.slice()),
      color: p.color
    };
  }

  function drop() {
    current.y++;
    if (collide(grid, current)) {
      current.y--;
      merge(grid, current);
      current = next;
      next = randomPiece();
      lineClear();
      if (collide(grid,current)) {
        cancelAnimationFrame(animId);
        const restart = confirm(`¡Perdiste en Tetris! Puntaje: ${points}\n¿Jugar de nuevo?`);
        restart ? startTetris() : loadGame('tetris');
        return;
      }
    }
  }

  function hardDrop() {
    while(!collide(grid, current)) current.y++;
    current.y--;
    merge(grid, current);
    current = next;
    next = randomPiece();
    lineClear();
  }

  function draw() {
    ctx.fillStyle = 'black';
    ctx.fillRect(0,0,canvas.width, canvas.height);

    // grid
    for (let y=0;y<ROWS;y++) {
      for (let x=0;x<COLS;x++) {
        let v = grid[y][x];
        if (v) {
          ctx.fillStyle = v;
          ctx.fillRect(startX + x*BLOCK, y*BLOCK, BLOCK-1, BLOCK-1);
        } else {
          ctx.strokeStyle = '#111';
          ctx.strokeRect(startX + x*BLOCK, y*BLOCK, BLOCK, BLOCK);
        }
      }
    }

    // piece
    ctx.fillStyle = current.color;
    for (let y=0;y<current.shape.length;y++)
      for (let x=0;x<current.shape[y].length;x++)
        if (current.shape[y][x])
          ctx.fillRect(startX + (current.x+x)*BLOCK, (current.y+y)*BLOCK, BLOCK-1, BLOCK-1);
  }

  /* ------------------ LOOP ------------------ */
  function update(time = 0) {
    if (paused) { animId = null; return; }  // ⛔ detener loop en pausa

    animId = requestAnimationFrame(update);

    // initialize lastTime on first frame
    if (lastTime === null) {
      lastTime = time;
      return; // skip immediate drop on first frame to stabilize timing
    }

    const delta = time - lastTime;
    lastTime = time;
    dropCounter += delta;

    if (dropCounter > dropInterval) {
      drop();
      dropCounter = 0;
    }

    draw();
  }

  /* INICIAR TETRIS */
  paused = false;
  pauseOverlay.style.display = 'none';
  lastTime = null;
  dropCounter = 0;

  animId = requestAnimationFrame(update);

  /* ---------- REANUDAR DESDE PAUSA ---------- */
  // resumeTetris accepts pausedDuration (ms) and adds to lastTime so delta excludes pause time.
  window.resumeTetris = function(pausedDuration = 0) {
    // If lastTime is null (rare) set to current RAF timestamp on next frame.
    // If lastTime has a value (game was running) add pausedDuration to avoid a jump.
    if (lastTime === null) {
      // nothing to adjust, next RAF will initialize lastTime
    } else {
      lastTime += (pausedDuration || 0);
    }
    // resume RAF loop
    animId = requestAnimationFrame(update);
  };
}
/* ---------- Inicio: seleccionar Snake por defecto ---------- */
loadGame('snake');

</script>

<jsp:include page="ADMIVista.jsp"/>
</body>
</html>
