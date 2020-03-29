// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    currentFridge: json['currentFridge'] as String,
    accesibleFidges:
        (json['accesibleFidges'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'currentFridge': instance.currentFridge,
      'accesibleFidges': instance.accesibleFidges,
    };
