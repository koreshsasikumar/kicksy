// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyAoBYB8KYX2Y0LC7mTPUeHW78YiUjgHG6o",
    authDomain: "kicksy-ca668.firebaseapp.com",
    projectId: "kicksy-ca668",
    storageBucket: "kicksy-ca668.firebasestorage.app",
    messagingSenderId: "10826962821",
    appId: "1:10826962821:web:12d4577b5ca85af0a256ec",
    measurementId: "G-YMPP4LW5EP"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

export const db = getFirestore(app);       // Firestore database
export const storage = getStorage(app);  // Firebase storage