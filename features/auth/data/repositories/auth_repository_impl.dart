import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User?>> signInWithGoogle() async {
    try {
      final firebaseUser = await remoteDataSource.signInWithGoogle();
      if (firebaseUser == null) return const Right(null);
      
      final user = _mapFirebaseUserToUser(firebaseUser);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  User? getCurrentUser() {
    final firebaseUser = remoteDataSource.getCurrentUser();
    return firebaseUser != null ? _mapFirebaseUserToUser(firebaseUser) : null;
  }

  @override
  Future<Either<Failure, User?>> signInWithEmailPassword(String email, String password) async {
    try {
      final firebaseUser = await remoteDataSource.signInWithEmailPassword(email, password);
      if (firebaseUser == null) return const Right(null);
      
      final user = _mapFirebaseUserToUser(firebaseUser);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> registerWithEmailPassword(String email, String password) async {
    try {
      final firebaseUser = await remoteDataSource.registerWithEmailPassword(email, password);
      if (firebaseUser == null) return const Right(null);
      
      final user = _mapFirebaseUserToUser(firebaseUser);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<User?> get authStateChanges {
    return remoteDataSource.authStateChanges.map((firebaseUser) {
      return firebaseUser != null ? _mapFirebaseUserToUser(firebaseUser) : null;
    });
  }

  User _mapFirebaseUserToUser(firebase_auth.User firebaseUser) {
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? '',
      photoUrl: firebaseUser.photoURL,
    );
  }
}