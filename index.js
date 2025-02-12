import express from 'express'
import cors from 'cors'
import path from 'path'
import 'dotenv/config'
import { storeController } from './controller/storeController.js'

// Create an express app
const app = express()
const port = +process.env.PORT || 3000

// Middleware
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Credentials", "true");
    res.header("Access-Control-Allow-Methods", "*");
    res.header("Access-Control-Request-Methods", "*");
    res.header("Access-Control-Allow-Headers", "*");
    res.header("Access-Control-Expose-Headers", "Authorization");

    next()
})


app.use(
    express.static('./static'),
    express.json(),
    express.urlencoded({
        extended: true
    }),
    cors()
)

app.get('^/$|/pricechecker', (req, res) => {
    res.status(200).sendFile(path.resolve('./static/html/index.html'))
})

app.use('/checkers', storeController)

app.get('*', (req, res) => {
    res.json({
        status: 404,
        msg: 'Resource not found'
    })
})

app.listen(port, () => {
    console.log(`Server is running on ${port}`);
})