import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'compartment.g.dart';

@JsonSerializable()
class Compartment {
  int id;
  String name;
  String icon;
  String color;

  Compartment(
      {@required this.id,
      @required this.name,
      @required this.icon,
      @required this.color});

  @override
  String toString() {
    return json.encode(this.toJson());
  }

  factory Compartment.fromJson(Map<String, dynamic> json) =>
      _$CompartmentFromJson(json);

  Map<String, dynamic> toJson() => _$CompartmentToJson(this);
}
