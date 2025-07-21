import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user_input.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // สร้าง User Input
  Future<String> createUserInput(
    String description,
    String? imageUrl,
  ) async {
    try {
      final userInput = UserInput(
        id: '',
        imageUrl: imageUrl,
        description: description,
        createdDate: DateTime.now(),
        status: 'pending',
      );

      final docRef = await _firestore
          .collection('user_inputs')
          .add(userInput.toFirestore());

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create user input: $e');
    }
  }

  
  Future<List<UserInput>> getAllUserInputs() async {
    try {
      final querySnapshot = await _firestore
          .collection('user_inputs')
          .orderBy('createdDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => UserInput.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get user inputs: $e');
    }
  }

  // อัพโหลดรูปภาพ
  Future<String> uploadUserImage(String inputId, String filePath) async {
    try {
      final ref = _storage
          .ref()
          .child('user_uploads')
          .child('$inputId.jpg');
      final uploadTask = await ref.putFile(File(filePath));
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
