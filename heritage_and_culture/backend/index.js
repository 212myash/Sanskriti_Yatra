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
const mongoDbName = process.env.MONGO_DB_NAME || 'app';
let dbConnectPromise = null;

const destinationSchema = new mongoose.Schema(
  {
    image: { type: String, trim: true, default: '' },
    name: { type: String, trim: true, required: true },
    state: { type: String, trim: true, required: true },
    description: { type: String, trim: true, required: true },
  },
  { timestamps: true }
);

const Destination = mongoose.models.Destination || mongoose.model('Destination', destinationSchema);

const userSchema = new mongoose.Schema(
  {
    name: { type: String, trim: true, required: true },
    user_name: { type: String, trim: true, required: true, index: true },
    phone: { type: String, trim: true, required: true },
    dob: { type: String, trim: true, required: true },
    gender: { type: String, trim: true, required: true },
    password: { type: String, required: true },
  },
  { timestamps: true }
);

const User = mongoose.models.User || mongoose.model('User', userSchema);
const imageRepoRawBase = 'https://raw.githubusercontent.com/212myash/img/main';

const seedDestinations = [
  {
    state: 'Uttar Pradesh',
    name: 'Taj Mahal',
    image: '',
    description: 'World-famous white marble mausoleum in Agra and a symbol of Indian heritage.',
  },
  {
    state: 'Punjab',
    name: 'Golden Temple',
    image: '',
    description: 'The holiest Sikh shrine in Amritsar, known for peace, seva, and architecture.',
  },
  {
    state: 'Rajasthan',
    name: 'Hawa Mahal',
    image: '',
    description: 'Iconic Palace of Winds in Jaipur with unique Rajput architecture.',
  },
  {
    state: 'Karnataka',
    name: 'Hampi',
    image: '',
    description: 'UNESCO heritage ruins of the Vijayanagara Empire with temples and stone architecture.',
  },
  {
    state: 'Bihar',
    name: 'Mahabodhi Temple',
    image: '',
    description: 'Sacred Buddhist site in Bodh Gaya where Buddha attained enlightenment.',
  },
  {
    state: 'Tamil Nadu',
    name: 'Meenakshi Temple',
    image: '',
    description: 'Historic Dravidian temple in Madurai, rich in sculpture and cultural heritage.',
  },
  {
    state: 'Gujarat',
    name: 'Statue of Unity',
    image: '',
    description: 'World tallest statue dedicated to Sardar Vallabhbhai Patel.',
  },
  {
    state: 'Maharashtra',
    name: 'Gateway of India',
    image: '',
    description: 'Historic seafront monument in Mumbai and landmark of colonial-era architecture.',
  },
  {
    state: 'Kerala',
    name: 'Alleppey Backwaters',
    image: '',
    description: 'Scenic backwater destination known for houseboats and local culture.',
  },
  {
    state: 'Uttarakhand',
    name: 'Kedarnath Temple',
    image: '',
    description: 'Sacred Himalayan temple and one of the most important Shiva pilgrimage sites.',
  },
];

const IndianStates = [
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
];

function buildStateCollection(categoryName) {
  return IndianStates.map((state) => ({
    state,
    name: `${state} ${categoryName}`,
    image: '',
    description: `${categoryName} highlights for ${state}.`,
  }));
}

function normalizeRecord(item) {
  const normalized = { ...item };
  const image = typeof normalized.image === 'string' ? normalized.image.trim() : '';

  if (image && !image.startsWith('http://') && !image.startsWith('https://')) {
    const cleanPath = image.replace(/^\/+/, '').replace(/\\/g, '/');
    normalized.image = `${imageRepoRawBase}/${encodeURI(cleanPath)}`;
  }

  return normalized;
}

function normalizeRecords(items) {
  return items.map((item) => normalizeRecord(item));
}

async function fetchCollectionItems(collectionNames) {
  const db = mongoose.connection.db;
  if (!db) {
    return [];
  }

  for (const name of collectionNames) {
    try {
      const docs = await db.collection(name).find({}, { projection: { _id: 0 } }).toArray();
      if (docs.length > 0) {
        return normalizeRecords(docs);
      }
    } catch (_) {
      // Try next candidate collection name.
    }
  }

  return [];
}

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

