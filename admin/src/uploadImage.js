// admin/src/uploadImage.js
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";
import { storage } from "./firebase.js";
import fs from "fs";
import path from "path";

export async function uploadImage(filePath) {
    const fileName = path.basename(filePath); // e.g., "1.png"
    const storageRef = ref(storage, `products/${fileName}`);
    const fileBuffer = fs.readFileSync(filePath);

    const snapshot = await uploadBytes(storageRef, fileBuffer);
    const url = await getDownloadURL(snapshot.ref);
    console.log("Uploaded image URL:", url);
    return url;
}
