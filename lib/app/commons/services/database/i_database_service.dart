import 'package:store/app/commons/utils/collections/i_collection.dart';
import 'package:store/app/commons/services/database/database_response.dart';

abstract class IDatabaseService {
  //TODO: Mudar o nome para collectionName
  Future<DatabaseResponse> create({required ICollection collection});
  Future<DatabaseResponse> update({required ICollection collection, required String hashDoc});
  Future<void> delete({required String collectionName, required String hashDoc});
  Future<DatabaseResponse> getAll({required String collectionName, List<FilterParams>? filters});
  Future<DatabaseResponse> getByHash({required String collectionName, required String hashDoc});
}

class FilterParams {
  final String column;
  final dynamic value;

  FilterParams({required this.column, required this.value});
}
