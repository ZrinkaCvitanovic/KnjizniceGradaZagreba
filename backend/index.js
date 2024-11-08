const express = require('express');
const { MongoClient } = require('mongodb');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());

// const mongoUrl = 'mongodb://testuser:password@mongodb:27017'; //for docker
const mongoUrl = 'mongodb://testuser:password@localhost:27017'; //for local

const dbName = 'podaci';
let db;

async function connectToMongoDB() {
  const client = new MongoClient(mongoUrl);
  await client.connect();
  db = client.db(dbName);
  console.log(`Connected to MongoDB at ${mongoUrl}`);
}

app.get('/libraries', async (req, res) => {
  try {
    const librariesCollection = db.collection('knjiznice');
    const libraries = await librariesCollection.find({}).toArray();
    res.json(libraries);
  } catch (error) {
    console.error('Error fetching libraries:', error);
    res.status(500).json({ error: 'Failed to fetch libraries' });
  }
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});

connectToMongoDB().catch(error => console.error('Failed to connect to MongoDB:', error));
