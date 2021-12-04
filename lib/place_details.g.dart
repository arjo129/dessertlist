// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetails _$PlaceDetailsFromJson(Map<String, dynamic> json) => PlaceDetails()
  ..name = json['name'] as String
  ..location = json['location'] as String
  ..tags = (json['tags'] as List<dynamic>).map((e) => e as String).toSet();

Map<String, dynamic> _$PlaceDetailsToJson(PlaceDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'tags': instance.tags.toList(),
    };
