import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '../datasources/auth_remote_datasource.dart';
import '../repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_data_providers.g.dart';

@riverpod
GoogleSignIn googleSignIn(Ref ref) {
  // For web, Google Sign-In is supported
  if (kIsWeb) {
    return GoogleSignIn(
      clientId:
          '222545266285-k6iu4ta3npjmb7ugudfjmobftt29o5fk.apps.googleusercontent.com',
    );
  }

  // For mobile platforms
  return GoogleSignIn();
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: ref.read(googleSignInProvider),
  );
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
  );
}
