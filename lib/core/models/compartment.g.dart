// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compartment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Compartment _$CompartmentFromJson(Map<String, dynamic> json) {
  return Compartment(
    id: json['id'] as int,
    name: json['name'] as String,
    icon: json['icon'] as String,
    color: json['color'] as String,
  );
}

Map<String, dynamic> _$CompartmentToJson(Compartment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
    };
