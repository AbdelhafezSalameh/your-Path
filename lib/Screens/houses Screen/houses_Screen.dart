import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_uni_services2/Screens/houses%20Screen/map_screen.dart';
import 'package:student_uni_services2/generated/l10n.dart';
import 'package:student_uni_services2/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

// ... (previous imports)

class HousesScreen extends StatefulWidget {
  static String routeName = "/Houses";

  const HousesScreen({Key? key});

  @override
  State<HousesScreen> createState() => _HousesScreenState();
}

class _HousesScreenState extends State<HousesScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  final PageController _pageController = PageController();

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          S.of(context).houses_title,
          style: const TextStyle(
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
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(8)),
                  child: Column(
                    children: [
                      SizedBox(
                        width: getProportionateScreenWidth(360),
                        height: getProportionateScreenHeight(55),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search by Neighborhood',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            filterHouses(value);
                          },
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(375.0),
                        height: getProportionateScreenHeight(650),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('houses')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            var houses = snapshot.data!.docs;
                            List<Widget> houseWidgets = [];
                            for (var house in houses) {
                              var houseData =
                                  house.data() as Map<String, dynamic>;
                              bool isAvailable =
                                  houseData['isAvailable'] ?? false;

                              if (isAvailable) {
                                houseWidgets.add(
                                  InkWell(
                                    child: Card(
                                      elevation: 2,
                                      color: Colors.grey[280],
                                      margin: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenHeight(10),
                                        horizontal:
                                            getProportionateScreenWidth(5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    200),
                                            child: CarouselSlider(
                                              options: CarouselOptions(
                                                height:
                                                    getProportionateScreenHeight(
                                                        200),
                                                enlargeCenterPage: true,
                                                autoPlay: true,
                                                onPageChanged: (index, reason) {
                                                  _pageController.animateToPage(
                                                    index,
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                              ),
                                              items: (houseData['imageUrls']
                                                      as List<dynamic>)
                                                  .map((imageUrls) {
                                                return Builder(
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            getProportionateScreenWidth(
                                                                5),
                                                      ),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.grey,
                                                      ),
                                                      child: Image.network(
                                                        imageUrls,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                getProportionateScreenHeight(
                                                    10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Title: ${houseData['title']}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'Neighborhood: ${houseData['contactArea']}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'Price: \$${houseData['price']}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      _animationController?.forward();
                                      showDetailsBottomSheet(
                                          context, houseData);
                                    },
                                  ),
                                );
                              }
                            }
                            return ListView(
                              children: houseWidgets,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10),
              ),
              child: FloatingActionButton.extended(
                backgroundColor: const Color(0xFF297C74),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MapScreen(),
                    ),
                  );
                },
                label: Text(
                  S.of(context).houses_button,
                  style: const TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.location_on,
                    color: Colors.white, size: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDetailsBottomSheet(
      BuildContext context, Map<String, dynamic> houseData) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(getProportionateScreenHeight(15)),
          height:
              MediaQuery.of(context).size.height * _animationController!.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                houseData['title'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              CarouselSlider(
                options: CarouselOptions(
                  height: getProportionateScreenHeight(200),
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items:
                    (houseData['imageUrls'] as List<dynamic>).map((imageUrls) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(5)),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Image.network(
                          imageUrls,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Row(
                children: [
                  Text(
                    'Floor: ${houseData['floor']}',
                  ),
                  SizedBox(width: getProportionateScreenHeight(30)),
                  Text('Rooms: ${houseData['rooms']}'),
                  SizedBox(width: getProportionateScreenHeight(30)),
                  Text('Bathrooms: ${houseData['bathrooms']}'),
                ],
              ),
              Text('Residents: ${houseData['residents']}'),
              Text('House Number: ${houseData['houseNumber']}'),
              Text('Other Details: ${houseData['otherDetails']}'),
              Text('Contact: ${houseData['phoneNumber']}'),
              Text('Contact Area: ${houseData['contactArea']}'),
              Text('Street Name: ${houseData['streetName']}'),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (houseData['websiteLink'] != null) {
                          // ignore: deprecated_member_use
                          launch(houseData['websiteLink']);
                        }
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'To Location: ${houseData['websiteLink'] ?? 'Not available'}',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Stream<QuerySnapshot> filterHouses(String searchTerm) {
    print("Filtering houses with contactArea: $searchTerm");

    Stream<QuerySnapshot> filteredStream;

    if (searchTerm.isNotEmpty) {
      String searchTermLower = searchTerm.toLowerCase();
      String searchTermUpper =
          searchTermLower.substring(0, searchTermLower.length - 1) +
              String.fromCharCode(
                  searchTermLower.codeUnitAt(searchTermLower.length - 1) + 1);

      filteredStream = FirebaseFirestore.instance
          .collection('houses')
          .where('contactArea', isGreaterThanOrEqualTo: searchTermLower)
          .where('contactArea', isLessThan: searchTermUpper)
          .snapshots();
    } else {
      filteredStream =
          FirebaseFirestore.instance.collection('houses').snapshots();
    }

    return filteredStream;
  }
}
