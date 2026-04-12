const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const dotenv = require("dotenv");

dotenv.config();
const app = express();
app.use(express.json({ limit: "1mb" }));

const allowedOrigins = (process.env.CORS_ORIGINS || "http://localhost:3000,http://localhost:5000,https://test2342.vercel.app")
  .split(",")
  .map((origin) => origin.trim())
  .filter(Boolean);

app.use(
  cors({
    origin(origin, callback) {
      if (!origin || allowedOrigins.includes(origin)) {
        callback(null, true);
        return;
      }

      callback(new Error("Not allowed by CORS"));
    },
    methods: ["GET", "POST", "OPTIONS"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);

const mongoUri = process.env.MONGO_URI;
if (!mongoUri) {
  console.warn("MONGO_URI is not configured. Database requests will fail until it is provided.");
}

let isDatabaseReady = false;

async function connectDatabase() {
  if (!mongoUri) {
    return;
  }

  try {
    await mongoose.connect(mongoUri);
    isDatabaseReady = true;
    console.log("MongoDB Connected");
  } catch (err) {
    console.error("Error:", err);
  }
}

// 🔹 Heritage Schema & Model
const HeritageSchema = new mongoose.Schema({
  image: { type: String, trim: true, default: "" },
  name: { type: String, trim: true, required: true },
  state: { type: String, trim: true, required: true },
  description: { type: String, trim: true, required: true },
}, {
  timestamps: true,
});

const Heritage = mongoose.model("Heritage", HeritageSchema);

function normalizeText(value, maxLength) {
  if (typeof value !== "string") {
    return "";
  }

  return value.trim().slice(0, maxLength);
}

function buildHeritagePayload(body) {
  return {
    image: normalizeText(body?.image, 2048),
    name: normalizeText(body?.name, 200),
    state: normalizeText(body?.state, 200),
    description: normalizeText(body?.description, 5000),
  };
}

function validateHeritagePayload(payload) {
  const missing = [];

  if (!payload.name) missing.push("name");
  if (!payload.state) missing.push("state");
  if (!payload.description) missing.push("description");

  return missing;
}

function ensureDatabaseReady(res) {
  if (!isDatabaseReady) {
    res.status(503).json({ error: "Database is not configured" });
    return false;
  }

  return true;
}

// 🔹 Routes

// 👉 Add a Heritage Place
app.post(["/api/posts", "/api/post/test"], async (req, res) => {
  try {
    if (!ensureDatabaseReady(res)) {
      return;
    }

    const payload = buildHeritagePayload(req.body);
    const missingFields = validateHeritagePayload(payload);

    if (missingFields.length > 0) {
      res.status(400).json({
        error: `Missing required fields: ${missingFields.join(", ")}`,
      });
      return;
    }

    const newPlace = await Heritage.create(payload);
    res.status(201).json({
      message: "Heritage place created successfully",
      data: newPlace,
      users: [newPlace],
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 👉 Get All Heritage Places
app.get("/api/posts", async (req, res) => {
  try {
    if (!ensureDatabaseReady(res)) {
      return;
    }

    const places = await Heritage.find().lean();
    res.json({ users: places, data: places });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 🔹 Start Server
const PORT = process.env.PORT || 5000;
connectDatabase().finally(() => {
  app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
});
