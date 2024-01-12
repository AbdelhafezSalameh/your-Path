import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/size_config.dart';

class AbstractsRequests extends StatefulWidget {
  const AbstractsRequests({
    super.key,
  });

  @override
  State<AbstractsRequests> createState() => _AbstractsRequestsState();
}

class _AbstractsRequestsState extends State<AbstractsRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: getProportionateScreenHeight(10)),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('summaries').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DocumentSnapshot> summaries = snapshot.data!.docs;
              if (summaries.isEmpty) {
                return const Center(
                  child: Text(
                    'No Summaries available.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
              return ListView.builder(
                itemCount: summaries.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      summaries[index].data() as Map<String, dynamic>;
                  bool isApproved = data['isApproved'] ?? false;

                  return GestureDetector(
                    onLongPress: () {
                      _showDeleteDialog(context, summaries[index].id);
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenHeight(10),
                        vertical: getProportionateScreenWidth(10),
                      ),
                      color: isApproved ? Colors.green[100] : Colors.red[100],
                      child: ListTile(
                        title: Text(data['title'] ?? 'Untitled'),
                        subtitle: Text(data['college'] ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _updateApprovalStatus(
                                    summaries[index].id, true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF297C74),
                              ),
                              child: const Text(
                                'Accept',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: getProportionateScreenWidth(10)),
                            ElevatedButton(
                              onPressed: () {
                                _updateApprovalStatus(
                                    summaries[index].id, false);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Decline',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
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

  void _updateApprovalStatus(String? documentId, bool isApproved) {
    FirebaseFirestore.instance
        .collection('summaries')
        .doc(documentId)
        .update({'isApproved': isApproved});
  }

  void _showDeleteDialog(BuildContext context, String? documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Summary"),
          content: const Text("Are you sure you want to delete this summary?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel",
                  style: TextStyle(
                      color: Color(0xFF297C74), fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                _deleteSummary(documentId);
                Navigator.of(context).pop();
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

  void _deleteSummary(String? documentId) {
    FirebaseFirestore.instance.collection('summaries').doc(documentId).delete();
  }
}
