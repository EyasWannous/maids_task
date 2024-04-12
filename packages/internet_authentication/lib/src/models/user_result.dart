// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'user_result.g.dart';

@JsonSerializable()
class UserResult {
  UserResult({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.token,
  });

  factory UserResult.fromJson(Map<String, dynamic> json) =>
      _$UserResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserResultToJson(this);

  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? token;
}
