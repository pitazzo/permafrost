import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name;
  String currentFridge;
  List<String> accesibleFidges;

  User(
      {@required this.name,
      @required this.currentFridge,
      @required this.accesibleFidges});

  User copy({String name, String currentFridge, List<String> accesibleFidges}) {
    return User(
        name: name ?? this.name,
        currentFridge: currentFridge ?? this.currentFridge,
        accesibleFidges: accesibleFidges ?? this.accesibleFidges);
  }

  @override
  String toString() {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(this.toJson());
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is User &&
            this.name == name &&
            this.currentFridge == this.currentFridge &&
            this.accesibleFidges == this.accesibleFidges);
  }

  @override
  int get hashCode =>
      this.name.hashCode ^
      this.currentFridge.hashCode ^
      this.accesibleFidges.hashCode;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
