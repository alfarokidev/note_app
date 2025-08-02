import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../usecases/sign_in_with_google.dart';
import '../usecases/sign_out.dart';
import '../usecases/sign_in_with_email.dart';
import '../usecases/register_with_email.dart';
import '../../data/providers/auth_data_providers.dart';

part 'auth_domain_providers.g.dart';

@riverpod
SignInWithGoogle signInWithGoogle(Ref ref) {
  final repository = ref.read(authRepositoryProvider);
  return SignInWithGoogle(repository);
}

@riverpod
SignOut signOut(Ref ref) {
  final repository = ref.read(authRepositoryProvider);
  return SignOut(repository);
}

@riverpod
SignInWithEmail signInWithEmail(Ref ref) {
  final repository = ref.read(authRepositoryProvider);
  return SignInWithEmail(repository);
}

@riverpod
RegisterWithEmail registerWithEmail(Ref ref) {
  final repository = ref.read(authRepositoryProvider);
  return RegisterWithEmail(repository);
}
