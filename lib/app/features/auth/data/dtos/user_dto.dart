import 'package:store/app/features/auth/domain/entities/user_entity.dart';

class UserDto extends UserEntity {
  final String userName;
  final String userEmail;
  final String userPassword;

  const UserDto({required this.userName, required this.userEmail, required this.userPassword})
      : super(
          name: userName,
          email: userEmail,
          password: userPassword,
        );

  Map<String, dynamic> toJson() {
    return {'userName': userName, 'userEmail': userEmail, 'userPassword': userPassword};
  }

  factory UserDto.fromJson({required Map<String, dynamic> json}) {
    return UserDto(userName: '', userEmail: json['userEmail'], userPassword: '');
  }
  factory UserDto.fromEntity({required UserEntity entity}) {
    return UserDto(userName: entity.name, userEmail: entity.email, userPassword: entity.password);
  }
  factory UserDto.empty() {
    return const UserDto(userName: '', userEmail: '', userPassword: '');
  }
}
