import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final bool status;
  final String message;
  final dynamic authData;
  const AuthEntity({
    required this.message,
    required this.authData,
    required this.status,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        authData,
      ];
}

class AuthData extends Equatable {
  final int id;
  final int points;
  final int credit;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String token;

  const AuthData({
    required this.email,
    required this.id,
    required this.credit,
    required this.points,
    required this.image,
    required this.name,
    required this.phone,
    required this.token,
  });

  @override
  List<Object?> get props => [
        email,
        id,
        image,
        name,
        phone,
        token,
        points,
        credit,
      ];
}
