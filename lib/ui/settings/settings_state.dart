part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  SettingsState({
    this.username = '',
    this.artistName = '',
    this.bio = '',
    this.genres = const [],
    this.label,
    this.occupations = const [],
    this.placeId,
    this.twitterHandle,
    this.twitterFollowers,
    this.instagramHandle,
    this.instagramFollowers,
    this.tiktokHandle,
    this.tiktokFollowers,
    this.spotifyUrl,
    this.youtubeChannelId,
    this.profileImage = const None(),
    this.pressKitFile = const None(),
    this.status = FormzSubmissionStatus.initial,
    this.pushNotificationsDirectMessages = true,
    this.emailNotificationsAppReleases = true,
    this.email = '',
    this.password = '',
    this.place = const None(),
    GlobalKey<FormState>? formKey,
  }) {
    this.formKey = formKey ?? GlobalKey<FormState>(debugLabel: 'settings');
  }

  final String username;
  final String artistName;
  final List<Genre> genres;
  final List<String> occupations;
  final String? label;

  final String bio;

  final String? twitterHandle;
  final int? twitterFollowers;
  final String? instagramHandle;
  final int? instagramFollowers;
  final String? tiktokHandle;
  final int? tiktokFollowers;
  final String? spotifyUrl;
  final String? youtubeChannelId;

  final Option<File> pressKitFile;

  final Option<File> profileImage;
  final FormzSubmissionStatus status;

  final String? placeId;
  late final Option<PlaceData> place;

  late final ImagePicker picker;
  late final GlobalKey<FormState> formKey;

  final bool pushNotificationsDirectMessages;
  final bool emailNotificationsAppReleases;

  final String email;
  final String password;

  @override
  List<Object?> get props => [
        username,
        artistName,
        bio,
        genres,
        label,
        occupations,
        place,
        placeId,
        twitterHandle,
        twitterFollowers,
        instagramHandle,
        instagramFollowers,
        tiktokHandle,
        tiktokFollowers,
        spotifyUrl,
        youtubeChannelId,
        profileImage,
        pressKitFile,
        status,
        pushNotificationsDirectMessages,
        emailNotificationsAppReleases,
        email,
        password,
      ];

  SettingsState copyWith({
    String? username,
    String? artistName,
    String? bio,
    List<Genre>? genres,
    List<String>? occupations,
    String? label,
    String? placeId,
    Option<PlaceData>? place,
    String? twitterHandle,
    int? twitterFollowers,
    String? instagramHandle,
    int? instagramFollowers,
    String? tiktokHandle,
    int? tiktokFollowers,
    String? spotifyUrl,
    String? youtubeChannelId,
    Option<File>? profileImage,
    Option<File>? pressKitFile,
    FormzSubmissionStatus? status,
    bool? pushNotificationsDirectMessages,
    bool? emailNotificationsAppReleases,
    String? email,
    String? password,
  }) {
    return SettingsState(
      username: username ?? this.username,
      artistName: artistName ?? this.artistName,
      bio: bio ?? this.bio,
      genres: genres ?? this.genres,
      occupations: occupations ?? this.occupations,
      label: label ?? this.label,
      place: place ?? this.place,
      placeId: placeId ?? this.placeId,
      twitterHandle: twitterHandle ?? this.twitterHandle,
      twitterFollowers: twitterFollowers ?? this.twitterFollowers,
      instagramHandle: instagramHandle ?? this.instagramHandle,
      instagramFollowers: instagramFollowers ?? this.instagramFollowers,
      tiktokHandle: tiktokHandle ?? this.tiktokHandle,
      tiktokFollowers: tiktokFollowers ?? this.tiktokFollowers,
      spotifyUrl: spotifyUrl ?? this.spotifyUrl,
      youtubeChannelId: youtubeChannelId ?? this.youtubeChannelId,
      profileImage: profileImage ?? this.profileImage,
      pressKitFile: pressKitFile ?? this.pressKitFile,
      status: status ?? this.status,
      pushNotificationsDirectMessages: pushNotificationsDirectMessages ??
          this.pushNotificationsDirectMessages,
      emailNotificationsAppReleases:
          emailNotificationsAppReleases ?? this.emailNotificationsAppReleases,
      formKey: formKey,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
