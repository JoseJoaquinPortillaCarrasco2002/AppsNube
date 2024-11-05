//importar funciones de recursos
import 'dotenv/config';
import express from 'express';
import routesRecuperador from './routes/platos.js';
import bodyParser from 'body-parser';
//recuperar funcionalidades de express
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}))

//usar las rutas y controllers
app.use('/platos', routesRecuperador);

try {

    //hacer el levantamiento del servidor en puerto 3000
    app.listen(3000, ()=>console.log ('servidor levantado') )
} catch (e) {
    console.log(e);
}
