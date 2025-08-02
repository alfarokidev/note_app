// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(NotesNotifier)
const notesNotifierProvider = NotesNotifierProvider._();

final class NotesNotifierProvider
    extends $AsyncNotifierProvider<NotesNotifier, List<Note>> {
  const NotesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesNotifierHash();

  @$internal
  @override
  NotesNotifier create() => NotesNotifier();
}

String _$notesNotifierHash() => r'956b29383ed0e51aa6f54902b6bfb8914fc13d07';

abstract class _$NotesNotifier extends $AsyncNotifier<List<Note>> {
  FutureOr<List<Note>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Note>>, List<Note>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Note>>, List<Note>>,
              AsyncValue<List<Note>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
