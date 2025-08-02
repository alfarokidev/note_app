// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(firebaseFirestore)
const firebaseFirestoreProvider = FirebaseFirestoreProvider._();

final class FirebaseFirestoreProvider
    extends
        $FunctionalProvider<
          FirebaseFirestore,
          FirebaseFirestore,
          FirebaseFirestore
        >
    with $Provider<FirebaseFirestore> {
  const FirebaseFirestoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseFirestoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseFirestoreHash();

  @$internal
  @override
  $ProviderElement<FirebaseFirestore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseFirestore create(Ref ref) {
    return firebaseFirestore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFirestore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFirestore>(value),
    );
  }
}

String _$firebaseFirestoreHash() => r'963402713bf9b7cc1fb259d619d9b0184d4dcec1';

@ProviderFor(firebaseAuth)
const firebaseAuthProvider = FirebaseAuthProvider._();

final class FirebaseAuthProvider
    extends $FunctionalProvider<FirebaseAuth, FirebaseAuth, FirebaseAuth>
    with $Provider<FirebaseAuth> {
  const FirebaseAuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseAuthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseAuthHash();

  @$internal
  @override
  $ProviderElement<FirebaseAuth> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseAuth create(Ref ref) {
    return firebaseAuth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseAuth value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseAuth>(value),
    );
  }
}

String _$firebaseAuthHash() => r'912368c3df3f72e4295bf7a8cda93b9c5749d923';

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'8f9d7a2eb82c5331a70472d7054c493c0d4f005a';

@ProviderFor(notesRemoteDataSource)
const notesRemoteDataSourceProvider = NotesRemoteDataSourceProvider._();

final class NotesRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          NotesRemoteDataSource,
          NotesRemoteDataSource,
          NotesRemoteDataSource
        >
    with $Provider<NotesRemoteDataSource> {
  const NotesRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotesRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotesRemoteDataSource create(Ref ref) {
    return notesRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotesRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotesRemoteDataSource>(value),
    );
  }
}

String _$notesRemoteDataSourceHash() =>
    r'fc7f1612e64294ea7f81c946d9e82055350dee75';

@ProviderFor(notesLocalDataSource)
const notesLocalDataSourceProvider = NotesLocalDataSourceProvider._();

final class NotesLocalDataSourceProvider
    extends
        $FunctionalProvider<
          NotesLocalDataSource,
          NotesLocalDataSource,
          NotesLocalDataSource
        >
    with $Provider<NotesLocalDataSource> {
  const NotesLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotesLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotesLocalDataSource create(Ref ref) {
    return notesLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotesLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotesLocalDataSource>(value),
    );
  }
}

String _$notesLocalDataSourceHash() =>
    r'1fb9c11040a9afe1540ece2e77d1799391b7b975';

@ProviderFor(notesRepository)
const notesRepositoryProvider = NotesRepositoryProvider._();

final class NotesRepositoryProvider
    extends
        $FunctionalProvider<NotesRepository, NotesRepository, NotesRepository>
    with $Provider<NotesRepository> {
  const NotesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotesRepository create(Ref ref) {
    return notesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotesRepository>(value),
    );
  }
}

String _$notesRepositoryHash() => r'066ca39724e77f66a39631b5c798f359d57f4538';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
