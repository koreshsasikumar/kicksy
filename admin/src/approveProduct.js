import { doc, updateDoc } from "firebase/firestore";
import { db } from "./firebase.js";

export async function approveProduct(productId) {
  const docRef = doc(db, "products", productId);
  await updateDoc(docRef, { approved: true });
  console.log("Product approved!");
}
