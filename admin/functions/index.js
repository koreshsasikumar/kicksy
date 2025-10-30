const functions = require("firebase-functions");
const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({ credential: admin.credential.cert(serviceAccount), });

exports.setAdminRole = functions.https.onCall(async (data, context) => {
    // Only allow already logged-in admins to assign roles
    if (!context.auth?.token.admin) {
        throw new functions.https.HttpsError(
            "permission-denied",
            "Only admins can assign admin roles."
        );
    }

    const email = data.email;

    try {
        const user = await admin.auth().getUserByEmail(email);
        await admin.auth().setCustomUserClaims(user.uid, { admin: true });

        return { message: `${email} has been granted admin access.` };
    } catch (error) {
        throw new functions.https.HttpsError("unknown", error.message);
    }
});
