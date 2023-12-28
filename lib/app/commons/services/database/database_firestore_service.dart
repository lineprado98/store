import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store/app/commons/services/database/i_database_service.dart';
import 'package:store/app/commons/utils/collections/i_collection.dart';
import 'package:store/app/commons/services/database/database_response.dart';
import 'package:store/app/commons/utils/enums/filter_type_enum.dart';

class DatabaseFirestoreService implements IDatabaseService {
  late final FirebaseFirestore firestore;
  DatabaseFirestoreService() {
    firestore = FirebaseFirestore.instance;
  }

  Future<String?> _registerImage(String path) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('product_images/teste.jpg');
      UploadTask uploadTask = storageReference.putFile(File(path));
      await uploadTask.whenComplete(() => null);
      String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      inspect(e);
      print(e.message);
    }
  }

  @override
  Future<DatabaseResponse> create({required ICollection collection, required String userId}) async {
    try {
      final result = await firestore.collection('products').doc(userId).collection('userProducts').add(collection.toJson());

      String? imageURL;
      final path = collection.toJson()['image'];

      if (path != null) {
        imageURL = await _registerImage(path);
      }

      if (imageURL != null) {
        final documentReference = firestore.collection(collection.collectionName).doc(userId).collection('userProducts').doc(result.id);
        await documentReference.update({'image': imageURL});
      }

      return DatabaseResponse.fromSucces();
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }

  @override
  Future<DatabaseResponse> delete({required String collectionName, required String identifier, required String userId}) async {
    try {
      final documentReference = firestore.collection(collectionName).doc(userId).collection('userProducts').doc(identifier);
      await documentReference.delete();
      return DatabaseResponse.fromSucces();
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }

  @override
  Future<DatabaseResponse> update({required ICollection collection, required String identifier, required String userId}) async {
    try {
      String? imageURL;
      final path = collection.toJson()['image'];

      if (path != null) {
        imageURL = await _registerImage(path);
      }

      if (imageURL != null) {
        final documentReference = firestore.collection(collection.collectionName).doc(userId).collection('userProducts').doc(identifier);
        final json = collection.toJson();
        json['image'] = imageURL;
        await documentReference.update(json);
      }
      return DatabaseResponse.fromSucces();
    } on FirebaseException catch (e) {
      return DatabaseResponse.fromError(error: e);
    }
  }

  @override
  Future<DatabaseResponse> get({required String collectionName, FilterTypeEnum? orderBy, required String userId}) async {
    try {
      final collectionReference = firestore.collection(collectionName).doc(userId).collection('userProducts');
      Query query = collectionReference;

      if (orderBy != null) {
        switch (orderBy) {
          case FilterTypeEnum.date:
            query = query.orderBy("productCreatedAt", descending: true);
            break;
          case FilterTypeEnum.priceLess:
            query = query.orderBy("productPrice", descending: false);
            break;

          case FilterTypeEnum.priceMore:
            query = query.orderBy("productPrice", descending: true);
            break;

          default:
            query = query.orderBy("productName", descending: false);
            break;
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
      print('Firestore error: ${e.message}');
      return DatabaseResponse.fromError(error: e);
    }
  }
}
