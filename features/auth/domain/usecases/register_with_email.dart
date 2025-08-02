import 'package:either_dart/either.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failures.dart';

class RegisterWithEmail {
  final AuthRepository repository;

  RegisterWithEmail(this.repository);

  Future<Either<Failure, User?>> call(String email, String password) async {
    return await repository.registerWithEmailPassword(email, password);
  }
}