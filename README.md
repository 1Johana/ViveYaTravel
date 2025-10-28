1. **==========🌳TRABAJAR POR RAMAS(Git Bash)===============**
```
1️⃣Para vesualizar las ramas existentes 
   git branch -a  

2️⃣Para seleccionar la rama en la que quieres trabajar 
   git checkout nombre-rama

3️⃣Descarga cambios de un repositorio remoto (Pull)
   git pull origin nombre-rama

4️⃣Comentar cambios realizados (COMMIT)
   git commit -m "comentario"

5️⃣Subir tus cambios locales (Push)
   git push -u origin nombre-rama
```

2. **==========📘 Guía: Traer main a la rama ===============**
```
# 1. Estás en tu rama de trabajo
git checkout r_NombreRama

# 2. Descarga los cambios más recientes del remoto
git fetch origin

# 3. Combina los últimos cambios del main en tu rama
git merge origin/main

# 4. Si hay conflictos, resuélvelos:
#    (a) Abre los archivos en conflicto y elige qué conservar
#    (b) Luego:
git add .
git commit

# 5. Finalmente, sube tu rama actualizada
git push origin r_NombreRama
```

3. **==========📘 Guía: Traer cambios de la rama al main ===============**
```
# 1. Ve a tu rama principal
git checkout main

# 2. Asegúrate de tener todo actualizado
git fetch origin

# 3. Actualiza tu rama main con lo más reciente del remoto
git pull origin main

# 4. Trae los cambios de la rama r_nombrerama
git merge origin/r_NombreRama

# 5. Si hay conflictos, resuélvelos, luego:
git add .
git commit
```
