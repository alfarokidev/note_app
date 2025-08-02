import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/user.dart';
import '../../domain/providers/auth_domain_providers.dart';

part 'auth_notifier.g.dart';

@riverpod
Stream<firebase_auth.User?> authStateChanges(Ref ref) {
  return firebase_auth.FirebaseAuth.instance.authStateChanges();
}

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User?> build() async {
    final authUser = ref.watch(authStateChangesProvider).value;
    if (authUser != null) {
      return User(
        id: authUser.uid,
        email: authUser.email ?? '',
        displayName: authUser.displayName ?? '',
      );
    }
    return null;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();

    final useCase = ref.read(signInWithGoogleProvider);
    final result = await useCase();

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    final useCase = ref.read(signOutProvider);
    final result = await useCase();

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(signInWithEmailProvider);
    final result = await useCase(email, password);

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  Future<void> registerWithEmail(String email, String password) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(registerWithEmailProvider);
    final result = await useCase(email, password);

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }
}
