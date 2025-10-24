import { uploadImage } from "./uploadImage.js";
import { addProduct } from "./addProduct.js";
import { approveProduct } from "./approveProduct.js";

async function main() {

    // 1 Upload images
    const urls = [];
    urls.push(await uploadImage("./images/1.png"));
    urls.push(await uploadImage("./images/2.png"));

    // 2 Add product
    await addProduct("NikeAirZoom", 499, "Lightweight running shoes", urls);

    // 3 Approve product when ready
    await approveProduct("NikeAirZoom");
}

main();
