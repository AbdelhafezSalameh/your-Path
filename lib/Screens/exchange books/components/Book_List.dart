import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_uni_services2/Screens/exchange%20books/components/Book%20Upload.dart';
import 'package:student_uni_services2/components/custom_alerts.dart';
import 'package:student_uni_services2/generated/l10n.dart';
import 'package:student_uni_services2/size_config.dart';

class BookListScreen extends StatefulWidget {
  static String routeName = "/BookList";

  const BookListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Exchange',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF297C74),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(20),
                  right: getProportionateScreenWidth(10),
                  left: getProportionateScreenWidth(10),
                ),
                child: SizedBox(
                  height: getProportionateScreenWidth(50),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search By Book Name",
                      floatingLabelStyle: const TextStyle(
                        color: Color(0xFF297C74),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF297C74),
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: getProportionateScreenWidth(375.0),
                  height: getProportionateScreenHeight(685),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('books')
                        .where('isApproved', isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No books available.'));
                      } else {
                        List<DocumentSnapshot> books = snapshot.data!.docs;
                        String query =
                            searchController.text.trim().toLowerCase();

                        List<DocumentSnapshot> filteredBooks = query.isEmpty
                            ? books
                            : books.where((book) {
                                String title = (book['title'] ?? '')
                                    .toString()
                                    .toLowerCase();
                                return title.contains(query);
                              }).toList();

                        return ListView.builder(
                          itemCount: filteredBooks.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot book = filteredBooks[index];
                            String title = book['title'];
                            String category = book['category'];
                            String imageUrl = book['imageUrl'];
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomConfirmationAlert(
                                    title:
                                        "Are you sure you want to reserve the book?",
                                    bookName: title,
                                    location: category,
                                    onCancel: () {
                                      Navigator.of(context).pop();
                                    },
                                    onConfirm: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                margin: const EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Book Name: $title',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(10),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            category,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          // Add any other fixed content here if needed
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(10),
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(200),
                                        width: getProportionateScreenWidth(355),
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                        ),
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
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: FloatingActionButton.extended(
                backgroundColor: const Color(0xFF297C74),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookUploadScreen(),
                    ),
                  );
                },
                label: Text(
                  S.of(context).exchange_book_button,
                  style: const TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.add, color: Colors.white, size: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
