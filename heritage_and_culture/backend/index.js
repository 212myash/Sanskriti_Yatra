const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
require('dotenv').config();

const app = express();

app.use(express.json({ limit: '1mb' }));
app.use(
  cors({
    origin: true,
    methods: ['GET', 'POST', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
  })
);

const mongoUri = process.env.MONGO_URI;
let isDbReady = false;

const destinationSchema = new mongoose.Schema(
  {
    image: { type: String, trim: true, default: '' },
    name: { type: String, trim: true, required: true },
    state: { type: String, trim: true, required: true },
    description: { type: String, trim: true, required: true },
  },
  { timestamps: true }
);

const Destination = mongoose.model('Destination', destinationSchema);

function cleanText(value, maxLen) {
  if (typeof value !== 'string') return '';
  return value.trim().slice(0, maxLen);
}

function normalizePayload(body) {
  return {
    image: cleanText(body?.image, 2048),
    name: cleanText(body?.name, 200),
    state: cleanText(body?.state, 200),
    description: cleanText(body?.description, 5000),
  };
}

function validatePayload(payload) {
  const missing = [];
  if (!payload.name) missing.push('name');
  if (!payload.state) missing.push('state');
  if (!payload.description) missing.push('description');
  return missing;
}

function guardDb(res) {
  if (!isDbReady) {
    res.status(503).json({ message: 'Database is not connected yet.' });
    return false;
  }
  return true;
}

app.get('/', (req, res) => {
  res.status(200).send(`
    <html>
      <head>
        <title>Sanskriti Yatra API</title>
        <style>
          body { font-family: Arial, sans-serif; padding: 32px; line-height: 1.6; }
          code { background: #f2f2f2; padding: 2px 6px; border-radius: 4px; }
        </style>
      </head>
      <body>
        <h1>Sanskriti Yatra API</h1>
        <p>The backend is running.</p>
        <ul>
          <li><code>/api/health</code> - health check</li>
          <li><code>/api/posts</code> - list destinations</li>
          <li><code>/api/post/test</code> - create a destination</li>
        </ul>
      </body>
    </html>
  `);
});

app.get('/api/health', (req, res) => {
  res.json({ ok: true, database: isDbReady ? 'connected' : 'disconnected' });
});

app.get('/api/post/test', (req, res) => {
  res.status(200).json({
    message: 'This endpoint accepts POST requests to create a destination.',
    method: 'POST',
    endpoint: '/api/post/test',
  });
});

// Flutter dashboard fetches this route.
app.get('/api/posts', async (req, res) => {
  try {
    if (!guardDb(res)) return;
    const data = await Destination.find().lean();
    res.json({ users: data, data });
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch destinations.' });
  }
});

// Flutter add page currently uses /api/post/test.
app.post(['/api/post/test', '/api/posts'], async (req, res) => {
  try {
    if (!guardDb(res)) return;

    const payload = normalizePayload(req.body);
    const missing = validatePayload(payload);

    if (missing.length > 0) {
      res.status(400).json({ message: `Missing required fields: ${missing.join(', ')}` });
      return;
    }

    const created = await Destination.create(payload);
    res.status(201).json({ message: 'Destination created successfully.', data: created });
  } catch (error) {
    res.status(500).json({ message: 'Failed to create destination.' });
  }
});

async function bootstrap() {
  if (!mongoUri) {
    console.warn('MONGO_URI is not set. Set it in Vercel project environment variables.');
  } else {
    try {
      await mongoose.connect(mongoUri);
      isDbReady = true;
      console.log('MongoDB connected.');
    } catch (error) {
      console.error('MongoDB connection failed.', error);
      isDbReady = false;
    }
  }

  const port = process.env.PORT || 5000;
  app.listen(port, () => {
    console.log(`Backend running on port ${port}`);
  });
}

bootstrap();
