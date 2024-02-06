import 'package:algolia/algolia.dart';
import 'package:cached_annotation/cached_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:intheloopapp/data/search_repository.dart';
import 'package:intheloopapp/domains/models/user_model.dart';

final _analytics = FirebaseAnalytics.instance;
final _fireStore = FirebaseFirestore.instance;
final usersRef = _fireStore.collection('users');
final loopsRef = _fireStore.collection('loops');

class AlgoliaSearchImpl extends SearchRepository {
  AlgoliaSearchImpl({
    required String applicationId,
    required String apiKey,
  }) : algolia = Algolia.init(
          applicationId: applicationId,
          apiKey: apiKey,
        ).instance;

  final Algolia algolia;

  @cached
  Future<UserModel> _getUser(String userId) async {
    final userSnapshot = await usersRef.doc(userId).get();
    final user = UserModel.fromDoc(userSnapshot);

    return user;
  }

  @override
  @Cached(ttl: 300) // 5 minutes
  Future<List<UserModel>> queryUsers(
    String input, {
    List<String>? labels,
    List<String>? genres,
    List<String>? occupations,
    double? lat,
    double? lng,
    int radius = 50000,
  }) async {
    var results = <AlgoliaObjectSnapshot>[];

    const formattedIsDeletedFilter = 'deleted:false';
    final formattedLabelFilter = labels != null
        ? '(${labels.map((e) => "label:'$e'").join(' OR ')})'
        : null;
    final formattedGenreFilter = genres != null
        ? '(${genres.map((e) => "genres:'$e'").join(' OR ')})'
        : null;
    final formattedOccupationFilter = occupations != null
        ? '(${occupations.map((e) => "occupations:'$e'").join(' OR ')})'
        : null;

    final filters = [
      formattedIsDeletedFilter,
      formattedLabelFilter,
      formattedGenreFilter,
      formattedOccupationFilter,
    ]..removeWhere((element) => element == null);

    final formattedLocationFilter =
        (lat != null && lng != null) ? '$lat, $lng' : null;

    try {
      // print(filters.join(' AND '));

      var query = algolia.index('prod_users').query(input).filters(
            filters.join(' AND '),
          );

      if (formattedLocationFilter != null) {
        query = query.setAroundLatLng(formattedLocationFilter);
      }

      query = query.setAroundRadius(radius);

      final snap = await query.getObjects();

      await _analytics.logSearch(searchTerm: input);

      results = snap.hits;
    } on AlgoliaError {
      // print(e.error);
      rethrow;
    }

    final userResults = await Future.wait(
      results.map((res) async {
        final user = await _getUser(res.objectID);
        return user;
      }),
    );

    return userResults;
  }

  @override
  Future<List<UserModel>> queryUsersInBoundingBox(
    String input, {
    required double swLatitude,
    required double swLongitude,
    required double neLatitude,
    required double neLongitude,
    List<String>? labels,
    List<String>? genres,
    List<String>? occupations,
  }) async {
    var results = <AlgoliaObjectSnapshot>[];

    const formattedIsDeletedFilter = 'deleted:false';
    final formattedLabelFilter = labels != null
        ? '(${labels.map((e) => "label:'$e'").join(' OR ')})'
        : null;
    final formattedGenreFilter = genres != null
        ? '(${genres.map((e) => "genres:'$e'").join(' OR ')})'
        : null;
    final formattedOccupationFilter = occupations != null
        ? '(${occupations.map((e) => "occupations:'$e'").join(' OR ')})'
        : null;

    final filters = [
      formattedIsDeletedFilter,
      formattedLabelFilter,
      formattedGenreFilter,
      formattedOccupationFilter,
    ]..removeWhere((element) => element == null);

    try {
      // print(filters.join(' AND '));
      final query = algolia
          .index('prod_users')
          .query(input)
          .filters(
            filters.join(' AND '),
          )
          .setInsideBoundingBox([
        BoundingBox(
          p1Lat: swLatitude,
          p1Lng: swLongitude,
          p2Lat: neLatitude,
          p2Lng: neLongitude,
        ),
      ]);
      final snap = await query.getObjects();

      await _analytics.logSearch(searchTerm: input);

      results = snap.hits;
    } on AlgoliaError {
      // print(e.error);
      rethrow;
    }

    final userResults = await Future.wait(
      results.map((res) async {
        final user = await _getUser(res.objectID);
        return user;
      }),
    );

    return userResults;
  }
}
