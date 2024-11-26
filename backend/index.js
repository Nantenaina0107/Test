const express = require('express');
const sequelize = require('./config/db');
const userRoutes = require('./routes/userRoute');
const declarationRoutes= require('./routes/declarationRoute');
const cartefiscaleRoutes = require('./routes/cartefiscaleRoute');
const paiementRoutes = require('./routes/paiementRoute');
const bodyParser = require('body-parser');
const cors = require('cors');
require('dotenv').config();
require('./models/association');


const app= express();
const port = process.env.port || 3200;

//Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended : true}));
app.use('/api/users',userRoutes);
app.use('/api', declarationRoutes);
app.use('/api',paiementRoutes);
app.use('/api',cartefiscaleRoutes);


sequelize.sync({force: false}).then(()=>{
    app.listen(port, ()=>{
       console.log(`Server running on port ${port}`);
    });
})