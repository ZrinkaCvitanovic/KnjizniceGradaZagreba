const express = require("express");
const { MongoClient, ObjectId } = require("mongodb");
const cors = require("cors");

const app = express();
const port = 8080;

const jwt = require("jsonwebtoken");
const { auth, requiresAuth } = require("express-openid-connect");
const dotenv = require("dotenv");
dotenv.config();

app.use(cors());
app.use(express.json());

const mongoUrl = "mongodb://testuser:password@mongodb:27017";
const dbName = "podaci";
let db;

async function connectToMongoDB() {
    const client = new MongoClient(mongoUrl);
    await client.connect();
    db = client.db(dbName);
    console.log(`Connected to MongoDB at ${mongoUrl}`);
    const librariesCollection = db.collection("knjiznice");
    const libraries = await librariesCollection.find({}).toArray();
    console.log(libraries);
}

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

app.post("/api/library", async (req, res) => {
    try {
        const libraryData = req.body;
        const { ObjectId } = require("mongodb");
        libraryData._id = new ObjectId();

        const librariesCollection = db.collection("knjiznice");

        const result = await librariesCollection.insertOne(libraryData);

        res.status(201).json({
            success: true,
            message: "Library created successfully",
            data: { _id: result.insertedId, ...libraryData },
        });
    } catch (error) {
        console.error("Error creating library:", error);
        res.status(500).json({ success: false, message: "Failed to create library" });
    }
});

app.put("/api/library/id/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const updates = req.body;

        if (!ObjectId.isValid(id)) {
            return res.status(400).json({ success: false, message: "Invalid ID format" });
        }

        const librariesCollection = db.collection("knjiznice");

        const result = await librariesCollection.updateOne({ _id: new ObjectId(id) }, { $set: updates });

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

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json(wrapResponse(null, "Internal Server Error"));
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});

const wrapResponse = (data, message = "Success") => ({
    status: "success",
    message: message,
    data: data,
});

app.get("/api-spec", (req, res) => {
    res.sendFile(__dirname + "/openapi.json");
});

const config = {
    authRequired: false,
    auth0Logout: true,
    secret: "a long, randomly-generated string stored in env",
    baseURL: "http://localhost:8080",
    clientID: "ix1BhVY2oPVQx8XOEpc6K20FQNQz3xTN",
    issuerBaseURL: "https://dev-t28ghi7bovcfgijv.us.auth0.com",
    //issuerBaseURL: "https://dev-0a66pm1zz2c5mu0u.us.auth0.com",
    //https://dev-t28ghi7bovcfgijv.us.auth0.com/login
};

// auth router attaches /login, /logout, and /callback routes to the baseURL
app.use(auth(config));

app.get("/", (req, res) => {
    if (req.oidc.isAuthenticated()) {
        const token = jwt.sign({ sub: req.oidc.user.sub }, process.env.JWT_SECRET, { expiresIn: "1h" });
        const redirectUrl = `http://localhost:8080/token?token=${token}`;
        res.redirect(redirectUrl);
    } else {
        res.status(401).send("Not authenticated");
    }
});

app.get("/token", (req, res) => {
    const token = req.query.token;
    res.send(`<script>window.opener.postMessage('${token}', '*'); window.close();</script>`);
});

app.get("/#/profile", requiresAuth(), (req, res) => {
    try {
        const userData = req.oidc.user;

        if (!userData) {
            return res.status(404).json({
                status: "error",
                message: "User not found",
            });
        }

        res.json({
            status: "success",
            data: userData,
        });
    } catch (error) {
        console.error("Error fetching profile:", error);
        res.status(500).json({
            status: "error",
            message: "Internal server error",
        });
    }
});

app.get("/profile", requiresAuth(), (req, res) => {
    res.send(JSON.stringify(req.oidc.user));
    //    { "sid": "7xvYeHNYiOwwDdd20AziO5Cx9FO7vZK1", "nickname": "or", "name": "or@or.hr", "picture": "https://s.gravatar.com/avatar/6b6cb91d20473078f5fb642ac782bfed?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2For.png", "updated_at": "2025-01-19T17:39:40.669Z", "email": "or@or.hr", "email_verified": false, "sub": "auth0|6784f7ca6db6f235a0873045" }
});

app.get("/logout", (req, res) => {
    res.oidc.logout();
});

connectToMongoDB().catch((error) => console.error("Failed to connect to MongoDB:", error));
