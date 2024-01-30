import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'venue_info.freezed.dart';
part 'venue_info.g.dart';

@freezed
class VenueInfo with _$VenueInfo {
  const factory VenueInfo({
    @Default(None()) Option<String> bookingEmail,
    @Default(None()) Option<int> capacity,
    @Default(None()) Option<String> idealArtistProfile,
    @Default(None()) Option<String> productionInfo,
    @Default(None()) Option<String> frontOfHouse,
    @Default(None()) Option<String> monitors,
    @Default(None()) Option<String> microphones,
    @Default(None()) Option<String> lights,
    @Default(VenueType.other) VenueType type,
  }) = _VenueInfo;

  // fromJson
  factory VenueInfo.fromJson(Map<String, dynamic> json) =>
      _$VenueInfoFromJson(json);

  // empty
  static const empty = VenueInfo();
}

@JsonEnum()
enum VenueType {
  concertHall,
  bar,
  club,
  restaurant,
  theater,
  arena,
  stadium,
  festival,
  artGallery,
  studio,
  other,
}
