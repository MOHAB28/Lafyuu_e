import '../../domain/entities/login_entity.dart';

class AuthModel extends AuthEntity {
  final dynamic authDataModel;
  AuthModel({
    bool? status,
    String? message,
    this.authDataModel,
  }) : super(
          message: message!,
          status: status!,
          authData: authDataModel,
        );

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json['status'],
      message: json['message'] ?? '',
      authDataModel: json['data'] != null
          ? AuthDataModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'status': status,
      'message': message,
      'data': authDataModel != null ? authDataModel!.toJson() : null,
    };
    return json;
  }
}

class AuthDataModel extends AuthData {
  AuthDataModel({
    String? name,
    String? email,
    String? phone,
    String? image,
    String? token,
    int? id,
    int? points,
    int? credit,
  }) : super(
          name: name!,
          email: email!,
          phone: phone!,
          image: image!,
          token: token!,
          id: id!,
          points: points!,
          credit: credit!,
        );

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      credit: json['credit'],
      points: json['points'],
      id: json['id'],
      image: json['image'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'name': name,
      'email': email,
      'phone': phone,
      'id': id,
      'image': image,
      'token': token
    };
    return json;
  }
}
