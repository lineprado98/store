abstract class ICollection {
  final String collectionName;
  Map<String, dynamic> toJson();

  const ICollection({required this.collectionName});
}
