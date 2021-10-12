const {
  ASSEMBLYAI_TRANSCRIPT_API,
  ASSEMBLYAI_API_TOKEN,
  WEBHOOK_CLOUD_FUNCTION_URL,
} = require("./config.json");
const axios = require("axios");

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.generateTranscript = functions.storage
  .object()
  .onFinalize(async (object) => {
    const objectPath = object.name.replace(/ /g, "%20").replace(/\//g, "%2F");
    const uuidv4Regex =
      /[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i;

    const author = object.metadata.uid;
    if (!author) return;

    const audio_url = `https://firebasestorage.googleapis.com/v0/b/${object.bucket}/o/${objectPath}?alt=media`;
    const audioID = object.name.match(uuidv4Regex)?.[0];
    if (!audioID) return;

    const assemlyAIresponse = await axios.post(
      ASSEMBLYAI_TRANSCRIPT_API,
      {
        audio_url,
        webhook_url: WEBHOOK_CLOUD_FUNCTION_URL,
      },
      {
        headers: {
          Authorization: ASSEMBLYAI_API_TOKEN,
          "Content-Type": "application/json",
        },
      }
    );

    const db = admin.firestore();
    await db.collection("transcripts").doc(assemlyAIresponse.data.id).set({
      author,
      transcript: "Processing...",
      audioID,
    });
  });

exports.transcriptWebhook = functions.https.onRequest(
  async (request, response) => {
    const { status, transcript_id } = request.body;
    if (status !== "completed") return;
    const transcript_response = await axios.get(
      `${ASSEMBLYAI_TRANSCRIPT_API}/${transcript_id}`,
      {
        headers: {
          Authorization: ASSEMBLYAI_API_TOKEN,
          "Content-Type": "application/json",
        },
      }
    );
    const db = admin.firestore();
    await db.collection("transcripts").doc(transcript_response.data.id).update({
      transcript: transcript_response.data.text,
    });
    response.send();
  }
);
