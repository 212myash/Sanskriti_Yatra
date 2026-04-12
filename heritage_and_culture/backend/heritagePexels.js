const axios = require('axios');
const mongoose = require('mongoose');

const PEXELS_API_URL = 'https://api.pexels.com/v1/search';
const PEXELS_PER_PAGE = 10;

const heritageSchema = new mongoose.Schema(
  {
    state: { type: String, trim: true, required: true },
    category: { type: String, trim: true, required: true },
    name: { type: String, trim: true, required: true },
    image: { type: String, trim: true, required: true },
    description: { type: String, trim: true, required: true },
  },
  { timestamps: true }
);

// Prevent duplicate rows for the same heritage item.
heritageSchema.index({ state: 1, category: 1, name: 1 }, { unique: true });

const Heritage = mongoose.models.Heritage || mongoose.model('Heritage', heritageSchema);

const HERITAGE_QUERIES = [
  { query: 'Rajasthan culture', state: 'Rajasthan', category: 'Culture' },
  { query: 'Kerala tourism', state: 'Kerala', category: 'Tourism' },
  { query: 'Punjab festival', state: 'Punjab', category: 'Festival' },
  { query: 'Tamil Nadu temple', state: 'Tamil Nadu', category: 'Temple' },
  { query: 'Maharashtra food', state: 'Maharashtra', category: 'Food' },
  { query: 'Indian dance', state: 'India', category: 'Dance' },
  {
    query: 'Indian heritage monuments',
    state: 'India',
    category: 'Heritage Monuments',
  },
];

function getPexelsApiKey() {
  const apiKey = process.env.PEXELS_API_KEY;
  if (!apiKey) {
    throw new Error('PEXELS_API_KEY is missing. Add it to your environment variables.');
  }

  return apiKey;
}

function safeText(value, fallback = '') {
  if (typeof value !== 'string') {
    return fallback;
  }

  const text = value.trim();
  return text || fallback;
}

function buildRecord(config, photo, index) {
  const imageUrl =
    photo?.src?.large2x || photo?.src?.large || photo?.src?.original || photo?.src?.medium;

  return {
    state: config.state,
    category: config.category,
    name: safeText(photo?.alt, `${config.state} ${config.category} ${index + 1}`),
    image: safeText(imageUrl, ''),
    description: safeText(
      photo?.alt,
      `Curated Pexels image for ${config.query}.`
    ),
  };
}

async function fetchPhotosForQuery(query, perPage = PEXELS_PER_PAGE) {
  const response = await axios.get(PEXELS_API_URL, {
    headers: {
      Authorization: getPexelsApiKey(),
    },
    params: {
      query,
      per_page: perPage,
      orientation: 'landscape',
      locale: 'en-US',
    },
  });

  return Array.isArray(response.data?.photos) ? response.data.photos : [];
}

async function seedHeritageFromPexels() {
  const operations = [];

  for (const config of HERITAGE_QUERIES) {
    const photos = await fetchPhotosForQuery(config.query, PEXELS_PER_PAGE);

    photos.slice(0, PEXELS_PER_PAGE).forEach((photo, index) => {
      const record = buildRecord(config, photo, index);

      if (!record.image) {
        return;
      }

      operations.push({
        updateOne: {
          filter: {
            state: record.state,
            category: record.category,
            name: record.name,
          },
          update: { $setOnInsert: record },
          upsert: true,
        },
      });
    });
  }

  if (operations.length === 0) {
    return { insertedCount: 0, matchedCount: 0 };
  }

  const result = await Heritage.bulkWrite(operations, { ordered: false });

  return {
    insertedCount: result.upsertedCount || 0,
    matchedCount: result.matchedCount || 0,
  };
}

async function getFilteredHeritage({ state, category }) {
  const query = {};

  if (state) {
    query.state = new RegExp(`^${escapeRegex(state)}$`, 'i');
  }

  if (category) {
    query.category = new RegExp(`^${escapeRegex(category)}$`, 'i');
  }

  return Heritage.find(query).sort({ state: 1, category: 1, name: 1 }).lean();
}

function escapeRegex(text) {
  return String(text).replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

module.exports = {
  Heritage,
  HERITAGE_QUERIES,
  fetchPhotosForQuery,
  getFilteredHeritage,
  seedHeritageFromPexels,
};