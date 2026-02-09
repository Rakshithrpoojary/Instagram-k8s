const mongoose = require('mongoose');

const connectDatabase = () => {
    console.log("MONGO",process.env.MONGO_URI);
    mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
        console.log("Mongoose Connected");
    }).catch((error) => {
        console.log(error);
    });
}

module.exports = connectDatabase;