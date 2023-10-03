const { setGlobalOptions } = require("firebase-functions/v2");
const {onRequest} = require("firebase-functions/v2/https");
const express = require("express");

const loginRouter = require("./routes/login");
const registerRouter = require("./routes/register");

// Set the maximum instances to 10 for all functions
setGlobalOptions({maxInstances: 10});

const app = express();

// For parsing application/json
app.use(express.json());

// Middleware to check whether user is login or not

app.use("/login", loginRouter);

app.use("/register", registerRouter);

exports.app = onRequest(app);
