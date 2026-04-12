require('dotenv').config();
const mongoose = require('mongoose');
const { seedHeritageFromPexels } = require('./heritagePexels');

async function main() {
  const mongoUri = process.env.MONGO_URI;
  const mongoDbName = process.env.MONGO_DB_NAME || 'app';

  if (!mongoUri) {
    throw new Error('MONGO_URI is missing. Add it to your environment variables.');
  }

  try {
    await mongoose.connect(mongoUri, { dbName: mongoDbName });

    const result = await seedHeritageFromPexels();

    console.log('Data inserted successfully');
    console.log(`Inserted: ${result.insertedCount}, matched: ${result.matchedCount}`);
  } catch (error) {
    console.error('Failed to seed heritage data:', error.message);
    process.exitCode = 1;
  } finally {
    await mongoose.disconnect();
  }
}

main();