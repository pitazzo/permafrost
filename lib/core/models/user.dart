import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name;
  String currentFridge;
  List<String> accesibleFridges;

  User({
    @required this.name,
    @required this.currentFridge,
    @required this.accesibleFridges,
  });

  User copy({String name, String currentFridge, List<String> accesibleFridges}) {
    return User(
        name: name ?? this.name,
        currentFridge: currentFridge ?? this.currentFridge,
        accesibleFridges: accesibleFridges ?? this.accesibleFridges);
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
            this.name == other.name &&
            this.currentFridge == other.currentFridge &&
            this.accesibleFridges == other.accesibleFridges);
  }

  @override
  int get hashCode =>
      this.name.hashCode ^
      this.currentFridge.hashCode ^
      this.accesibleFridges.hashCode;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
