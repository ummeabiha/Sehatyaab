import 'package:sehatyaab/models/BaseModel.dart';

class UserAccounts extends BaseModel {
  String password;
  String? email;
  String? option;

  UserAccounts({
    required super.id,
    required this.email,
    required this.password,
    required this.option,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'option': option,
    };
  }

  @override
  UserAccounts fromMap(Map<String, dynamic> map, String id) {
    return UserAccounts(
      id: id,
      email: map['email'] as String?,
      password: map['password'] as String,
      option: map['option'] as String,
    );
  }

  @override
  String toString() {
    return 'UserAccounts(userId: $id, password: $password, email: $email, option: $option )';
  }
}
