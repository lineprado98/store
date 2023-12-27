import 'package:store/app/commons/utils/collections/i_collection.dart';
import 'package:store/app/commons/services/database/database_response.dart';
import 'package:store/app/commons/utils/enums/filter_type_enum.dart';

abstract class IDatabaseService {
  Future<DatabaseResponse> create({required ICollection collection, required String userId});
  Future<DatabaseResponse> update({required ICollection collection, required String identifier, required String userId});
  Future<DatabaseResponse> delete({required String collectionName, required String identifier, required String userId});
  Future<DatabaseResponse> get({required String collectionName, FilterTypeEnum? orderBy, required String userId});
}
