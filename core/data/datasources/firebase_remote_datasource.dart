import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../error/exceptions.dart';

/// Base class for all Firebase remote data sources
abstract class FirebaseRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  FirebaseRemoteDataSource({
    required this.firestore,
    required this.firebaseAuth,
  });

  /// Gets the current user ID or throws an AuthException if not authenticated
  String getCurrentUserId() {
    final userId = firebaseAuth.currentUser?.uid;
    if (userId == null) {
      throw AuthException(message: 'User not authenticated', code: '0');
    }
    return userId;
  }

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  /// Creates a document in a collection
  Future<String> createDocument({
    required String collection,
    required String? documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final docRef = documentId != null
          ? firestore.collection(collection).doc(documentId)
          : firestore.collection(collection).doc();

      await docRef.set(data);
      return docRef.id;
    } catch (e) {
      throw ServerException(
        message: 'Failed to create document: ${e.toString()}',
      );
    }
  }

  /// Updates a document in a collection
  Future<void> updateDocument({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await firestore.collection(collection).doc(documentId).update(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update document: ${e.toString()}',
      );
    }
  }

  /// Deletes a document from a collection
  Future<void> deleteDocument({
    required String collection,
    required String documentId,
  }) async {
    try {
      await firestore.collection(collection).doc(documentId).delete();
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete document: ${e.toString()}',
      );
    }
  }

  /// Gets a document from a collection
  Future<Map<String, dynamic>> getDocument({
    required String collection,
    required String documentId,
  }) async {
    try {
      final doc = await firestore.collection(collection).doc(documentId).get();

      if (!doc.exists) {
        throw ServerException(message: 'Document not found');
      }

      final data = doc.data()!;
      data['id'] = documentId;
      return data;
    } catch (e) {
      throw ServerException(message: 'Failed to get document: ${e.toString()}');
    }
  }

  /// Gets all documents from a collection
  Future<List<Map<String, dynamic>>> getDocuments({
    required String collection,
    Query Function(CollectionReference)? queryBuilder,
  }) async {
    try {
      Query query = firestore.collection(collection);

      if (queryBuilder != null) {
        query = queryBuilder(query as CollectionReference);
      }

      final querySnapshot = await query.get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw ServerException(
        message: 'Failed to get documents: ${e.toString()}',
      );
    }
  }

  /// Batch delete documents
  Future<void> batchDeleteDocuments({
    required String collection,
    required List<String> documentIds,
  }) async {
    try {
      final batch = firestore.batch();

      for (final id in documentIds) {
        batch.delete(firestore.collection(collection).doc(id));
      }

      await batch.commit();
    } catch (e) {
      throw ServerException(
        message: 'Failed to batch delete documents: ${e.toString()}',
      );
    }
  }
}
