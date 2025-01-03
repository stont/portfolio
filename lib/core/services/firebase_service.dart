// lib/core/services/firebase_service.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/firebase_config.dart';

class FirebaseService {
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: FirebaseConfig.apiKey,
          projectId: FirebaseConfig.projectId,
          messagingSenderId: FirebaseConfig.messagingSenderId,
          appId: FirebaseConfig.appId,
        ),
      );
      print('Firebase initialized successfully');
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }

  static Future<void> saveContactMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('contact_messages').add({
        'name': name,
        'email': email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Message saved successfully');
    } catch (e) {
      print('Error saving message: $e');
      throw Exception('Failed to send message: $e');
    }
  }
}