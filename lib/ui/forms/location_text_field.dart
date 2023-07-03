import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/ui/themes.dart';
import 'package:intheloopapp/utils/geohash.dart';

class LocationTextField extends StatelessWidget {
  const LocationTextField({
    required this.initialPlaceId,
    required this.initialPlace,
    required this.onChanged,
    super.key,
  });

  final void Function(Place?, String) onChanged;
  final Place? initialPlace;
  final String? initialPlaceId;

  @override
  Widget build(BuildContext context) {
    final navigationBloc = context.read<NavigationBloc>();
    return GestureDetector(
      onTap: () {
        navigationBloc.add(
          PushLocationForm(
            initialPlace: initialPlace,
            onSelected: onChanged,
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 12),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.map,
                    color: tappedAccent,
                  ),
                ),
                Text(
                  initialPlace != null
                      ? formattedAddress(initialPlace?.addressComponents)
                      : 'Tap to select a city',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: tappedAccent,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
