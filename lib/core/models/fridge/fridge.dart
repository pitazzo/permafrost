import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/core/models/fridge/item.dart';

part 'fridge.g.dart';

@JsonSerializable()
class Fridge {
  String owner;
  List<Compartment> compartments;
  List<Item> items;

  Fridge({
    @required this.owner,
    @required this.compartments,
    @required this.items,
  });

  Fridge copy({
    String owner,
    List<Compartment> compartments,
    List<Item> items,
  }) {
    return Fridge(
      owner: owner ?? this.owner,
      compartments: compartments ?? this.compartments,
      items: items ?? this.compartments,
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
        (other is Fridge &&
            this.owner == owner &&
            this.compartments == this.compartments &&
            this.items == this.items);
  }

  @override
  int get hashCode =>
      this.owner.hashCode ^ this.compartments.hashCode ^ this.items.hashCode;

  factory Fridge.fromJson(Map<String, dynamic> json) => _$FridgeFromJson(json);

  Map<String, dynamic> toJson() => _$FridgeToJson(this);
}
