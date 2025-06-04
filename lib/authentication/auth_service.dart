import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> signInWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    
    // Get user document
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(result.user?.uid).get();
    
    if (!userDoc.exists) {
      throw Exception('User document not found');
    }
    
    // Update last login time
    await _firestore.collection('users').doc(result.user?.uid).update({
      'lastLogin': FieldValue.serverTimestamp(),
    });
    
    return {
      'user': result.user,
      'role': userDoc['role'],
      'name': userDoc['name'],
    };
  } catch (e) {
    if (kDebugMode) {
      print("Error signing in: $e");
    }
    rethrow;
  }
}

  Future<Map<String, dynamic>?> registerWithEmailAndPassword(
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

    // ... (rest of your user data setup)

    await _firestore.collection('users').doc(result.user?.uid).set(userData);
    
    return {
      'user': result.user,
      'role': role,
      'name': name,
    };
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

  
  Future<void> signOut() async => await _auth.signOut();
  User? getCurrentUser() => _auth.currentUser;
  
  Future<bool> checkEmailExists(String email) async {
    try {
      // ignore: deprecated_member_use
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