import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  final int id;
  final String name;
  final double amount;
  final String units;
  final DateTime entryDate;
  final DateTime expiryDate;
  final int compartmentId;

  Item({
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.units,
    @required this.entryDate,
    @required this.expiryDate,
    @required this.compartmentId,
  });

  Item copy({
    int id,
    String name,
    double amount,
    String units,
    DateTime entryDate,
    DateTime expiryDate,
    int compartmentId,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      units: units ?? this.units,
      entryDate: entryDate ?? this.entryDate,
      expiryDate: expiryDate ?? this.expiryDate,
      compartmentId: compartmentId ?? this.compartmentId,
    );
  }

  @override
  String toString() {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(this.toJson());
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Item &&
            this.id == other.id &&
            this.name == other.name &&
            this.amount == other.amount &&
            this.units == other.units &&
            this.entryDate == other.entryDate &&
            this.expiryDate == other.expiryDate &&
            this.compartmentId == other.compartmentId);
  }

  @override
  int get hashCode => this.id ^ this.name.hashCode ^ this.amount.hashCode;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
