const mongoose = require("mongoose");

var bill = mongoose.model("Bill", {
  name: { type: String },
  productID: { type: String },
  price: { type: Number },
  category: { type: String },
  discount: { type: Number },
  bonus: { type: Number },
  billablePrice: { type: Number },
});

module.exports = { Bill: bill };
