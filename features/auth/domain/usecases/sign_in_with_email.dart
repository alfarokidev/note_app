import 'package:either_dart/either.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failures.dart';

class SignInWithEmail {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  Future<Either<Failure, User?>> call(String email, String password) async {
    return await repository.signInWithEmailPassword(email, password);
  }
}