const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

// Configure nodemailer with your email service
// Replace these with your actual email service credentials
const transporter = nodemailer.createTransport({
  service: 'gmail',  // or your preferred email service
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASSWORD
  }
});

exports.sendEmail = functions
  .region('europe-west1')  // Match your firebase.json configuration
  .https.onCall(async (data, context) => {
    console.log("Received email request with data:", data);

    try {
      // Validate incoming data
      if (!data.name || !data.email || !data.phone || !data.message || !data.purpose) {
        console.log("Validation failed. Missing fields:", {
          hasName: !!data.name,
          hasEmail: !!data.email,
          hasPhone: !!data.phone,
          hasMessage: !!data.message,
          hasPurpose: !!data.purpose
        });

        throw new functions.https.HttpsError(
          "invalid-argument",
          "Missing required fields"
        );
      }

      // Create email content
      const mailOptions = {
        from: process.env.EMAIL_USER,
        to: 'your-receiving-email@example.com', // Replace with your email
        subject: `New Contact Form Submission - ${data.purpose}`,
        html: `
          <h2>New Contact Form Submission</h2>
          <p><strong>Name:</strong> ${data.name}</p>
          <p><strong>Email:</strong> ${data.email}</p>
          <p><strong>Phone:</strong> ${data.phone}</p>
          <p><strong>Purpose:</strong> ${data.purpose}</p>
          <p><strong>Message:</strong></p>
          <p>${data.message}</p>
        `
      };

      // Send email
      const info = await transporter.sendMail(mailOptions);

      // Create a unique message ID
      const messageId = admin.firestore().collection("email_logs").doc().id;

      // Store the message in Firestore
      await admin.firestore().collection("email_logs").doc(messageId).set({
        name: data.name,
        email: data.email,
        phone: data.phone,
        message: data.message,
        purpose: data.purpose,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
        status: 'sent',
        emailMessageId: info.messageId
      });

      return {
        success: true,
        messageId: messageId,
        message: "Email sent successfully"
      };
    } catch (error) {
      console.error("Error in sendEmail function:", error);

      // Log the error to Firestore
      await admin.firestore().collection("email_logs").add({
        error: error.message,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
        status: 'error'
      });

      throw new functions.https.HttpsError("internal", error.message);
    }
  });