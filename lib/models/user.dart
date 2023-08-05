// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.username,
    required this.password,
  });

  final int id;
  final String username;
  final int password;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
