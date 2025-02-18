import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _fire = FirebaseFirestore.instance;

  Future<void> create(Map<String, dynamic> data) async {
    try {
      await _fire.collection("users").add(data);
      log("User created successfully");
    } catch (e) {
      log("Error creating user: $e");
    }
  }

  Future<List<Map<String, dynamic>>> readUsersByName(String name) async {
    try {
      QuerySnapshot snapshot =
          await _fire.collection("users").where("name", isEqualTo: name).get();

      List<Map<String, dynamic>> users = snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      log("User read successfully");
      return users;
    } catch (e) {
      log("Error reading users: $e");
      return [];
    }
  }

  Future<void> updateUsersByName(
      String name, Map<String, dynamic> updatedData) async {
    try {
      QuerySnapshot snapshot =
          await _fire.collection("users").where("name", isEqualTo: name).get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          await _fire.collection("users").doc(doc.id).update(updatedData);
        }
        log("User updated successfully");
      }
    } catch (e) {
      log("Error updating user: $e");
    }
  }

  Future<void> deleteUsersByName(String name) async {
    try {
      QuerySnapshot snapshot =
          await _fire.collection("users").where("name", isEqualTo: name).get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          await _fire.collection("users").doc(doc.id).delete();
        }
        log("Deleted all users with name: $name");
      }
    } catch (e) {
      log("Error deleting users: $e");
    }
  }
}
