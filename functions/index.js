const functions = require("firebase-functions");
const {
  DISCORD_WEBHOOK_URL,
  ASSEMBLYAI_TRANSCRIPT_API,
  ASSEMBLYAI_API_TOKEN,
  WEBHOOK_CLOUD_FUNCTION_URL,
} = require("./config.json");
const axios = require("axios");

exports.generateTranscript = functions.storage
  .object()
  .onFinalize(async (object) => {
    const objectPath = object.name.replace(/ /g, "%20").replace(/\//g, "%2F");

    const audio_url = `https://firebasestorage.googleapis.com/v0/b/${object.bucket}/o/${objectPath}?alt=media`;

    await axios.post(DISCORD_WEBHOOK_URL, {
      content: `${object.name} has been uploaded in ${object.bucket}. Public download url is at ${audio_url}`,
    });

    await axios.post(
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
  });

exports.transcriptWebhook = functions.https.onRequest(
  async (request, response) => {
    const { status, transcript_id } = request.body;
    console.log(status);
    const transcript_response = await axios.get(
      `${ASSEMBLYAI_TRANSCRIPT_API}/${transcript_id}`,
      {
        headers: {
          Authorization: ASSEMBLYAI_API_TOKEN,
          "Content-Type": "application/json",
        },
      }
    );
    console.log(transcript_response.data);
    await axios.post(DISCORD_WEBHOOK_URL, {
      content: `Transcription complete! ${transcript_response.data.text}`,
    });
    response.send();
  }
);
