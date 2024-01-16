import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_uni_services2/size_config.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static String routeName = "/Houses";

  @override
  State<MapScreen> createState() => MapSampleState();
}

class MarkerModel {
  final String name;
  final String type;
  final GeoPoint location;

  MarkerModel({
    required this.name,
    required this.type,
    required this.location,
  });

  factory MarkerModel.fromDocument(DocumentSnapshot doc) {
    return MarkerModel(
      name: doc['name'],
      type: doc['type'],
      location: doc['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'location': location,
    };
  }
}

class MapSampleState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  MapType _currentMapType = MapType.normal;

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _fetchMarkersFromFirestore();
  }

  void _addMarker() {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('new_marker'),
          position: LatLng(32.012744, 35.934970),
          infoWindow: InfoWindow(title: 'New Marker'),
        ),
      );
    });
  }

  Future<void> _fetchMarkersFromFirestore() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('markers').get();

      List<MarkerModel> markers =
          snapshot.docs.map((doc) => MarkerModel.fromDocument(doc)).toList();

      Set<Marker> newMarkers = markers
          .map(
            (marker) => Marker(
              markerId: MarkerId(marker.name),
              position: LatLng(
                marker.location.latitude,
                marker.location.longitude,
              ),
              infoWindow: InfoWindow(title: marker.name),
            ),
          )
          .toSet();

      setState(() {
        _markers = newMarkers;
      });
    } catch (e) {
      print('Error fetching markers: $e');
    }
  }

  Set<Marker> _buildMarkers() {
    return _markers;
  }

  void _changeMapType(MapType newMapType) {
    setState(() {
      _currentMapType = newMapType;
    });
  }

  Future<void> _insertMarker() async {
    try {
      MarkerModel marker = MarkerModel(
        name: 'New Marker',
        type: 'custom', // Specify the type as needed
        location: const GeoPoint(32.07554411824923,
            36.05321784208915), // Specify the latitude and longitude
      );

      await FirebaseFirestore.instance
          .collection('markers')
          .add(marker.toMap());

      print('Marker added successfully!');
      _fetchMarkersFromFirestore(); // Refresh markers after adding a new one
    } catch (e) {
      print('Error adding marker: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: _currentMapType,
        initialCameraPosition: const CameraPosition(
          target: LatLng(31.936253047971206, 35.91942764432493),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _buildMarkers(),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(10),
            horizontal: getProportionateScreenWidth(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // FloatingActionButton(
            //   onPressed: () {
            //     _addMarker();
            //     _insertMarker();
            //   },
            //   child: const Icon(Icons.add),
            // ),
            const SizedBox(height: 16.0),
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
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MapScreen(),
  ));
}
