import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/Abstracts/components/Abstracts_List.dart';
import 'package:student_uni_services2/size_config.dart';

class CustomAbstractsBottomSheet extends StatefulWidget {
  final String title;
  final String description;
  final String walletType;
  final String price;
  final String phoneNumber;

  final String url;
  final Function(String phoneNumber, String walletType) onProceedWithDownload;

  const CustomAbstractsBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.walletType,
    required this.price,
    required this.phoneNumber,
    required this.url,
    required this.onProceedWithDownload,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomAbstractsBottomSheetState createState() =>
      _CustomAbstractsBottomSheetState();
}

class _CustomAbstractsBottomSheetState extends State<CustomAbstractsBottomSheet>
    with SingleTickerProviderStateMixin {
  String phoneNumber = '';
  String selectedWalletType = walletTypes.isNotEmpty ? walletTypes[0] : '';
  bool canDownload = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenHeight(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "Description:\n${widget.description}",
                style: const TextStyle(
                  fontSize: 16,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              Divider(
                color: Colors.grey[500],
                height: 1,
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "Payment to: ${widget.phoneNumber}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "Wallet Type: ${widget.walletType}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "Price: ${widget.price}JD",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              DropdownButton<String>(
                value: selectedWalletType,
                items: walletTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedWalletType = value!;
                    updateDownloadButtonState();
                  });
                },
                hint: const Text('Select Wallet Type'),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        phoneNumber = value;
                        updateDownloadButtonState();
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              ElevatedButton(
                onPressed: canDownload
                    ? () async {
                        setState(() {
                          _isLoading = true;
                        });

                        await widget.onProceedWithDownload(
                            phoneNumber, selectedWalletType);

                        setState(() {
                          _isLoading = false;
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF297C74),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Download',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateDownloadButtonState() {
    setState(() {
      canDownload = phoneNumber.isNotEmpty && selectedWalletType.isNotEmpty;
    });
  }

  Future<void> addDownloadInformation(
      String phoneNumber, String walletType) async {
    CollectionReference downloads =
        FirebaseFirestore.instance.collection('downloads_summary_information');

    await downloads.add({
      'phoneNumber': phoneNumber,
      'walletType': walletType,
    });
  }
}
