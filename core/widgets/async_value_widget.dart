import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error/failures.dart';
import '../error/exceptions.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget Function(Object error, StackTrace stackTrace)? error;
  final Widget? loading;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.error,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: error ?? _defaultError,
      loading: () => loading ?? _defaultLoading(),
    );
  }

  Widget _defaultError(Object error, StackTrace stackTrace) {
    String message = 'An error occurred';

    if (error is Failure) {
      message = error.message;
    } else if (error is CacheException) {
      message = error.message;
    } else if (error is AuthException) {
      message = error.message;
    } else if (error is FirestoreException) {
      message = error.message;
    } else if (error is Exception) {
      message = error.toString().replaceFirst('Exception: ', '');
    } else {
      message = error.toString();
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _defaultLoading() {
    return const Center(child: CircularProgressIndicator());
  }
}