function escapeRegex(text) {
  return String(text).replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function validatePayload(payload) {
  const missing = [];
  if (!payload.name) missing.push('name');
  if (!payload.state) missing.push('state');
  if (!payload.description) missing.push('description');
  return missing;
}

async function ensureDbConnection() {
  if (mongoose.connection.readyState === 1) {
    return true;
  }

  if (!mongoUri) {
    return false;
  }

  if (!dbConnectPromise) {
    dbConnectPromise = mongoose
      .connect(mongoUri, { dbName: mongoDbName })
      .then(() => {
        console.log(`MongoDB connected. db=${mongoDbName}`);
        return true;
      })
      .catch((error) => {
        console.error('MongoDB connection failed.', error);
        dbConnectPromise = null;
        return false;
      });
  }

  return dbConnectPromise;
}

async function guardDb(res) {
  const ready = await ensureDbConnection();
  if (!ready) {
    res.status(503).json({
      message: 'Database is not connected yet.',
      mongoConfigured: Boolean(mongoUri),
    });
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

app.get('/api/health', async (req, res) => {
  const connected = await ensureDbConnection();
  res.json({
    ok: true,
    database: connected ? 'connected' : 'disconnected',
    mongoConfigured: Boolean(mongoUri),
    dbName: mongoDbName,
  });
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
    if (!(await guardDb(res))) return;
    let data = await Destination.find({}, { _id: 0, __v: 0 }).lean();
    data = normalizeRecords(data);
    if (data.length === 0) {
      data = await fetchCollectionItems(['test', 'posts']);
    }
    res.json({ users: data, data });
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch destinations.' });
  }
});

app.get('/api/hh', async (req, res) => {
  try {
    if (!(await guardDb(res))) return;
    const users = await fetchCollectionItems(['hh', 'historical', 'heritage']);
    const data = users.length > 0 ? users : buildStateCollection('Historical Heritage');
    res.json({ users: data, data });
  } catch (_) {
    res.status(500).json({ message: 'Failed to fetch historical heritage data.' });
  }
});

app.get(['/api/arts', '/api/ta'], async (req, res) => {
  try {
    if (!(await guardDb(res))) return;
    const users = await fetchCollectionItems(['h', 'arts', 'ta']);
    const data = users.length > 0 ? users : buildStateCollection('Traditional Arts');
    res.json({ users: data, data });
  } catch (_) {
    res.status(500).json({ message: 'Failed to fetch traditional arts data.' });
  }
});

app.get('/api/f', async (req, res) => {
  try {
    if (!(await guardDb(res))) return;
    const users = await fetchCollectionItems(['f', 'festivals']);
    const data = users.length > 0 ? users : buildStateCollection('Festivals');
    res.json({ users: data, data });
  } catch (_) {
    res.status(500).json({ message: 'Failed to fetch festival data.' });
  }
});

app.get('/api/ll', async (req, res) => {
  try {
    if (!(await guardDb(res))) return;
    const users = await fetchCollectionItems(['ll', 'language_literature', 'language']);
    const data = users.length > 0 ? users : buildStateCollection('Language and Literature');
    res.json({ users: data, data });
  } catch (_) {
    res.status(500).json({ message: 'Failed to fetch language data.' });
  }
});

app.get('/api/uc', async (req, res) => {
  try {
    if (!(await guardDb(res))) return;
    const users = await fetchCollectionItems(['uc', 'traditions', 'customs']);
    const data = users.length > 0 ? users : buildStateCollection('Traditions and Customs');
    res.json({ users: data, data });
  } catch (_) {
    res.status(500).json({ message: 'Failed to fetch traditions data.' });
  }
});

app.get('/api/c', async (req, res) => {
  try {
    if (!(await guardDb(res))) return;
    const users = await fetchCollectionItems(['c', 'culinary']);
    const data = users.length > 0 ? users : buildStateCollection('Culinary Heritage');
    res.json({ users: data, data });
  } catch (_) {
    res.status(500).json({ message: 'Failed to fetch culinary data.' });
  }
});

// Compatibility route for old clients that request arbitrary collections.
app.get('/api/:id', async (req, res) => {
  try {
    if (!(await guardDb(res))) return;
    const collectionName = req.params.id;
    const users = await fetchCollectionItems([collectionName]);
    res.json({ users, data: users });
  } catch (_) {
    res.status(500).json({ message: 'Failed to fetch data.' });
  }
});

// Flutter add page currently uses /api/post/test.
app.post(['/api/post/test', '/api/posts'], async (req, res) => {
  try {
    if (!(await guardDb(res))) return;

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

app.post('/api/users/register', async (req, res) => {
  try {
    if (!(await guardDb(res))) return;

    const { name, user_name, phone, dob, gender, password } = req.body || {};
    if (!name || !user_name || !phone || !dob || !gender || !password) {
      return res.status(400).json({ message: 'All fields are required' });
    }

    const normalizedUserName = String(user_name).trim();
    const userNameRegex = new RegExp(`^${escapeRegex(normalizedUserName)}$`, 'i');

    const existingUser = await User.findOne({ user_name: userNameRegex }).lean();
    if (existingUser) {
      return res.status(400).json({ message: 'Username already exists' });
    }

    const created = await User.create({
      name: String(name).trim(),
      user_name: normalizedUserName,
      phone: String(phone).trim(),
      dob: String(dob).trim(),
      gender: String(gender).trim(),
      password: String(password),
    });

    res.status(201).json({
      message: 'User registered successfully',
      user: {
        name: created.name,
        user_name: created.user_name,
        phone: created.phone,
        dob: created.dob,
        gender: created.gender,
      },
    });
  } catch (_) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
});

app.post('/api/users/login', async (req, res) => {
  try {
    if (!(await guardDb(res))) return;

    const { user_name, password } = req.body || {};
    if (!user_name || !password) {
      return res.status(400).json({ message: 'Username and password are required' });
    }

    const normalizedUserName = String(user_name).trim();
    const userNameRegex = new RegExp(`^${escapeRegex(normalizedUserName)}$`, 'i');

    const user = await User.findOne({ user_name: userNameRegex, password: String(password) }).lean();
    if (!user) {
      return res.status(401).json({ message: 'Invalid username or password' });
    }

    res.json({
      message: 'Login successful',
      user: {
        name: user.name,
        user_name: user.user_name,
        phone: user.phone,
        dob: user.dob,
        gender: user.gender,
      },
    });
  } catch (_) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
});

app.post('/api/users/forget', async (req, res) => {
  try {
    if (!(await guardDb(res))) return;

    const { user_name, newPassword, new_password } = req.body || {};
    const finalNewPassword = newPassword ?? new_password;

    if (!user_name || !finalNewPassword) {
      return res.status(400).json({ message: 'Username and new password are required' });
    }

    const normalizedUserName = String(user_name).trim();
    const userNameRegex = new RegExp(`^${escapeRegex(normalizedUserName)}$`, 'i');

    const updated = await User.findOneAndUpdate(
      { user_name: userNameRegex },
      { $set: { password: String(finalNewPassword) } },
      { new: true }
    ).lean();

    if (!updated) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.json({ message: 'Password updated successfully' });
  } catch (_) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
});

app.post('/api/seed/posts', async (req, res) => {
  try {
    if (!(await guardDb(res))) return;

    const force = req.query.force === '1';
    const existingCount = await Destination.countDocuments();

    if (existingCount > 0 && !force) {
      return res.status(200).json({
        message: 'Seed skipped because data already exists. Use ?force=1 to insert anyway.',
        existingCount,
      });
    }

    if (force) {
      await Destination.deleteMany({});
    }

    const inserted = await Destination.insertMany(seedDestinations);
    res.status(201).json({
      message: 'Seed data inserted successfully.',
      insertedCount: inserted.length,
    });
  } catch (_) {
    res.status(500).json({ message: 'Failed to seed destination data.' });
  }
});

async function bootstrap() {
  if (!mongoUri) {
    console.warn('MONGO_URI is not set. Set it in Vercel project environment variables.');
  } else {
    await ensureDbConnection();
  }

  if (process.env.VERCEL !== '1') {
    const port = process.env.PORT || 5000;
    app.listen(port, () => {
      console.log(`Backend running on port ${port}`);
    });
  }
}

bootstrap();

module.exports = app;
