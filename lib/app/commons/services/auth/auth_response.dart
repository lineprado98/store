class AuthResponse {
  final dynamic data;
  final Map<String, dynamic> error;
  final int status;

  const AuthResponse({required this.data, required this.error, required this.status});
}
