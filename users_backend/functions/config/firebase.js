const admin = require("firebase-admin");
const config = require("dotenv").config();

admin.initializeApp({
    credential: admin.credential.cert({
        projectId: process.env.PROJECT_ID.replace(/\\n/g, "\n"),
        privateKey: process.env.PRIVATE_KEY,
        clientEmail: process.env.CLIENT_EMAIL,
    }),
});

const db = admin.firestore();

module.exports = { admin, db };