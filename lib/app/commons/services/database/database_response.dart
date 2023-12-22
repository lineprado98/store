class DatabaseResponse {
  final dynamic data;
  final int status;
  final dynamic error;

  DatabaseResponse({required this.data, required this.status, required this.error});

  factory DatabaseResponse.fromSucces({dynamic data}) {
    return DatabaseResponse(data: data, status: 200, error: null);
  }
  factory DatabaseResponse.fromError({dynamic error}) {
    return DatabaseResponse(data: error, status: 500, error: null);
  }
}
