import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/Abstracts/components/Upload_Summary_Screen.dart';
import 'package:student_uni_services2/Screens/Abstracts/components/upload_paid_summary.dart';

class SummaryTabBar extends StatelessWidget {
  const SummaryTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Upload Abstracts',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF297C74),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Upload Free Abstract',
              ),
              Tab(text: 'Upload Paid Abstract'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UploadSummaryScreen(),
            UploadPaidSummaryScreen(),
          ],
        ),
      ),
    );
  }
}
