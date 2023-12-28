import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store/app/commons/services/database/i_database_service.dart';
import 'package:store/app/commons/utils/collections/collections_keys.dart';
import 'package:store/app/commons/utils/collections/i_collection.dart';
import 'package:store/app/commons/services/database/database_response.dart';
import 'package:store/app/commons/utils/enums/filter_type_enum.dart';
import 'package:store/app/commons/utils/utils.dart';
import 'package:uuid/uuid.dart';

class DatabaseFirestoreService implements IDatabaseService {
  late final FirebaseFirestore firestore;
  DatabaseFirestoreService() {
    firestore = FirebaseFirestore.instance;
  }

  @override
  Future<DatabaseResponse> create({
    required ICollection collection,
    required String userId,
  }) async {
    try {
      final result = await firestore.collection(collection.collectionName).doc(userId).collection(CollectionsKeys.userProducts).add(collection.toJson());

      String? imageURL;

      final path = collection.toJson()['image'];

      if (path != null && path.isNotEmpty) {
        imageURL = await _registerImage(path);
      }

      if (imageURL != null) {
        final documentReference = firestore.collection(collection.collectionName).doc(userId).collection(CollectionsKeys.userProducts).doc(result.id);
        await documentReference.update({'image': imageURL});
      }

      return DatabaseResponse.fromSucces();
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }

  @override
  Future<DatabaseResponse> delete({
    required String collectionName,
    required String identifier,
    required String userId,
  }) async {
    try {
      final documentReference = firestore.collection(collectionName).doc(userId).collection(CollectionsKeys.userProducts).doc(identifier);
      await documentReference.delete();
      return DatabaseResponse.fromSucces();
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }

  @override
  Future<DatabaseResponse> update({
    required ICollection collection,
    required String identifier,
    required String userId,
  }) async {
    try {
      String? imageURL;
      final path = collection.toJson()['image'];

      if (path != null && path.isNotEmpty && !isUrl(path)) {
        imageURL = await _registerImage(path);
      }

      final json = collection.toJson();

      if (imageURL != null) {
        json['image'] = imageURL;
      }
      final documentReference = firestore.collection(collection.collectionName).doc(userId).collection(CollectionsKeys.userProducts).doc(identifier);
      await documentReference.update(json);

      return DatabaseResponse.fromSucces();
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }

  @override
  Future<DatabaseResponse> get({
    required String collectionName,
    FilterTypeEnum? orderBy,
    required String userId,
  }) async {
    try {
      final collectionReference = firestore.collection(collectionName).doc(userId).collection(CollectionsKeys.userProducts);
      Query query = collectionReference;

      if (orderBy != null) {
        switch (orderBy) {
          case FilterTypeEnum.date:
            query = query.orderBy('productCreatedAt', descending: true);
            break;
          case FilterTypeEnum.priceLess:
            query = query.orderBy('productPrice', descending: false);
            break;

          case FilterTypeEnum.priceMore:
            query = query.orderBy('productPrice', descending: true);
            break;

          default:
            query = query.orderBy('productName', descending: false);
            break;
        }
      }

      final response = await query.get();

      final data = response.docs.map((DocumentSnapshot document) {
        final Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;
        dataMap['productId'] = document.id;

        return dataMap;
      }).toList();

      return DatabaseResponse.fromSucces(data: data);
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }

  Future<String?> _registerImage(String path) async {
    try {
      final uuid = const Uuid().v4();
      final Reference storageReference = FirebaseStorage.instance.ref().child('product_images/$uuid.jpg');
      final UploadTask uploadTask = storageReference.putFile(File(path));
      await uploadTask.whenComplete(() => null);
      final String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (_) {
      return null;
    }
  }
}
