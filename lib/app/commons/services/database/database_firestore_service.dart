import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/app/commons/services/database/filters_params.dart';
import 'package:store/app/commons/services/database/i_database_service.dart';
import 'package:store/app/commons/utils/collections/i_collection.dart';
import 'package:store/app/commons/services/database/database_response.dart';

class DatabaseFirestoreService implements IDatabaseService {
  late final FirebaseFirestore firestore;
  DatabaseFirestoreService() {
    firestore = FirebaseFirestore.instance;
  }

  @override
  Future<DatabaseResponse> create({required ICollection collection, required String userId}) async {
    try {
      await firestore.collection('products').doc(userId).collection('userProducts').add(collection.toJson());
      return DatabaseResponse.fromSucces();
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }

  @override
  Future<DatabaseResponse> delete({required String collectionName, required String identifier}) async {
    try {
      await firestore.collection(collectionName).doc(identifier).delete();
      return DatabaseResponse.fromSucces();
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }

  @override
  Future<DatabaseResponse> update({required ICollection collection, required String identifier}) async {
    try {
      firestore.collection(collection.collectionName).doc(identifier).update(collection.toJson());
      return DatabaseResponse.fromSucces();
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }

  @override
  Future<DatabaseResponse> get({required String collectionName, List<FilterParams>? filters, required String userId}) async {
    try {
      CollectionReference collectionReference = firestore.collection(collectionName).doc(userId).collection('userProducts');
      Query query = collectionReference;
      if (filters?.isNotEmpty ?? false) {
        for (var item in filters!) {
          query = query.where(item.column, isEqualTo: item.value);
        }
      }
      QuerySnapshot response = await query.get();

      List<Map<String, dynamic>> data = response.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;
        dataMap['productId'] = document.id;

        return dataMap;
      }).toList();
      return DatabaseResponse.fromSucces(data: data);
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }
}
