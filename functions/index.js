const functions = require("firebase-functions");
const { DISCORD_WEBHOOOK_URL } = require("./config.json");
const axios = require("axios");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.generateTranscript = functions.storage
  .object()
  .onFinalize(async (object) => {
    const objectPath = object.name.replace(/ /g, "%20").replace(/\//g, "%2F");

    const downloadURL = `https://firebasestorage.googleapis.com/v0/b/${object.bucket}/o/${objectPath}?alt=media`;

    await axios.post(DISCORD_WEBHOOOK_URL, {
      content: `${object.name} has been uploaded in ${object.bucket}. Public download url is at ${downloadURL}`,
    });
  });
