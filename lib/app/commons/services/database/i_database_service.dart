import 'package:store/app/commons/services/database/filters_params.dart';
import 'package:store/app/commons/utils/collections/i_collection.dart';
import 'package:store/app/commons/services/database/database_response.dart';

abstract class IDatabaseService {
  Future<DatabaseResponse> create({required ICollection collection});
  Future<DatabaseResponse> update({required ICollection collection, required String identifier});
  Future<DatabaseResponse> delete({required String collectionName, required String identifier});
  Future<DatabaseResponse> get({required String collectionName, List<FilterParams>? filters});
}
