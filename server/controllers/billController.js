const express = require("express");
var router = express.Router();
var ObjectId = require("mongoose").Types.ObjectId;

var { Bill } = require("../models/bill");

router.get("/", (req, res) => {
    Bill.find((err, docs) => {
        if (!err) {
        res.send(docs);
        } else {
        console.log(
            "Error in Retriving Bills :" + JSON.stringify(err, undefined, 2)
        );
        }
    });
});

router.post("/", (req, res) => {
    var bill = new Bill({
        name: req.body.name,
        productID: req.body.productID,
        price: req.body.price,
        category: req.body.category,
        discount: req.body.discount,
        bonus: req.body.bonus,
        billablePrice: req.body.billablePrice,
    });

    bill.save((err, doc) => {
        if (!err) {
        res.send(doc);
        } else {
        console.log("Error in saving bill: " + JSON.stringify(err, undefined, 2));
        }
    })
});



module.exports = router;