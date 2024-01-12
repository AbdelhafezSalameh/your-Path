const express = require('express');
const admin = require('firebase-admin');
const bodyParser = require('body-parser');

// Initialize Firebase Admin SDK
const serviceAccount = require('C:/Users/abdel/OneDrive/Desktop/final project/Last/student_uni_services2/aaaaa-eafec-firebase-adminsdk-7n7p5-b7642b13f3.json'); // Update with the correct path to your service account key directory
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://aaaaa-eafec-default-rtdb.firebaseio.com/',
});

const app = express();
const port = 3000;  // Replace with your desired port
app.use(bodyParser.json());

// Define an endpoint for sending notifications
app.post('/send-notification', (req, res) => {
  console.log('Notification request received.'); // Log when a notification request is received

  const { driverFCMToken, userMessage } = req.body;

  if (!driverFCMToken) {
    res.status(400).json({ error: 'Driver FCM token is missing' });
    return;
  }
const driverToken = 'dXmwGGnrQIeApAlVGC_s-h:APA91bEa13iMFwdEL3ciJ2FSKv_uRkfUYOu8P0BNREUC2Lzo1eaOxf_FZynBxqMc5_ZaPmphef4mY2v0ztKOXvYbRueCiflEINr3US8HJn4_ByjtZPMzw7BGgCfi88CZ2LS6AyMREpMg'; // Replace with the actual driver's FCM token
                    
  // Send the notification using FCM

  const message = {
    data: {
      title: 'User Notification',
      body: userMessage,
    },
    token: driverToken,
  };

  admin.messaging().send(message)
    .then((response) => {
      console.log('Notification sent:', response);
      res.status(200).json({ message: 'Notification sent successfully' });
    })
    .catch((error) => {
      console.error('Error sending notification:', error);
      res.status(500).json({ error: 'Notification sending failed' });
    });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});