import dotenv from "dotenv";
import express from "express";
import * as routes from "./routes/v1";
import timestamp from "time-stamp";

// initialize configuration
dotenv.config();

// port is now available to the Node.js runtime
// as if it were an environment variable
const port = process.env.SERVER_PORT;

const app = express();

// Configure Express to parse JSON
app.use( express.json() );

// Configure routes
routes.register( app );

// start the express server
app.listen( port, () => {    console.log(`[${timestamp(`YYYY/MM/DD HH:mm:ss.ms`)}] Server started at http://localhost:${ port }` );
} );
