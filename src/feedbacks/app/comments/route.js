// pages/api/comments.js
import { MongoClient } from 'mongodb';

export async function GET(request) {
    const uri = process.env.MONGODB_URI;
  const client = new MongoClient(uri);

  try {
    await client.connect();
    const database = client.db('comments');
    const collection = database.collection('comments');
    const comments = await collection.find({}).toArray();
    return Response.json({ message: comments });
  } catch (error) {
    console.error('Error fetching comments:', error);
    
  } finally {
    await client.close();
  }
  
}

export async function POST(request) {
    const requestBody = await request.json(); // This line reads and parses the body stream
  const uri = process.env.MONGODB_URI;
  const client = new MongoClient(uri);

  try {
    await client.connect();
    const database = client.db('comments');
    const collection = database.collection('comments');
    const result = await collection.insertOne(requestBody);
    return Response.json({ message: result });
  } catch (error) {
    console.error('Error inserting comment:', error);
  } finally {
    await client.close();
  }
}

