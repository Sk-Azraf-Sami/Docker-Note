import express from 'express'; 
import dotenv from 'dotenv';
dotenv.config();

const app = express(); 

const port = process.env.PORT || 5000; 

app.get("/", (req,res)=>{
    res.send("<h2>Hi There!</h2>")
})

app.listen(port, ()=>{
    console.log(`listening on port ${port}`);  
})