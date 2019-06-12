const express = require("express");
const middleware = require("./middleware/config");
const userRouter = require("./routes/userRoutes.js");
const postRouter = require("./routes/postRoutes.js");
const server = express();

//middleware
middleware(server);

//routes
server.use("/api/users", userRouter);
server.use("/api/posts", postRouter);
server.get("/", (req, res) => res.send("Welcome to the Main API"));

module.exports = server;
