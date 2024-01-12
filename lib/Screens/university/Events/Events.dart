import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsScreen extends StatefulWidget {
  static String routeName = "/Events";

  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // @override
  // void initState() {
  //   super.initState();

  //   final AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('abd4');

  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     android: initializationSettingsAndroid,
  //   );

  //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     String title = message.notification?.title ?? "No Title";

  //     String body = message.notification?.body ?? "No Body";
  //     showNotification(title, body);
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     String title = message.notification?.title ?? "No Title";
  //     String body = message.notification?.body ?? "No Body";
  //     showNotification(title, body);
  //   });

  //   FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
  //     print("FCM onBackgroundMessage: $message");
  //     String title = message.notification?.title ?? "No Title";
  //     String body = message.notification?.body ?? "No Body";
  //     showNotification(title, body);
  //   });
  // }

  // Future<void> yourBackgroundMessageHandler(RemoteMessage message) async {
  //   String title = message.notification?.title ?? "No Title";
  //   String body = message.notification?.body ?? "No Body";
  //   showNotification(title, body);
  // }

  // Future<void> showNotification(String title, String body) async {
  //   final AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your channel id', // Change this to your channel ID
  //     'Your channel name', // Change this to your channel name
  //     styleInformation: BigTextStyleInformation(''),
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     largeIcon:
  //         DrawableResourceAndroidBitmap('abd4'), // Add your icon name here
  //     actions: [
  //       // Define the notification action
  //       AndroidNotificationAction(
  //         'your_button_action', // Change to a unique action key
  //         'Your Button Label', // Label for the button
  //       ),
  //     ],
  //   );

  //   final NotificationDetails platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //   );

  //   await flutterLocalNotificationsPlugin.show(
  //     0, // Notification ID
  //     title, // Notification title
  //     body, // Notification body
  //     platformChannelSpecifics,
  //     payload: 'payload', // Add a payload if needed
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Events').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No events available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot event = snapshot.data!.docs[index];
                String title = event['title'];
                String description = event['description'];
                Timestamp date = event['date'];
                String imageUrl = event['image'];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Date: ${date.toDate().toString()}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Image.network(
                          imageUrl,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
