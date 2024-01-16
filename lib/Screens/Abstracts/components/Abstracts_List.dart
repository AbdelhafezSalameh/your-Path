import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Firebase/FireBase_Storge.dart';
import 'package:student_uni_services2/Screens/Abstracts/components/abstract_tabBar.dart';
import 'package:student_uni_services2/Screens/Abstracts/components/custom_abstract_button_sheet.dart';
import 'package:student_uni_services2/generated/l10n.dart';
import 'package:student_uni_services2/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class AbstractListScreen extends StatefulWidget {
  static String routeName = "/AbstractList";

  const AbstractListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AbstractListScreenState createState() => _AbstractListScreenState();
}

class _AbstractListScreenState extends State<AbstractListScreen> {
  // ignore: unused_field
  final FirebaseStorageService _storageService = FirebaseStorageService();
  late TextEditingController _searchController;
  // ignore: unused_field
  late String _selectedWalletType;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedWalletType = walletTypes.isNotEmpty ? 'Orange Money' : '';
  }

  List<SummaryInfo> _filterSummaries(
      List<SummaryInfo> summaries, String search) {
    return summaries
        .where((summary) =>
            summary.title.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  Future<void> _launchSummary(
      BuildContext context, SummaryInfo summaryInfo) async {
    if (double.parse(summaryInfo.price) > 0) {
      await _showDownloadBottomSheet(context, summaryInfo);
    } else {
      await _proceedWithDownload(summaryInfo.url, "", "");
    }
  }

  Future<void> _showDownloadBottomSheet(
      BuildContext context, SummaryInfo summaryInfo) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CustomAbstractsBottomSheet(
          title: summaryInfo.title,
          url: summaryInfo.url,
          price: summaryInfo.price,
          description: summaryInfo.description,
          phoneNumber: summaryInfo.phoneNumber,
          walletType: summaryInfo.walletType,
          onProceedWithDownload: (String phoneNumber, String walletType) {
            Navigator.of(context).pop();
            _proceedWithDownload(summaryInfo.url, phoneNumber, walletType);
          },
        );
      },
    );
  }

  Future<void> _proceedWithDownload(
      String url, String phoneNumber, String walletType) async {
    try {
      // ignore: deprecated_member_use
      await launch(url);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Summary downloaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading summary: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Abstracts',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF297C74),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search By Material Name",
                      floatingLabelStyle: const TextStyle(
                        color: Color(0xFF297C74),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
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
                  width: width,
                  height: height,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('summaries')
                        .where('userId', isEqualTo: 'exampleUserId')
                        .where('isApproved', isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        List<SummaryInfo> summaries =
                            snapshot.data!.docs.map((DocumentSnapshot doc) {
                          Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                          return SummaryInfo(
                            title: data['title'] ?? 'Example Title',
                            college: data['college'] ?? 'Example College',
                            filename:
                                _extractFilenameFromUrl(data['downloadUrl']),
                            price: data['price'] ?? '0',
                            url: data['downloadUrl'],
                            description: data['description'] ?? '07',
                            walletType: data['WalletType'] ?? 'Description',
                            phoneNumber: data['phoneNumber'] ?? 'Wallet',
                          );
                        }).toList();

                        String search = _searchController.text.trim();
                        List<SummaryInfo> filteredSummaries =
                            _filterSummaries(summaries, search);

                        if (filteredSummaries.isEmpty) {
                          return Center(
                            child: Text(
                              S.of(context).university_upload_abstracts_null,
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: filteredSummaries.length,
                          itemBuilder: (context, index) {
                            SummaryInfo summaryInfo = filteredSummaries[index];
                            Color? cardColor = index % 2 == 0
                                ? Colors.white
                                : Colors.grey[200];

                            return ListTile(
                              title: Text(summaryInfo.title),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(summaryInfo.college),
                                  Text('Price: ${summaryInfo.price} JD'),
                                ],
                              ),
                              tileColor: cardColor,
                              onTap: () => _launchSummary(context, summaryInfo),
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
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(20)),
              child: FloatingActionButton.extended(
                backgroundColor: const Color(0xFF297C74),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SummaryTabBar(),
                    ),
                  );
                },
                label: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.add, color: Colors.white, size: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _extractFilenameFromUrl(String url) {
    return Uri.parse(url).pathSegments.last;
  }
}

class SummaryInfo {
  final String title;
  final String college;
  final String filename;
  final String url;
  final String price;
  final String description;
  final String phoneNumber;
  final String walletType;

  SummaryInfo({
    required this.title,
    required this.college,
    required this.filename,
    required this.url,
    required this.price,
    required this.description,
    required this.walletType,
    required this.phoneNumber,
  });
}

const List<String> walletTypes = ['Orange Money', 'Zain Cash', 'Umniah Wallet'];
