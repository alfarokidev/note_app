import 'package:either_dart/either.dart';

import '../entities/user.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User?>> signInWithGoogle();
  Future<Either<Failure, User?>> signInWithEmailPassword(String email, String password);
  Future<Either<Failure, User?>> registerWithEmailPassword(String email, String password);
  Future<Either<Failure, void>> signOut();
  User? getCurrentUser();
  Stream<User?> get authStateChanges;
}