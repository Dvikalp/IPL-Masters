const express=require("express");
const mongoose=require("mongoose");
const authRouter=require("./routes/auth");
const PORT=3000;
const app=express();
app.use(express.json());
app.use(authRouter);

mongoose.connect("mongodb+srv://vikalp:PASSWORD@cluster0.0i6kqi6.mongodb.net/?retryWrites=true&w=majority").then(()=>{
console.log("Connection Successful");
});

app.listen(PORT,"0.0.0.0",()=>{
console.log(`Connected at port ${PORT}`);
});
