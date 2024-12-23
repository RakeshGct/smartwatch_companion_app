import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = '';
  int _age = 0;
  String _gender = '';

  String get name => _name;
  int get age => _age;
  String get gender => _gender;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loadProfile(String userId) async {
    try {
      DocumentSnapshot doc =
      await _firestore.collection('profiles').doc(userId).get();
      if (doc.exists) {
        _name = doc['name'] ?? '';
        _age = doc['age'] ?? 0;
        _gender = doc['gender'] ?? '';
        notifyListeners();
      }
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  Future<void> saveProfile(String userId, String name, int age, String gender) async {
    try {
      await _firestore.collection('profiles').doc(userId).set({
        'name': name,
        'age': age,
        'gender': gender,
      });
      _name = name;
      _age = age;
      _gender = gender;
      notifyListeners();
    } catch (e) {
      print('Error saving profile: $e');
    }
  }
}
