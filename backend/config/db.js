require('dotenv').config();
const {Sequelize}= require('sequelize');


const sequelize = new Sequelize(
    process.env.DbName,
    process.env.Name,
    process.env.DbPassword,
    {
        host: process.env.HostName,
        port: process.env.DbPort,
        dialect: process.env.DbDialect,
});
sequelize.authenticate()
    .then(()=>console.log('Database connected')
    )
    .catch(err=>console.log('Error :'+err)
    );

module.exports = sequelize;