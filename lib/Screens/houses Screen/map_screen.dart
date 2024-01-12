// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_uni_services2/size_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static String routeName = "/Houses";

  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('abd4');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.notification?.title ?? "hafez";

      String body = message.notification?.body ?? "salameh";
      showNotification(title, body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String title = message.notification?.title ?? "No Title";
      String body = message.notification?.body ?? "No Body";
      showNotification(title, body);
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      // ignore: avoid_print
      print("FCM onBackgroundMessage: $message");
      String title = message.notification?.title ?? "No Title";
      String body = message.notification?.body ?? "No Body";
      showNotification(title, body);
    });
  }

  Future<void> yourBackgroundMessageHandler(RemoteMessage message) async {
    String title = message.notification?.title ?? "No Title";
    String body = message.notification?.body ?? "No Body";
    showNotification(title, body);
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id', // Change this to your channel ID
      'Your channel name', // Change this to your channel name
      styleInformation: BigTextStyleInformation(''),
      importance: Importance.max,
      priority: Priority.high,
      largeIcon:
          DrawableResourceAndroidBitmap('abd4'), // Add your icon name here
      actions: [
        // Define the notification action
        AndroidNotificationAction(
          'your_button_action', // Change to a unique action key
          'Your Button Label', // Label for the button
        ),
      ],
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title, // Notification title
      body, // Notification body
      platformChannelSpecifics,
      payload: 'payload', // Add a payload if needed
    );
  }

  // ignore: unused_field
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(32.012744, 35.934970),
    zoom: 14.4746,
  );

  MapType _currentMapType = MapType.normal;

  final List<University> universities = [
    University(
      name: 'WISE University',
      lat: 32.012475,
      lng: 35.935505,
    ),
    University(
      name: 'University of Jordan',
      lat: 32.016107,
      lng: 35.869333,
    ),
  ];

  final List<House> houses = [
    House(name: 'House 1', lat: 32.015, lng: 35.932),
    House(name: 'House 2', lat: 32.018, lng: 35.938),
  ];

  University _selectedUniversity = University(
    name: 'University ',
    lat: 32.012744,
    lng: 35.934970,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: _currentMapType,
        initialCameraPosition: CameraPosition(
          target: LatLng(_selectedUniversity.lat, _selectedUniversity.lng),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _buildMarkers(),
      ),
      floatingActionButton: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Column(
                            children: universities
                                .map(
                                  (university) => ListTile(
                                    title: Text(university.name),
                                    onTap: () {
                                      _changeUniversity(university);
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.school),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Normal'),
                                onTap: () {
                                  _changeMapType(MapType.normal);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Satellite'),
                                onTap: () {
                                  _changeMapType(MapType.satellite);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Hybrid'),
                                onTap: () {
                                  _changeMapType(MapType.hybrid);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.layers),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    // Add markers for universities
    Set<Marker> markers = universities
        .map(
          (university) => Marker(
            markerId: MarkerId(university.name),
            position: LatLng(university.lat, university.lng),
            infoWindow: InfoWindow(title: university.name),
          ),
        )
        .toSet();

    // Add markers for houses
    markers.addAll(houses
        .map(
          (house) => Marker(
            markerId: MarkerId(house.name),
            position: LatLng(house.lat, house.lng),
            infoWindow: InfoWindow(title: house.name),
          ),
        )
        .toSet());

    return markers;
  }

  void _changeMapType(MapType newMapType) {
    setState(() {
      _currentMapType = newMapType;
    });
  }

  void _changeUniversity(University newUniversity) {
    setState(() {
      _selectedUniversity = newUniversity;
    });
    _moveToUniversity();
  }

  Future<void> _moveToUniversity() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(_selectedUniversity.lat, _selectedUniversity.lng),
        zoom: 14.4746,
      ),
    ));
  }
}

class University {
  final String name;
  final double lat;
  final double lng;

  University({
    required this.name,
    required this.lat,
    required this.lng,
  });
}

class House {
  final String name;
  final double lat;
  final double lng;

  House({
    required this.name,
    required this.lat,
    required this.lng,
  });
}

void main() {
  runApp(const MaterialApp(
    home: MapScreen(),
  ));
}
