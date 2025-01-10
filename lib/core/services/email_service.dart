// lib/core/services/email_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/firebase_config.dart';

class EmailService {
  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;

  EmailService()
      : _functions = FirebaseFunctions.instance,
        _firestore = FirebaseFirestore.instance;

  Future<void> sendEmail({
    required String name,
    required String email,
    required String phone,
    required String message,
    required String purpose,
  }) async {
    try {
      // Create the email data
      final emailData = {
        'name': name,
        'email': email,
        'phone': phone,
        'message': message,
        'purpose': purpose,
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Call the Cloud Function
      final HttpsCallable callable = _functions.httpsCallable('sendEmail');
      final result = await callable.call(emailData);

      // Log the email in Firestore
      await _logEmail(emailData, result.data['messageId']);

    } catch (e) {
      // Log the error and rethrow
      await _logError(e.toString());
      throw EmailServiceException('Failed to send email: ${e.toString()}');
    }
  }

  Future<void> _logEmail(Map<String, dynamic> emailData, String messageId) async {
    try {
      await _firestore.collection('email_logs').add({
        ...emailData,
        'messageId': messageId,
        'status': 'sent',
      });
    } catch (e) {
      // Log error but don't throw since the email was sent successfully
      print('Failed to log email: ${e.toString()}');
    }
  }

  Future<void> _logError(String error) async {
    try {
      await _firestore.collection('email_logs').add({
        'error': error,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'error',
      });
    } catch (e) {
      print('Failed to log error: ${e.toString()}');
    }
  }
}

class EmailServiceException implements Exception {
  final String message;
  EmailServiceException(this.message);

  @override
  String toString() => message;
}