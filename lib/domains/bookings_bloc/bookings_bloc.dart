import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/domains/authentication_bloc/authentication_bloc.dart';
import 'package:intheloopapp/domains/models/booking.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  BookingsBloc({
    required this.authenticationBloc,
    required this.database,
  }) : super(const BookingsState()) {
    on<BookingsInitial>((event, emit) {
      emit(const BookingsState());
    });
    on<FetchBookings>((event, emit) async {
      try {
        final currentUserId =
            (authenticationBloc.state as Authenticated).currentAuthUser.uid;

        final requesterBookings =
            await database.getBookingsByRequester(currentUserId);

        final requesteeBookings =
            await database.getBookingsByRequestee(currentUserId);

        final bookings = requesteeBookings..addAll(requesterBookings);

        emit(
          BookingsState(
            bookings: bookings,
          ),
        );
      } catch (e, s) {
        await FirebaseCrashlytics.instance.recordError(e, s);
      }
    });
    on<ConfirmBooking>((event, emit) async {
      try {
        final newBooking = event.booking.copyWith(
          status: BookingStatus.confirmed,
        );
        final newBookings = state.bookings;
        newBookings[newBookings.indexOf(event.booking)] = newBooking;
        await database.updateBooking(newBooking);
        emit(
          BookingsState(
            bookings: newBookings,
          ),
        );
      } catch (e, s) {
        await FirebaseCrashlytics.instance.recordError(e, s);
      }
    });
    on<DenyBooking>((event, emit) async {
      try {
        final newBooking = event.booking.copyWith(
          status: BookingStatus.canceled,
        );
        state.bookings[state.bookings.indexOf(event.booking)] = newBooking;
        final newBookings = state.bookings;
        newBookings[newBookings.indexOf(event.booking)] = newBooking;
        await database.updateBooking(newBooking);
        emit(
          BookingsState(
            bookings: newBookings,
          ),
        );
      } catch (e, s) {
        await FirebaseCrashlytics.instance.recordError(e, s);
      }
    });
  }

  final AuthenticationBloc authenticationBloc;
  final DatabaseRepository database;
}
