import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetella/core/error/firebase_exception.dart';

class ExceptionHandler {
  static void handle(dynamic e) {
    // Firebase Auth
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-credential':
          throw InvalidEmailOrPasswordException('Invalid email or password');
        case 'invalid-email':
          throw InvalidEmailException('Invalid email');
        case 'wrong-password':
          throw WrongPasswordException('Wrong password');
        case 'user-not-found':
          throw UserNotFoundException('No user found');
        case 'weak-password':
          throw WeakPasswordException('Weak password');
        case 'email-already-in-use':
          throw EmailAlreadyInUseException('Email already used');
        case 'network-request-failed':
          throw NetworkException(
            "no internet connection , check your internet",
          );
        default:
          throw UnknownAppException(e.message ?? 'Unknown auth error');
      }
    }

    // Firestore / Firebase general
    if (e is FirebaseException) {
      switch (e.code) {
        case 'permission-denied':
          throw PermissionDeniedException('No permission to access data');
        case 'unavailable':
          throw NetworkException('No internet connection');
        default:
          throw UnknownAppException('Firebase error: ${e.toString()}');
      }
    }

    // Platform Exception
    if (e is PlatformException) {
      throw AppException('Platform error: ${e.message}');
    }

    // No Internet Connection
    if (e is SocketException) {
      throw NetworkException('No internet connection');
    }

    // Timeout
    if (e is TimeoutException) {
      throw TimeoutAppException('Operation timed out');
    }

    // Other / unknown exception
    throw UnknownAppException('Unexpected error: $e');
  }
}
