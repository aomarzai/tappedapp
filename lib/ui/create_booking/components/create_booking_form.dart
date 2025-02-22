import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:intheloopapp/domains/models/service.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/navigation_bloc/tapped_route.dart';
import 'package:intheloopapp/ui/common/form_item.dart';
import 'package:intheloopapp/ui/create_booking/components/booking_name_text_field.dart';
import 'package:intheloopapp/ui/create_booking/components/booking_note_text_field.dart';
import 'package:intheloopapp/ui/create_booking/create_booking_cubit.dart';
import 'package:intheloopapp/ui/forms/location_text_field.dart';
import 'package:intheloopapp/utils/app_logger.dart';
import 'package:intheloopapp/utils/bloc_utils.dart';

class CreateBookingForm extends StatefulWidget {
  const CreateBookingForm({super.key});

  @override
  State<CreateBookingForm> createState() => _CreateBookingFormState();
}

class _CreateBookingFormState extends State<CreateBookingForm> {
  // This function displays a CupertinoModalPopup with a reasonable fixed height
  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  final bookingNameController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nav = context.nav;
    return BlocBuilder<CreateBookingCubit, CreateBookingState>(
      builder: (context, state) {
        return Form(
          key: state.formKey,
          child: Column(
            children: [
              BookingNameTextField(
                controller: bookingNameController,
              ),
              LocationTextField(
                initialPlace: state.place,
                onChanged: (place, placeId) {
                  context.read<CreateBookingCubit>().updatePlace(
                        place: place,
                        placeId: Option.of(placeId),
                      );
                },
              ),
              FormItem(
                children: [
                  const Text('Start Time'),
                  CupertinoButton(
                    onPressed: () => _showDialog(
                      context,
                      CupertinoDatePicker(
                        initialDateTime: state.startTime.value,
                        minimumDate: DateTime.now().subtract(
                          const Duration(hours: 1),
                        ),
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime newDateTime) {
                          context
                              .read<CreateBookingCubit>()
                              .updateStartTime(newDateTime);
                        },
                      ),
                    ),
                    child: Text(
                      state.formattedStartTime,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              FormItem(
                children: <Widget>[
                  const Text('End Time'),
                  CupertinoButton(
                    onPressed: () => _showDialog(
                      context,
                      CupertinoDatePicker(
                        initialDateTime: state.endTime.value,
                        minimumDate: state.startTime.value,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime newDateTime) {
                          context
                              .read<CreateBookingCubit>()
                              .updateEndTime(newDateTime);
                        },
                      ),
                    ),
                    child: Text(
                      state.formattedEndTime,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              FormItem(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    child: Text('Duration'),
                  ),
                  Text(
                    state.formattedDuration,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              FormItem(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    child: Text(
                      // ignore: lines_longer_than_80_chars
                      'Artist Rate (\$${(state.service.rate / 100).toStringAsFixed(2)}${state.service.rateType == RateType.hourly ? '/hr' : ''})',
                    ),
                  ),
                  Text(
                    state.formattedArtistRate,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              FormItem(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    child: Text('Booking Fee (${state.bookingFee * 100}%)'),
                  ),
                  Text(
                    state.formattedApplicationFee,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              FormItem(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    child: Text('Total'),
                  ),
                  Text(
                    state.formattedTotal,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              BookingNoteTextField(
                controller: noteController,
              ),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: () async {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    try {
                      final booking = await context
                          .read<CreateBookingCubit>()
                          .createBooking();
                      nav.push(
                        BookingConfirmationPage(booking: booking),
                      );
                    } on StripeException catch (e, s) {
                      if (e.error.code == FailureCode.Canceled) {
                        return;
                      }

                      logger.error(
                        'error create booking',
                        error: e,
                        stackTrace: s,
                      );
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text('Error: ${e.error.localizedMessage}'),
                        ),
                      );
                    } catch (e, s) {
                      logger.error(
                        'error create booking',
                        error: e,
                        stackTrace: s,
                      );
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text('Error making payment'),
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              if (state.totalCost > 0)
                const Text(
                  'powered by stripe',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.inactiveGray,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
