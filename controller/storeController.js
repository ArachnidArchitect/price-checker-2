import bodyParser from 'body-parser';
import express from 'express';
import { Stores } from '../model/store.js';

const storeController = express();

// Middleware to parse JSON request bodies

storeController.use(express.json());
storeController.use(bodyParser.json());

// Endpoints

storeController.get('/:store', (req, res) => {
    Stores.getStore(req, res)
})

export{
    storeController
}
