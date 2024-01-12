import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_uni_services2/size_config.dart';

class CalanderScreen extends StatelessWidget {
  static String routeName = "/Calander";

  const CalanderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Calander').snapshots(),
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
                String startDate = event['startDate'];
                String endDate = event['endDate'];

                return Card(
                  elevation: 2,
                  margin: EdgeInsets.all(getProportionateScreenHeight(10)),
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(8)),
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
                        SizedBox(height: getProportionateScreenHeight(8)),
                        Text(
                          'Start Date: $startDate',
                          style: const TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        Text(
                          'End Date: $endDate',
                          style: const TextStyle(fontSize: 16),
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
