import 'package:json_annotation/json_annotation.dart';

part 'place_details.g.dart';

// Place names
@JsonSerializable()
class PlaceDetails {
  String name;
  String location;
  Set<String> tags;

  PlaceDetails()
      : name = "",
        location = "",
        tags = {};

  /// Connect the generated [_$PlaceDetailsFromJson] function to the `fromJson`
  /// factory.
  factory PlaceDetails.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsFromJson(json);

  /// Connect the generated [_$PlaceDetailsToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PlaceDetailsToJson(this);
}
