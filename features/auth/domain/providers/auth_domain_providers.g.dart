// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_domain_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(signInWithGoogle)
const signInWithGoogleProvider = SignInWithGoogleProvider._();

final class SignInWithGoogleProvider
    extends
        $FunctionalProvider<
          SignInWithGoogle,
          SignInWithGoogle,
          SignInWithGoogle
        >
    with $Provider<SignInWithGoogle> {
  const SignInWithGoogleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInWithGoogleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInWithGoogleHash();

  @$internal
  @override
  $ProviderElement<SignInWithGoogle> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignInWithGoogle create(Ref ref) {
    return signInWithGoogle(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInWithGoogle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInWithGoogle>(value),
    );
  }
}

String _$signInWithGoogleHash() => r'4500190c034592df4c2ac0d6450a9b03a8c2fe20';

@ProviderFor(signOut)
const signOutProvider = SignOutProvider._();

final class SignOutProvider
    extends $FunctionalProvider<SignOut, SignOut, SignOut>
    with $Provider<SignOut> {
  const SignOutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signOutProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signOutHash();

  @$internal
  @override
  $ProviderElement<SignOut> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignOut create(Ref ref) {
    return signOut(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignOut value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignOut>(value),
    );
  }
}

String _$signOutHash() => r'a52e6a488ed5c2a6f8bd38d63c09293f34e30429';

@ProviderFor(signInWithEmail)
const signInWithEmailProvider = SignInWithEmailProvider._();

final class SignInWithEmailProvider
    extends
        $FunctionalProvider<SignInWithEmail, SignInWithEmail, SignInWithEmail>
    with $Provider<SignInWithEmail> {
  const SignInWithEmailProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInWithEmailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInWithEmailHash();

  @$internal
  @override
  $ProviderElement<SignInWithEmail> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignInWithEmail create(Ref ref) {
    return signInWithEmail(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInWithEmail value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInWithEmail>(value),
    );
  }
}

String _$signInWithEmailHash() => r'8befea5a6b39977d511fa492f319715df6f28cdd';

@ProviderFor(registerWithEmail)
const registerWithEmailProvider = RegisterWithEmailProvider._();

final class RegisterWithEmailProvider
    extends
        $FunctionalProvider<
          RegisterWithEmail,
          RegisterWithEmail,
          RegisterWithEmail
        >
    with $Provider<RegisterWithEmail> {
  const RegisterWithEmailProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerWithEmailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerWithEmailHash();

  @$internal
  @override
  $ProviderElement<RegisterWithEmail> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegisterWithEmail create(Ref ref) {
    return registerWithEmail(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterWithEmail value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterWithEmail>(value),
    );
  }
}

String _$registerWithEmailHash() => r'8d56b77021f6fa9f8251f390f2fc0161a769f420';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
