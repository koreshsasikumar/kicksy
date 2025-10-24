// admin/src/addProduct.js
import { doc, setDoc } from "firebase/firestore";
import { db } from "./firebase.js";

export async function addProduct(name, price, description, imageUrls) {
  const docRef = doc(db, "products", name); // document ID = product name
  await setDoc(docRef, {
    name,
    price,
    description,
    images: imageUrls,
    approved: false // only visible to admin initially
  });
  console.log("Product added successfully!");
}
