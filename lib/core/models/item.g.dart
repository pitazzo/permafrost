// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'] as int,
    name: json['name'] as String,
    amount: (json['amount'] as num)?.toDouble(),
    units: json['units'] as String,
    entryDate: json['entryDate'] == null
        ? null
        : DateTime.parse(json['entryDate'] as String),
    expiryDate: json['expiryDate'] == null
        ? null
        : DateTime.parse(json['expiryDate'] as String),
    compartmentId: json['compartmentId'] as int,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'units': instance.units,
      'entryDate': instance.entryDate?.toIso8601String(),
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'compartmentId': instance.compartmentId,
    };
