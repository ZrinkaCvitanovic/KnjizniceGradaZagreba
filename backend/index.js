const express = require("express");
const { MongoClient, ObjectId } = require("mongodb");
const cors = require("cors");

const app = express();
const port = 8080;

// Enable Cross-Origin Resource Sharing
app.use(cors());
app.use(express.json());

const mongoUrl = "mongodb://testuser:password@mongodb:27017";
const dbName = "podaci";
let db;

// Connect to MongoDB
async function connectToMongoDB() {
    const client = new MongoClient(mongoUrl);
    await client.connect();
    db = client.db(dbName);
    console.log(`Connected to MongoDB at ${mongoUrl}`);
    const librariesCollection = db.collection("knjiznice");
    const libraries = await librariesCollection.find({}).toArray();
    console.log(libraries);
}

// Endpoint to fetch all libraries
app.get("/api/library/all", async (req, res) => {
    try {
        const librariesCollection = db.collection("knjiznice");
        const libraries = await librariesCollection.find({}).toArray();
        res.json(libraries);
    } catch (error) {
        console.error("Error fetching libraries:", error);
        res.status(500).json({ error: "Failed to fetch libraries" });
    }
});

// Endpoint to fetch a single item by ID
app.get("/api/library/id/:id", async (req, res) => {
    try {
        const librariesCollection = db.collection("knjiznice");
        const { id } = req.params;
        const item = await librariesCollection.findOne({ _id: new ObjectId(id) });
        if (item) {
            res.json(wrapResponse(item));
        } else {
            res.status(404).json(wrapResponse(null, "Library not found"));
        }
    } catch (error) {
        console.error("Error fetching item:", error);
        res.status(500).json(wrapResponse(null, "Failed to fetch library"));
    }
});

app.get("/api/library/hasWifi", async (req, res) => {
    try {
        const librariesCollection = db.collection("knjiznice");
        const libraries = await librariesCollection.find({ Nudi_wifi: "da" }).toArray();
        res.json(wrapResponse(libraries));
    } catch (error) {
        console.error("Error fetching libraries by wifi availability:", error);
        res.status(500).json(wrapResponse(null, "Failed to fetch libraries by wifi availability"));
    }
});

app.get("/api/library/hasComputer", async (req, res) => {
    try {
        const librariesCollection = db.collection("knjiznice");
        const libraries = await librariesCollection.find({ Nudi_racunalo: "da" }).toArray();
        res.json(wrapResponse(libraries));
    } catch (error) {
        console.error("Error fetching recent libraries by computer availability:", error);
        res.status(500).json(wrapResponse(null, "Failed to fetch libraries by computer availability"));
    }
});

// POST endpoint to add a new item -> RADI!
app.post("/api/library", async (req, res) => {
    try {
        const libraryData = req.body; // Get data from request body

        // Generate a new _id for the library
        const { ObjectId } = require("mongodb");
        libraryData._id = new ObjectId();

        const librariesCollection = db.collection("knjiznice");

        // Insert the new library document
        const result = await librariesCollection.insertOne(libraryData);

        res.status(201).json({
            success: true,
            message: "Library created successfully",
            data: { _id: result.insertedId, ...libraryData }, // The newly created document
        });
    } catch (error) {
        console.error("Error creating library:", error);
        res.status(500).json({ success: false, message: "Failed to create library" });
    }
});

// PUT endpoint to update an item by ID
app.put("/api/library/id/:id", async (req, res) => {
    try {
        const { id } = req.params; // Get the ID from the route parameter
        const updates = req.body; // Get the updates from the request body

        // Validate the ID
        if (!ObjectId.isValid(id)) {
            return res.status(400).json({ success: false, message: "Invalid ID format" });
        }

        const librariesCollection = db.collection("knjiznice");

        // Perform the update, excluding the `_id` field from updates
        const result = await librariesCollection.updateOne(
            { _id: new ObjectId(id) }, // Find the document by _id
            { $set: updates } // Apply updates
        );

        if (result.matchedCount === 0) {
            return res.status(404).json({ success: false, message: "Library not found" });
        }

        res.json({
            success: true,
            message: "Library updated successfully",
        });
    } catch (error) {
        console.error("Error updating library:", error);
        res.status(500).json({ success: false, message: "Failed to update library" });
    }
});

// DELETE endpoint to delete an item by ID -> radi
app.delete("/api/library/id/:id", async (req, res) => {
    try {
        const librariesCollection = db.collection("knjiznice");
        const { id } = req.params;
        const result = await librariesCollection.deleteOne({ _id: new ObjectId(id) });
        if (result.deletedCount > 0) {
            res.json(wrapResponse(null, "Library deleted successfully"));
        } else {
            res.status(404).json(wrapResponse(null, "Library not found"));
        }
    } catch (error) {
        console.error("Error deleting library:", error);
        res.status(500).json(wrapResponse(null, "Failed to delete library"));
    }
});

// Middleware to handle errors
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json(wrapResponse(null, "Internal Server Error"));
});

// Start the server
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});

const wrapResponse = (data, message = "Success") => ({
    status: "success",
    message: message,
    data: data,
});

// Connect to MongoDB when the server starts
connectToMongoDB().catch((error) => console.error("Failed to connect to MongoDB:", error));
