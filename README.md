# API de Personajes de Harry Potter

Bienvenido a la API de Personajes de Harry Potter. Esta API proporciona información sobre personajes, casas y usuarios del mundo mágico de Harry Potter.
## Requisitos Previos
- [Node.js](https://nodejs.org/)
- [MySQL](https://www.mysql.com/)

## Configuración del Proyecto
1. Clona este repositorio: `git clone <(https://github.com/Adalab/modulo-4-evaluacion-final-MayteGonz.git)>`
2. Instala las dependencias: `npm install`
3. Configura las variables de entorno en un archivo `.env`, tienes en bd el archivo para crearte tu base de datos.
4. Instala las demás dependecias con: `npm i`
5. Ejecuta el servidor: `npm run dev`

¡Listo! La API debería estar funcionando en [http://localhost:4001](http://localhost:4001).




## Endpoints Disponibles

### Obtener todos los personajes
GET `/personajes`

### Obtener todas las casas
GET `/casas`

### Obtener relación entre personajes y casas

GET `/`

### Añadir un nuevo personaje

POST `/personajes`

Permite añadir un nuevo personaje a la base de datos. Se deben proporcionar los datos del personaje en el cuerpo de la solicitud.

### Modificar un personaje existente
PUT `/personajes/:idPj`

Permite modificar la información de un personaje existente. Se debe proporcionar el ID del personaje en la URL y los datos actualizados en el cuerpo de la solicitud

### Borrar un personaje

DELETE `/personajes/:idPj`

Permite borrar un personaje existente. Se debe proporcionar el ID del personaje en la URL.

### Registro de usuario

POST `/registro`

Permite registrar un nuevo usuario en la plataforma. Se deben proporcionar el correo electrónico, nombre de usuario y contraseña en el cuerpo de la solicitud.

### Inicio de sesión de usuario

POST `/login`

Permite que un usuario registrado inicie sesión. Se deben proporcionar el correo electrónico y la contraseña en el cuerpo de la solicitud.
