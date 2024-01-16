// FirebaseStorageService.dart
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> uploadProfileImage(File file, String userId) async {
    try {
      final Reference storageReference =
          _storage.ref().child('profile_images/$userId/${DateTime.now()}.jpg');

      final UploadTask uploadTask = storageReference.putFile(file);

      final TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Store profile image URL in Firestore
      await _firestore.collection('users').doc(userId).update({
        'profileImage': downloadUrl,
      });

      return downloadUrl;
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading profile image: $e');
      return null;
    }
  }

  Future<String?> fetchProfileImage(String userId) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        return snapshot.get('profileImage');
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching profile image: $e');
      return null;
    }
  }

  Future<String?> uploadHouseImage(File file, String userId) async {
    try {
      final Reference storageReference =
          _storage.ref().child('house_images/$userId/${DateTime.now()}.jpg');

      final UploadTask uploadTask = storageReference.putFile(file);

      final TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading house image: $e');
      return null;
    }
  }

  Future<List<String>> fetchHouseImage(dynamic imageUrls) async {
    try {
      if (imageUrls == null) {
        return [];
      }

      if (imageUrls is List) {
        return List<String>.from(imageUrls);
      } else if (imageUrls is String) {
        return [imageUrls];
      } else {
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching house image: $e');
      return [];
    }
  }

  Future<String?> uploadAdsImage(File file, String userId) async {
    try {
      final Reference storageReference =
          _storage.ref().child('ads_images/$userId/${DateTime.now()}.jpg');

      final UploadTask uploadTask = storageReference.putFile(file);

      final TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading house image: $e');
      return null;
    }
  }

  Future<List<String>> fetchAdsImage(dynamic imageUrls) async {
    try {
      if (imageUrls == null) {
        return [];
      }

      if (imageUrls is List) {
        return List<String>.from(imageUrls);
      } else if (imageUrls is String) {
        return [imageUrls];
      } else {
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching house image: $e');
      return [];
    }
  }

  Future<String?> uploadSummary(
    File file,
    String userId, {
    required String title,
    required String description,
    required String college,
    bool isApproved = false,
  }) async {
    try {
      final Reference storageReference =
          _storage.ref().child('summaries/$userId/${DateTime.now()}.pdf');

      final UploadTask uploadTask = storageReference.putFile(file);

      final TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await _firestore.collection('summaries').add({
        'userId': userId,
        'title': title,
        'description': description,
        'college': college,
        'downloadUrl': downloadUrl,
        'isApproved': isApproved,
      });

      return downloadUrl;
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading summary: $e');
      return null;
    }
  }

  Future<List<String>> fetchSummaries(String userId) async {
    try {
      final ListResult result =
          await _storage.ref().child('summaries/$userId/').listAll();

      List<String> downloadUrls = [];
      for (final item in result.items) {
        final String downloadUrl = await item.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }

      return downloadUrls;
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching summaries: $e');
      return [];
    }
  }

  Future<String?> uploadPaidSummary(
    File file,
    String userId, {
    required String title,
    required String description,
    required String college,
    bool isApproved = false,
    // ignore: non_constant_identifier_names
    required String WalletType,
    required String phoneNumber,
    required String price,
  }) async {
    try {
      final Reference storageReference =
          _storage.ref().child('summaries/$userId/${DateTime.now()}.pdf');

      final UploadTask uploadTask = storageReference.putFile(file);

      final TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await _firestore.collection('summaries').add({
        'userId': userId,
        'title': title,
        'description': description,
        'college': college,
        'WalletType': WalletType,
        'phoneNumber': phoneNumber,
        'price': price,
        'downloadUrl': downloadUrl,
        'isApproved': isApproved,
        'timestamp': FieldValue.serverTimestamp(),
      });

      return downloadUrl;
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading summary: $e');
      return null;
    }
  }

  Future<List<String>> fetchPaidSummaries(String userId) async {
    try {
      final ListResult result =
          await _storage.ref().child('summaries/$userId/').listAll();

      List<String> downloadUrls = [];
      for (final item in result.items) {
        final String downloadUrl = await item.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }

      return downloadUrls;
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching summaries: $e');
      return [];
    }
  }
}
