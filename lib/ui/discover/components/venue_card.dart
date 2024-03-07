import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intheloopapp/domains/models/performer_info.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/domains/models/venue_info.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/navigation_bloc/tapped_route.dart';
import 'package:intheloopapp/utils/bloc_utils.dart';
import 'package:intheloopapp/utils/current_user_builder.dart';
import 'package:intheloopapp/utils/default_image.dart';
import 'package:intheloopapp/utils/hero_image.dart';
import 'package:intl/intl.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class VenueCard extends StatelessWidget {
  const VenueCard({
    required this.venue,
    super.key,
  });

  final UserModel venue;

  @override
  Widget build(BuildContext context) {
    if (venue.deleted) return const SizedBox.shrink();

    final database = context.database;
    final imageUrl = venue.profilePicture.toNullable();

    final venueType =
        venue.venueInfo.map((e) => e.type).getOrElse(() => VenueType.other);
    return CurrentUserBuilder(
      builder: (context, currentUser) {
        final category = currentUser.performerInfo.map((t) => t.category);
        final isGoodFit = venue.venueInfo.flatMap((t) => t.capacity).map2(category, (cap, cat) {
          return cat.suggestedMaxCapacity >= cap;
        }).getOrElse(() => false);
        return FutureBuilder(
          future: database.isVerified(venue.id),
          builder: (context, snapshot) {
            final verified = snapshot.data ?? false;
            final provider = (imageUrl == null || imageUrl.isEmpty)
                ? getDefaultImage(Option.of(venue.id))
                : CachedNetworkImageProvider(
                    imageUrl,
                  );
            final uuid = const Uuid().v4();
            final heroImageTag = 'user-image-${venue.id}-$uuid';
            final heroTitleTag = 'user-title-${venue.id}-$uuid';
            return SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: () => context.push(
                      ProfilePage(
                        userId: venue.id,
                        user: Option.of(venue),
                        heroImage: HeroImage(
                          imageProvider: provider,
                          heroTag: heroImageTag,
                        ),
                        titleHeroTag: heroTitleTag,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Hero(
                          tag: heroImageTag,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: provider,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                if (isGoodFit) Colors.green else Colors.red,
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: venue.displayName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    if (verified)
                                      const WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 4),
                                          child: Icon(
                                            Icons.verified,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Text(
                                venueType.formattedName,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
