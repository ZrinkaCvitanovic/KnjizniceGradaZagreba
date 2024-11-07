const express = require('express');
const { MongoClient } = require('mongodb');
const cors = require('cors');

const app = express();
const port = 3000;

// Enable Cross-Origin Resource Sharing
app.use(cors());

// const mongoUrl = 'mongodb://testuser:password@mongodb:27017'; //for docker
const mongoUrl = 'mongodb://testuser:password@localhost:27017'; //for local

const dbName = 'podaci';
let db;

// Connect to MongoDB
async function connectToMongoDB() {
  const client = new MongoClient(mongoUrl);
  await client.connect();
  db = client.db(dbName);
  console.log(`Connected to MongoDB at ${mongoUrl}`);
}

// Endpoint to fetch all libraries
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

// Start the server
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});

// Connect to MongoDB when the server starts
connectToMongoDB().catch(error => console.error('Failed to connect to MongoDB:', error));
