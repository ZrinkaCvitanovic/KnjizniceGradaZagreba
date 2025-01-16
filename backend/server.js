express = require("express");
const { auth } = require("express-openid-connect");

const config = {
    authRequired: false,
    auth0Logout: true,
    secret: "a long, randomly-generated string stored in env",
    baseURL: "https://localhost:8080",
    clientID: "ix1BhVY2oPVQx8XOEpc6K20FQNQz3xTN",
    issuerBaseURL: "https://dev-t28ghi7bovcfgijv.us.auth0.com",
};

const app = express();
const PORT = 8080;

// auth router attaches /login, /logout, and /callback routes to the baseURL
app.use(auth(config));

// req.isAuthenticated is provided from the auth router
app.get("/", (req, res) => {
    res.send(req.oidc.isAuthenticated() ? "Logged in" : "Logged out");
});

const { requiresAuth } = require("express-openid-connect");

app.get("/profile", requiresAuth(), (req, res) => {
    res.send(JSON.stringify(req.oidc.user));
});

app.listen(PORT, () => {
    console.log(`Express server running at http://localhost:${PORT}/`);
});
