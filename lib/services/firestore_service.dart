import 'package:cloud_firestore/cloud_firestore.dart';

enum FirestoreCollection {
  users,
  donations,
  comments,
  history,
  contributions,
  tags,
  notifications,
}

extension FirestoreCollectionExtention on FirestoreCollection {
  String get name {
    switch (this) {
      case FirestoreCollection.users:
        return 'users';
      case FirestoreCollection.donations:
        return 'donations';
      case FirestoreCollection.comments:
        return 'comments';
      case FirestoreCollection.history:
        return 'history';
      case FirestoreCollection.contributions:
        return 'contributions';
      case FirestoreCollection.tags:
        return 'tags';
      case FirestoreCollection.notifications:
        return 'notifications';
    }
  }
}

class DatabaseService<T> {
  final String collection;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final T Function(String, Map<String, dynamic>) fromDS;
  final Map<String, dynamic> Function(T) toMap;

  DatabaseService(
      {required this.collection, required this.fromDS, required this.toMap});

  Future<T?> getSingle(String id) async {
    var snap = await _db.collection(collection).doc(id).get();
    if (!snap.exists) return null;
    return fromDS(snap.id, snap.data() ?? {});
  }

  Stream<T> streamSingle(String id) {
    return _db
        .collection(collection)
        .doc(id)
        .snapshots()
        .map((snap) => fromDS(snap.id, snap.data() ?? {}));
  }

  Stream<List<T>> streamList() {
    var ref = _db.collection(collection);
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => fromDS(doc.id, doc.data())).toList());
  }

  Future<dynamic> createItem(T item, {required String id}) {
    return _db.collection(collection).doc(id).set(toMap(item));
  }

  Future<void> updateItem(T item, String id) {
    return _db
        .collection(collection)
        .doc(id)
        .set(toMap(item), SetOptions(merge: true));
  }

  Future<void> removeItem(String id) {
    return _db.collection(collection).doc(id).delete();
  }

  Stream<List<T>> streamListWithQuery({
    List<QueryArgs>? queries,
    List<OrderBy>? orderBy,
    int? limit,
  }) {
    Query<Map<String, dynamic>> ref = _db.collection(collection);

    ref = buildQuery(
      ref: ref,
      queries: queries,
      orderBy: orderBy,
      limit: limit,
    );

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => fromDS(doc.id, doc.data())).toList());
  }

  Future<List<T>> getListWithQuery({
    List<QueryArgs>? queries,
    List<OrderBy>? orderBy,
    int? limit,
  }) async {
    try {
      Query<Map<String, dynamic>> ref = _db.collection(collection);

      ref = buildQuery(
        ref: ref,
        queries: queries,
        orderBy: orderBy,
        limit: limit,
      );

      var list = await ref.get();
      return list.docs.map((doc) => fromDS(doc.id, doc.data())).toList();
    } catch (e) {
      rethrow;
    }
  }

  Query<Map<String, dynamic>> buildQuery({
    required Query<Map<String, dynamic>> ref,
    List<QueryArgs>? queries,
    List<OrderBy>? orderBy,
    int? limit,
  }) {
    // Apply where conditions
    if (queries != null && queries.isNotEmpty) {
      for (var query in queries) {
        switch (query.type) {
          case QueryArgsType.isEqualTo:
            ref = ref.where(query.key, isEqualTo: query.value);
            break;
          case QueryArgsType.isGreaterThanOrEqualTo:
            ref = ref.where(query.key, isGreaterThanOrEqualTo: query.value);
            break;
          case QueryArgsType.isLessThanOrEqualTo:
            ref = ref.where(query.key, isLessThanOrEqualTo: query.value);
            break;
          case QueryArgsType.arrayContains:
            ref = ref.where(query.key, arrayContains: query.value);
            break;
        }
      }
    }

    // Apply sorting
    if (orderBy != null && orderBy.isNotEmpty) {
      for (var order in orderBy) {
        ref = ref.orderBy(order.field, descending: order.descending);
      }
    }

    // Apply limit
    if (limit != null) {
      ref = ref.limit(limit);
    }

    return ref;
  }
}

enum QueryArgsType {
  isEqualTo,
  isGreaterThanOrEqualTo,
  isLessThanOrEqualTo,
  arrayContains,
}

class QueryArgs {
  final String key;
  final dynamic value;
  final QueryArgsType type;
  QueryArgs(this.key, this.value, {this.type = QueryArgsType.isEqualTo});
}

class OrderBy {
  final String field;
  final bool descending;
  OrderBy(this.field, {this.descending = false});
}
