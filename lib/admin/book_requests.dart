import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_uni_services2/size_config.dart';

class BookRequests extends StatefulWidget {
  const BookRequests({Key? key}) : super(key: key);

  @override
  State<BookRequests> createState() => _BookRequestsState();
}

class _BookRequestsState extends State<BookRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: getProportionateScreenHeight(10)),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('books').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            var books = snapshot.data?.docs;

            return ListView.builder(
              itemCount: books?.length ?? 0,
              itemBuilder: (context, index) {
                // ignore: unnecessary_cast
                var book = books?[index].data() as Map<String, dynamic>?;

                if (book == null && index < books!.length) {
                  return const SizedBox.shrink();
                }

                bool isApproved = book!['isApproved'] ?? false;
                String title = book['title'] ?? 'No Title';
                String category = book['category'] ?? 'No category';

                return GestureDetector(
                  onLongPress: () {
                    _showDeleteDialog(context, books?[index].id);
                  },
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(10),
                      vertical: getProportionateScreenWidth(10),
                    ),
                    color: isApproved ? Colors.green[100] : Colors.red[100],
                    child: ListTile(
                      title: Text(title),
                      subtitle: Text(category),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _updateApprovalStatus(books?[index].id, true);
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
                              _updateApprovalStatus(books?[index].id, false);
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
          },
        ),
      ),
    );
  }

  void _updateApprovalStatus(String? documentId, bool isApproved) {
    FirebaseFirestore.instance
        .collection('books')
        .doc(documentId)
        .update({'isApproved': isApproved});
  }

  void _showDeleteDialog(BuildContext context, String? documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Book"),
          content: const Text("Are you sure you want to delete this book?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Color(0xFF297C74), fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                _deleteBook(documentId);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Delete",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteBook(String? documentId) {
    FirebaseFirestore.instance.collection('books').doc(documentId).delete();
  }
}
