import 'package:firebase_auth/firebase_auth.dart';

/// Base exception class
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

/// Server exception
class ServerException extends AppException {
  const ServerException({required String message}) : super(message);
}

/// Firebase Auth exceptions
class AuthException extends AppException {
  final String code;
  const AuthException({required this.code, required String message})
    : super(message);

  factory AuthException.fromFirebaseAuth(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return const AuthException(
          code: 'user-not-found',
          message: 'No user found with this email',
        );
      case 'wrong-password':
        return const AuthException(
          code: 'wrong-password',
          message: 'Incorrect password',
        );
      case 'email-already-in-use':
        return const AuthException(
          code: 'email-already-in-use',
          message: 'Email is already registered',
        );
      case 'weak-password':
        return const AuthException(
          code: 'weak-password',
          message: 'Password is too weak',
        );
      case 'invalid-email':
        return const AuthException(
          code: 'invalid-email',
          message: 'Invalid email address',
        );
      case 'user-disabled':
        return const AuthException(
          code: 'user-disabled',
          message: 'User account has been disabled',
        );
      case 'too-many-requests':
        return const AuthException(
          code: 'too-many-requests',
          message: 'Too many requests. Try again later',
        );
      case 'operation-not-allowed':
        return const AuthException(
          code: 'operation-not-allowed',
          message: 'Operation not allowed',
        );
      default:
        return AuthException(
          code: e.code,
          message: e.message ?? 'Authentication failed',
        );
    }
  }
}

/// Cloud Firestore exceptions
class FirestoreException extends AppException {
  final String code;
  const FirestoreException({required this.code, required String message})
    : super(message);

  factory FirestoreException.fromFirestore(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return const FirestoreException(
          code: 'permission-denied',
          message: 'Permission denied',
        );
      case 'not-found':
        return const FirestoreException(
          code: 'not-found',
          message: 'Document not found',
        );
      case 'already-exists':
        return const FirestoreException(
          code: 'already-exists',
          message: 'Document already exists',
        );
      case 'resource-exhausted':
        return const FirestoreException(
          code: 'resource-exhausted',
          message: 'Quota exceeded',
        );
      case 'failed-precondition':
        return const FirestoreException(
          code: 'failed-precondition',
          message: 'Operation failed precondition',
        );
      case 'aborted':
        return const FirestoreException(
          code: 'aborted',
          message: 'Operation was aborted',
        );
      case 'out-of-range':
        return const FirestoreException(
          code: 'out-of-range',
          message: 'Operation out of range',
        );
      case 'unimplemented':
        return const FirestoreException(
          code: 'unimplemented',
          message: 'Operation not implemented',
        );
      case 'internal':
        return const FirestoreException(
          code: 'internal',
          message: 'Internal server error',
        );
      case 'unavailable':
        return const FirestoreException(
          code: 'unavailable',
          message: 'Service unavailable',
        );
      case 'data-loss':
        return const FirestoreException(
          code: 'data-loss',
          message: 'Data loss occurred',
        );
      case 'unauthenticated':
        return const FirestoreException(
          code: 'unauthenticated',
          message: 'User not authenticated',
        );
      case 'invalid-argument':
        return const FirestoreException(
          code: 'invalid-argument',
          message: 'Invalid argument provided',
        );
      case 'deadline-exceeded':
        return const FirestoreException(
          code: 'deadline-exceeded',
          message: 'Operation deadline exceeded',
        );
      case 'cancelled':
        return const FirestoreException(
          code: 'cancelled',
          message: 'Operation was cancelled',
        );
      default:
        return FirestoreException(
          code: e.code,
          message: e.message ?? 'Firestore operation failed',
        );
    }
  }
}

/// Cache exception
class CacheException extends AppException {
  const CacheException({required String message}) : super(message);
}

/// Network exception
class NetworkException extends AppException {
  const NetworkException({required String message}) : super(message);
}
