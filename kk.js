const admin = require('firebase-admin');
const serviceAccount = require('C:/Users/abdel/OneDrive/Desktop/final project/Last/student_uni_services2/aaaaa-eafec-firebase-adminsdk-7n7p5-b7642b13f3.json'); // Update with the correct path to your service account key directory

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  // Add other configuration options
});

const tokens = [
    'dXmwGGnrQIeApAlVGC_s-h:APA91bEa13iMFwdEL3ciJ2FSKv_uRkfUYOu8P0BNREUC2Lzo1eaOxf_FZynBxqMc5_ZaPmphef4mY2v0ztKOXvYbRueCiflEINr3US8HJn4_ByjtZPMzw7BGgCfi88CZ2LS6AyMREpMg',
    "cn5GBikuRsq8X-vqUMuB6s:APA91bERprMyB7aFw-Tzs28WhhN7h4G9jYrKOttTo8Hs_ZA81MZRqmcOPC4z7NsGXsK6mSzbs6BAhsaM4Y2d5cL68LT-QbEaBTn87VtiP_OTR90jIrm-GM3UYXXX65V38EIYGp1WQ4AX"
    //  'registrationToken2',
    // Add more tokens as needed
  ];
  
const message = {
  data: {
    title: 'New Ride Request',
    body: 'A user wants to book a ride with you.',
    // Add other necessary data
  },
  token: tokens,
};

admin.messaging().send(message)
  .then((response) => {
    console.log('Successfully sent message:', response);
  })
  .catch((error) => {
    console.log('Error sending message:', error);
  });
  // void sendNotification() async {
  //   final String serverUrl = 'http://your-server-ip-or-hostname:3000'; // Update with your server's IP or hostname
  //   final String endpoint = '/send-notification';
  
  //   final Map<String, dynamic> notificationData = {
  //     'driverFCMToken': 'cX6rGqazQYOovRA5ZfyHWs:APA91bEaaah_GpGWpD1TNY0yY5bV8r_hcTFesHYNGhhMtCzDyrNkYR30mbcru58eeu-jMI5RTXkj18V1RrKwAxBCPghsbEax8eX5CBrj5FQzPLk1Sb82LhgZF29G56qqJshANC3HJyye', // Replace with the actual driver's FCM token
  //     'userMessage': 'Your notification message here',
  //   };
  
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$serverUrl$endpoint'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(notificationData),
  //     );
  
  //     if (response.statusCode == 200) {
  //       print('Notification sent successfully');
  //     } else {
  //       print('Failed to send notification. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error sending notification: $error');
  //   }
  // }
  
  