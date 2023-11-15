const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
require('dotenv').config();

// create and config server
const server = express();
server.use(cors());
server.use(express.json());

//Instalar y configurar el JWT y bcrypt
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

// init express aplication
const serverPort = 4001;
server.listen(serverPort, () => {
  console.log(`Server listening at http://localhost:${serverPort}`);
});

// conexion con la BD
async function getConnection() {
  const connection = await mysql.createConnection({
    host: process.env.HOST,
    user: process.env.DBUSER,
    password: process.env.PASS,
    database: process.env.DATABASE,
  });
  await connection.connect();
  console.log(
    `Conexión establecida con la base de datos (identificador=${connection.threadId})`
  );

  return connection;
}

//generar un token
const generateToken = (payload) => {
  const token = jwt.sign(payload, 'secreto', { expiresIn: '12h' });
  return token;
};

// creamos  nuestros endpoints
//get, post, put, delete

//endpoint de todos los personajes
server.get('/personajes', async (req, res) => {
  const connection = await getConnection();
  const query = 'SELECT * FROM personajes';
  const [results, fields] = await connection.query(query);
  connection.end();
  res.json(results);
});
//endpoint de todas las casas
server.get('/casas', async (req, res) => {
  const connection = await getConnection();
  const query = 'SELECT * FROM casas';
  const [results, fields] = await connection.query(query);
  connection.end();
  res.json(results);
});
//endpoint de la relación de personajes con casas, donde se muestra solo el nombre y la casa a la que pertenece.
server.get('/', async (req, res) => {
  const connection = await getConnection();
  const query =
    'SELECT personajes.nombrePj as nombre, personajes.apellido,casas.nombreCasa as casa FROM casas INNER JOIN personajes ON idCasa = fkCasa';
  const [results, fields] = await connection.query(query);
  connection.end();
  res.json(results);
});

//endpoint para añadir un nuevo personaje
server.post('/personajes', async (req, res) => {
  try {
    const connection = await getConnection();
    const query =
      'INSERT INTO personajes (nombrePj, apellido, cumpleaños,ocupacion,boggart,fkCasa) VALUES (?,?,?,?,?,?);';

    const [results] = await connection.query(query, [
      req.body.nombrePj,
      req.body.apellido,
      req.body.cumpleaños,
      req.body.ocupacion,
      req.body.boggart,
      req.body.fkCasa,
    ]);
    console.log(results);
    console.log(results.insertId);
    connection.end();
    res.json({
      success: true,
      id: results.insertId,
    });
  } catch (error) {
    res.json({
      success: false,
      message:
        'Compruba que no te has dejado por rellenar ningún campo de tu maga favorita o inténtalo de nuevo más tarde',
    });
  }
});

//modificar un personaje
server.put('/personajes/:idPj', async (req, res) => {
  try {
    const connection = await getConnection();
    const personajeID = req.params.idPj;
    console.log(req.params);
    const query =
      'UPDATE personajes SET nombrePj = ?, apellido = ?, cumpleaños = ?, ocupacion = ?, boggart = ?, fkCasa = ?  WHERE idPersonaje= ?;';
    const [results] = await connection.query(query, [
      req.body.nombrePj,
      req.body.apellido,
      req.body.cumpleaños,
      req.body.ocupacion,
      req.body.boggart,
      req.body.fkCasa,
      personajeID,
    ]);
    connection.end();
    res.json({
      success: true,
      message: 'Se ha podido modificar directamente la información de tu bruja',
    });
  } catch (error) {
    res.json({
      success: false,
      message:
        'Compruba que estás cambiando todos los campos del la maga que quieras editar o inténtalo de nuevo más tarde',
    });
  }
});

//Borrar un personaje
server.delete('/personajes/:idPj', async (req, res) => {
  try {
    const connection = await getConnection();
    const personajeID = req.params.idPj;

    const query = 'DELETE FROM personajes WHERE idPersonaje = ?';
    const [results] = await connection.query(query, [personajeID]);
    connection.end();
    console.log(results);
    res.json({
      success: true,
      menssage: 'Se ha podido borrar correctamente a la bruja elejida.',
    });
  } catch (error) {
    res.json({
      success: false,
      message:
        'No hemos podido borrar a tu maga, perdón. Inténtalo de nuevo más tarde',
    });
  }
});

//registro de usuario
server.post('/registro', async (req, res) => {
  try {
    const connection = await getConnection();
    const query =
      'INSERT INTO usuarios (email, nombreUser, password) VALUES (?,?,?)';
    const password = req.body.password;
    const passwordHashed = await bcrypt.hash(password, 10);
    const [results] = await connection.query(query, [
      req.body.email,
      req.body.nombre,
      passwordHashed,
    ]);
    idNewUser = results.insertId;
    const infoToken = {
      username: req.body.nombre,
      id: idNewUser,
    };
    const token = generateToken(infoToken);

    connection.end();
    res.json({
      success: true,
      token: token,
    });
  } catch (error) {
    res.json({
      success: false,
      error: error,
    });
  }
});

//login usuario
server.post('/login', async (req, res) => {
  const email = req.body.email;
  const passwordUser = req.body.password;

  //Ver si el usuario existe : en bd
  const sql = 'SELECT * FROM usuarios WHERE email = ?';

  const conn = await getConnection();

  const [users] = await conn.query(sql, [email]);
  const user = users[0]; // solo me quedo con el primer usuario
  console.log(user);
  const passwordHashed = await bcrypt.hash(passwordUser, 10);

  //Comprobar si el usuario y la contraseña coincide con la que está en BD: bcrypt
  const isOkPass = await bcrypt.compare(
    passwordUser,
    user.password,
    function (error, res) {
      if (error) {
        console.log(error);
      }
      if (res) {
        console.log(res);
      }
    }
  );

  //Si el usuario no existe o la contraseña es incorrecta -> credenciales no válidas
  if (!(isOkPass && user)) {
    return res.json({ success: false, error: 'Credenciales inválidas' });
  }

  //si el usaurio existe y la contraseña coincide: generar un token
  const infoToken = {
    username: user.email,
    id: user.idUser,
  };

  const token = generateToken(infoToken);

  res.json({ success: true, token, email: user.email });

  //envio una respuesta correcta
});
