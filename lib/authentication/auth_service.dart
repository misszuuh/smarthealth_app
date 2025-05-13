import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
          
      // Update last login time
      await _firestore.collection('users').doc(result.user?.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });
      
      return result.user;
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in: $e");
      }
      rethrow;
    }
  }

  // Register with email and password - now with explicit role selection
  Future<User?> registerWithEmailAndPassword(
      String email, String password, String name,
      {required String role}) async {
    try {
      // Validate role
      if (role != 'patient' && role != 'doctor') {
        throw Exception('Invalid user role');
      }

      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          
      // Create user document with role-specific data
      Map<String, dynamic> userData = {
        'uid': result.user?.uid,
        'email': email,
        'name': name,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      };

      // Add role-specific fields
      if (role == 'doctor') {
        userData.addAll({
          'specialization': 'General Practitioner', // Default value
          'licenseNumber': '',
          'verified': false,
        });
      } else {
        userData.addAll({
          'age': 0,
          'bloodType': '',
          'emergencyContact': '',
        });
      }

      await _firestore.collection('users').doc(result.user?.uid).set(userData);
      
      return result.user;
    } catch (e) {
      if (kDebugMode) {
        print("Error registering: $e");
      }
      rethrow;
    }
  }

  // Get current user with complete data
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      return await getUserData(user.uid);
    }
    return null;
  }

  // Get user data with role-specific typing
  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      throw Exception('User document not found');
    } catch (e) {
      if (kDebugMode) {
        print("Error getting user data: $e");
      }
      rethrow;
    }
  }

  // Other methods remain the same...
  Future<void> signOut() async => await _auth.signOut();
  User? getCurrentUser() => _auth.currentUser;
  
  Future<bool> checkEmailExists(String email) async {
    try {
      final methods = await _auth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      if (kDebugMode) {
        print("Error checking email: $e");
      }
      return false;
    }
  }
}