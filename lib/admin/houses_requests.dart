import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Firebase/FireBase_Storge.dart';
import 'package:student_uni_services2/size_config.dart';

class HousesRequests extends StatefulWidget {
  const HousesRequests({super.key});

  @override
  State<HousesRequests> createState() => _HousesRequestsState();
}

class _HousesRequestsState extends State<HousesRequests> {
  final FirebaseStorageService storageService = FirebaseStorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: getProportionateScreenHeight(10)),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('houses').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DocumentSnapshot> houses = snapshot.data!.docs;
              if (houses.isEmpty) {
                return const Center(
                  child: Text(
                    'No houses available.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
              return ListView.builder(
                itemCount: houses.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      houses[index].data() as Map<String, dynamic>;
                  bool isAvailable = data['isAvailable'] ?? false;

                  return GestureDetector(
                    onLongPress: () {
                      _showDeleteDialog(context, houses[index].id);
                    },
                    child: Card(
                      elevation: 12,
                      margin: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(15),
                          horizontal: getProportionateScreenWidth(10)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: isAvailable ? Colors.green[100] : Colors.red[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            child: FutureBuilder(
                              future: storageService
                                  .fetchHouseImage(data['imageUrls']),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return const Icon(Icons.error);
                                } else {
                                  List<String> imageUrls =
                                      // ignore: unnecessary_cast
                                      (snapshot.data ?? []) as List<String>;

                                  if (imageUrls.isEmpty) {
                                    return const Text('No Image');
                                  } else {
                                    return SizedBox(
                                      height: getProportionateScreenHeight(200),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imageUrls.length,
                                        itemBuilder: (context, index) {
                                          return Image.network(
                                            imageUrls[index],
                                            width: getProportionateScreenWidth(
                                                360),
                                            fit: BoxFit.fill,
                                          );
                                        },
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(data['title'] ?? 'Untitled'),
                            subtitle: Text(data['area'] ?? ''),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(10),
                              horizontal: getProportionateScreenWidth(20),
                            ), // ما بين الكبسة والكارد
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('houses')
                                          .doc(houses[index].id)
                                          .update({'isAvailable': true});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF297C74),
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: const Text("Accept",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(35),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('houses')
                                          .doc(houses[index].id)
                                          .update({'isAvailable': false});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[300],
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: Text('Decline',
                                        style:
                                            TextStyle(color: Colors.grey[300])),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(35),
                                ),
                              ],
                            ),
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
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String? documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete House"),
          content: const Text("Are you sure you want to delete this house?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Color(0xFF297C74), fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                _deleteHouse(documentId);
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              child: const Text("Delete",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _deleteHouse(String? documentId) {
    FirebaseFirestore.instance.collection('houses').doc(documentId).delete();
  }
}
