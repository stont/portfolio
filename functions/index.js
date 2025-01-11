const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendEmail = functions.https.onCall(async (data, context) => {
  try {
    // Validate incoming data
    if (!data.name || !data.email || !data.phone || !data.message || !data.purpose) {
      throw new functions.https.HttpsError(
          "invalid-argument",
          "Missing required fields"
      );
    }

    // Create a unique message ID
    const messageId = admin.firestore().collection("email_logs").doc().id;

    // Here you would typically integrate with your email service
    // For now, we'll just return success
    return {
      success: true,
      messageId: messageId,
      message: "Email sent successfully"
    };
  } catch (error) {
    console.error("Error sending email:", error);
    throw new functions.https.HttpsError("internal", error.message);
  }
});