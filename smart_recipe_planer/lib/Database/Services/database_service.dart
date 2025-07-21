import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smart_recipe_planer/Database/Models/generated_recipe.dart';

import 'dart:io';

import 'package:smart_recipe_planer/Database/Models/user_input.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // User Input Methods
  Future<String> createUserInput(String description, String? imageUrl) async {
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

  Future<void> updateUserInputStatus(String inputId, String status) async {
    try {
      await _firestore
          .collection('user_inputs')
          .doc(inputId)
          .update({'status': status});
    } catch (e) {
      throw Exception('Failed to update status: $e');
    }
  }

  Future<UserInput?> getUserInput(String inputId) async {
    try {
      final doc = await _firestore
          .collection('user_inputs')
          .doc(inputId)
          .get();

      if (doc.exists && doc.data() != null) {
        return UserInput.fromFirestore(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user input: $e');
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

  // Recipe Methods
  Future<void> saveGeneratedRecipe(GeneratedRecipe recipe) async {
    try {
      await _firestore
          .collection('generated_recipes')
          .doc(recipe.id)
          .set(recipe.toFirestore());
    } catch (e) {
      throw Exception('Failed to save recipe: $e');
    }
  }

  Future<GeneratedRecipe?> getRecipeByInputId(String inputId) async {
    try {
      final querySnapshot = await _firestore
          .collection('generated_recipes')
          .where('inputId', isEqualTo: inputId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return GeneratedRecipe.fromFirestore(doc.data(), doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get recipe: $e');
    }
  }

  Future<List<GeneratedRecipe>> getAllRecipes() async {
    try {
      final querySnapshot = await _firestore
          .collection('generated_recipes')
          .orderBy('createdDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => GeneratedRecipe.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get recipes: $e');
    }
  }

  // Image Methods
  Future<String> uploadUserImage(File imageFile, String inputId) async {
    try {
      final ref = _storage.ref().child('user_uploads').child('$inputId.jpg');
      final uploadTask = await ref.putFile(imageFile);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> deleteUserInput(String inputId) async {
    try {
      // ลบ recipe ที่เกี่ยวข้อง
      final recipes = await _firestore
          .collection('generated_recipes')
          .where('inputId', isEqualTo: inputId)
          .get();

      for (var doc in recipes.docs) {
        await doc.reference.delete();
      }

      // ลบ user input
      await _firestore.collection('user_inputs').doc(inputId).delete();

      // ลบรูปภาพ (ถ้ามี)
      try {
        await _storage.ref().child('user_uploads').child('$inputId.jpg').delete();
      } catch (e) {
        // ไม่เป็นไรถ้าลบรูปไม่ได้
      }
    } catch (e) {
      throw Exception('Failed to delete user input: $e');
    }
  }
}