const functions = require("firebase-functions");
const { DISCORD_WEBHOOOK_URL, API_TOKEN } = require("./config.json");
const axios = require("axios");
const express = require("express");
const app = express();

const assemblyAi = axios.create({
  baseURL: "https://api.assemblyai.com/v2",
  headers: {
    authorization: API_TOKEN,
    "content-type": "application/json",
  },
});
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

    assembly
      .get(`/transcript/`, {
        audio_url: downloadURL,
        webhook_url: "coming soon",
      })
      .then((res) => console.log(res.data))
      .catch((err) => console.error(err));
  });

const transcript_status = "";
const Transcript_id = "";

//if we get a post request
app.post("/", (request, response) => {
  Transcript_id = request.body.transcript_id;
  transcript_status = request.body.status;
});

const getUrl = `https://api.assemblyai.com/v2/transcript/${Transcript_id}`;

// making a get request to the assemble ai api again to get the transcript
const Transcript = "";
await assemblyAi.get(getUrl).then((response) => {
  Transcript = response.body.text;

  //debugging
  await axios.post(DISCORD_WEBHOOOK_URL, {
    content: `Transcript: ${Transcript}`,
  });
});

exports.apiHackHarvard = functions.https.onRequest(app);
