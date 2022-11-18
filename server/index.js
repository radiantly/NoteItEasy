var { mongoose } = require('./db.js');
const express = require('express');
const bodyParser = require('body-parser');


var billController = require('./controllers/billController.js');

var app = express();
app.use(bodyParser.json());

app.listen(3000, () => console.log('Server started at port : 3000'));


app.use('/bills', billController);