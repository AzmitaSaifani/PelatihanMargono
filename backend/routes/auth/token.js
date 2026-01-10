import crypto from "crypto";

const SECRET = process.env.TOKEN_SECRET || "pelatihan_rsms_secret_key";

export function encryptId(id) {
  const payload = id.toString();

  const signature = crypto
    .createHmac("sha256", SECRET)
    .update(payload)
    .digest("hex");

  return Buffer.from(`${payload}.${signature}`).toString("base64");
}

export function decryptId(token) {
  const decoded = Buffer.from(token, "base64").toString("utf-8");
  const [payload, signature] = decoded.split(".");

  if (!payload || !signature) {
    throw new Error("Format token tidak valid");
  }

  const expectedSignature = crypto
    .createHmac("sha256", SECRET)
    .update(payload)
    .digest("hex");

  if (signature !== expectedSignature) {
    throw new Error("Token tidak valid");
  }

  return payload;
}
