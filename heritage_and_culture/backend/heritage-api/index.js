const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const dotenv = require("dotenv");

dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());

// 🔹 MongoDB Connection
mongoose
  .connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log("MongoDB Connected"))
  .catch((err) => console.log("Error:", err));

// 🔹 Heritage Schema & Model
const HeritageSchema = new mongoose.Schema({
  image: String,
  name: String,
  state: String,
  description: String,
});

const Heritage = mongoose.model("Heritage", HeritageSchema);

// 🔹 Routes

// 👉 Add a Heritage Place
app.post("/api/posts", async (req, res) => {
  try {
    const newPlace = new Heritage(req.body);
    await newPlace.save();
    res.status(201).json(newPlace);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 👉 Get All Heritage Places
app.get("/api/posts", async (req, res) => {
  try {
    const places = await Heritage.find();
    res.json(places);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 🔹 Start Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
