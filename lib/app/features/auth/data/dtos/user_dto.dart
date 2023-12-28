import 'package:store/app/features/auth/domain/entities/user_entity.dart';

class UserDto extends UserEntity {
  final String userName;
  final String userEmail;
  final String uid;

  const UserDto({required this.userName, required this.userEmail, required this.uid})
      : super(
          name: userName,
          email: userEmail,
          id: uid,
        );

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'uid': uid,
    };
  }

  factory UserDto.fromJson({required Map<String, dynamic> json}) {
    return UserDto(
      userName: '',
      userEmail: json['userEmail'],
      uid: json['uid'],
    );
  }
  factory UserDto.fromEntity({required UserEntity entity}) {
    return UserDto(
      userName: entity.name,
      userEmail: entity.email,
      uid: entity.id,
    );
  }
  factory UserDto.empty() {
    return const UserDto(
      userName: '',
      userEmail: '',
      uid: '',
    );
  }
}
