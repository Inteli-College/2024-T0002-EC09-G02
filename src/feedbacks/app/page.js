'use client'

import React, { useState, useEffect } from 'react';
import axios from 'axios'; // Assuming you're using axios for HTTP requests

// Comment component
const Comment = ({ message, region, likes }) => {
  return (
   <div className='bg-gray-800 p-4 rounded-md mb-4 border-black border-2'>
    {message}
    </div>
  );
};

const AddComment = () => {
  return (
    <div>
      <input type="textarea" placeholder="Enter message" />
      <button>Postar</button>
    </div>
  );
};


// ListOfComments component
const ListOfComments = () => {
  const [comments, setComments] = useState([]);
  const [showForm, setShowForm] = useState(false);
  const [newComment, setNewComment] = useState({ comment: '', region: '', likes: 0});

  useEffect(() => {
    const fetchComments = async () => {
      try {
        const response = await axios.get('/comments'); // Assuming this endpoint fetches comments from MongoDB
        setComments(response.data.message || []); // Ensure that response.data is an array, if not, default to empty array
      } catch (error) {
        console.error('Error fetching comments:', error);
      }
    };

    fetchComments();
  }, []);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setNewComment((prevComment) => ({
      ...prevComment,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      console.log('newComment', newComment);
      await axios.post('/comments', JSON.stringify(newComment), {
        headers: {
          'Content-Type': 'application/json'
        }
      }); 
      setNewComment({ message: '', region: '' });
      setShowForm(false);
    } catch (error) {
      console.error('Error adding comment:', error);
    }
  };

  return (
    <div className="flex flex-col w-full bg-transparent">
      <h1 className="font-semibold text-3xl">O que a cidade pensa...</h1>
      <button
        className="bg-white text-black font-semibold py-2 px-4 rounded-full mb-4 absolute right-4 top-4"
        onClick={() => setShowForm(!showForm)}
      >
        {showForm ? 'Close Form' : 'Add Comment'}
      </button>
      {showForm && (
        <form onSubmit={handleSubmit} className="mb-4">
          <div className="flex flex-col space-y-2">
            <input
              type="text"
              name="comment"
              value={newComment.message}
              onChange={handleInputChange}
              placeholder="Enter message"
              className="border border-gray-300 rounded-md p-2"
            />
            <input
              type="text"
              name="region"
              value={newComment.region}
              onChange={handleInputChange}
              placeholder="Enter region"
              className="border border-gray-300 rounded-md p-2"
            />
            <button
              type="submit"
              className="bg-green-500 text-white font-semibold py-2 px-4 rounded-full"
            >
              Submit
            </button>
          </div>
        </form>
      )}
      {comments.map((comment, index) => (

        <Comment
          key={index}
          message={comment.comment}
          region={comment.region}
          likes={comment.likes}
        />
      ))}
      
    </div>
  );
};

export default ListOfComments;
