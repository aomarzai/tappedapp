import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/data/places_repository.dart';
import 'package:intheloopapp/data/search_repository.dart';
import 'package:intheloopapp/domains/models/genre.dart';
import 'package:intheloopapp/domains/models/performer_info.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/utils/app_logger.dart';

part 'gig_search_state.dart';

part 'gig_search_cubit.freezed.dart';

class GigSearchCubit extends Cubit<GigSearchState> {
  GigSearchCubit({
    required this.database,
    required this.initialPlace,
    required this.initialGenres,
    required this.search,
    required this.category,
  }) : super(
          GigSearchState(
            place: initialPlace,
            genres: initialGenres,
            capacityRange: RangeValues(
              0,
              category.suggestedMaxCapacity.toDouble().clamp(0, 1000),
            ),
          ),
        );

  final DatabaseRepository database;
  final SearchRepository search;
  final Option<PlaceData> initialPlace;
  final List<Genre> initialGenres;
  final PerformerCategory category;

  void resetForm() {
    emit(
      state.copyWith(
        formStatus: FormzSubmissionStatus.initial,
      ),
    );
  }

  void updateLocation(Option<PlaceData> placeData) {
    emit(
      state.copyWith(
        place: placeData,
      ),
    );
  }

  void updateGenres(List<Genre> genres) {
    emit(
      state.copyWith(
        genres: genres,
      ),
    );
  }

  void updateCapacity(RangeValues capacityRange) {
    emit(
      state.copyWith(
        capacityRange: capacityRange,
      ),
    );
  }

  Future<void> searchVenues() async {
    if (state.genres.isEmpty) {
      throw Exception('Please select at least one genre');
    }

    if (state.place.isNone()) {
      throw Exception('Please select a city');
    }

    emit(
      state.copyWith(
        formStatus: FormzSubmissionStatus.inProgress,
      ),
    );

    final lat = state.place.fold(
      () => 0.0,
      (a) => a.lat,
    );

    final lng = state.place.fold(
      () => 0.0,
      (a) => a.lng,
    );

    final minCap = state.capacityRangeStart;
    final maxCap = state.capacityRangeEnd == maxCapacity ? 100000 : state.capacityRangeEnd;

    final hits = await search.queryUsers(
      '',
      occupations: ['venue', 'Venue'],
      venueGenres: state.genres.map((e) => e.name).toList(),
      lat: lat,
      lng: lng,
      minCapacity: minCap,
      maxCapacity: maxCap,
      limit: 150,
    );

    final potentialUsers = await Future.wait(hits.map((hit) async {
      final user = await database.getUserById(hit.id);
      return user;
    }));

    final users = potentialUsers
        .whereType<Some<UserModel>>()
        .map((e) => e.value)
        .toList();

    emit(
      state.copyWith(
        results: users
            .map(
              (hit) => SelectableResult(
                user: hit,
                selected: false,
              ),
            )
            .toList(),
      ),
    );

    emit(
      state.copyWith(
        formStatus: FormzSubmissionStatus.success,
      ),
    );
  }

  Future<void> selectAll(bool selected) async {
    await HapticFeedback.mediumImpact();

    final updatedResults = state.results.map((result) {
      return result.copyWith(selected: selected);
    }).toList();

    emit(
      state.copyWith(
        results: updatedResults,
      ),
    );
  }

  Future<void> updateSelected(String userId, bool selected) async {
    await HapticFeedback.mediumImpact();
    final updatedResults = state.results.map((result) {
      if (result.user.id == userId) {
        return result.copyWith(selected: selected);
      }
      return result;
    }).toList();

    emit(
      state.copyWith(
        results: updatedResults,
      ),
    );
  }

  void confirmSelection() {
    logger.info(state.selectedResults.toString());
  }
}
