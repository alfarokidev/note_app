import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<User?> signInWithGoogle();
  Future<User?> signInWithEmailPassword(String email, String password);
  Future<User?> registerWithEmailPassword(String email, String password);
  Future<void> signOut();
  User? getCurrentUser();
  Stream<User?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuth(e);
    } catch (e) {
      throw AuthException(code: 'unknown', message: e.toString());
    }
  }

  @override
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuth(e);
    } catch (e) {
      throw AuthException(code: 'unknown', message: e.toString());
    }
  }

  @override
  Future<User?> registerWithEmailPassword(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuth(e);
    } catch (e) {
      throw AuthException(code: 'unknown', message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      firebaseAuth.signOut();
    } catch (e) {
      throw AuthException(
        code: 'sign-out-failed',
        message: 'Failed to sign out',
      );
    }
  }

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
}
