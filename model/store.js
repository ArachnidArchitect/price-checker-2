import { connection as db } from "../config/config";


class Stores{

    static async getStore(req, res) {
        try {
            const query = `SELECT * FROM ${req.params.store}`
            db.query(query, function(err, result) {
                if (err) throw err;
                res.json({
                    status: 200,
                    result
                });
            });
        } catch (error) {
            res.json({
                status: error.statusCode,
                error: error.message
            })
        }
    }

    
}