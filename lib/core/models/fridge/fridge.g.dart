// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fridge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fridge _$FridgeFromJson(Map<String, dynamic> json) {
  return Fridge(
    owner: json['owner'] as String,
    compartments: (json['compartments'] as List)
        ?.map((e) =>
            e == null ? null : Compartment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    items: (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FridgeToJson(Fridge instance) => <String, dynamic>{
      'owner': instance.owner,
      'compartments': instance.compartments,
      'items': instance.items,
    };
