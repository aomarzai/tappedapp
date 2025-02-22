import 'package:badges/badges.dart' as badges;
import 'package:card_banner/card_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:intheloopapp/domains/models/opportunity.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/navigation_bloc/tapped_route.dart';
import 'package:intheloopapp/domains/onboarding_bloc/onboarding_bloc.dart';
import 'package:intheloopapp/ui/conditional_parent_widget.dart';
import 'package:intheloopapp/utils/admin_builder.dart';
import 'package:intheloopapp/utils/bloc_utils.dart';
import 'package:intheloopapp/utils/current_user_builder.dart';
import 'package:intheloopapp/utils/geohash.dart';
import 'package:intheloopapp/utils/hero_image.dart';
import 'package:intheloopapp/utils/opportunity_image.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:uuid/uuid.dart';

class OpportunityCard extends StatefulWidget {
  const OpportunityCard({
    required this.opportunity,
    this.onOpportunityDeleted,
    super.key,
  });

  final Opportunity opportunity;
  final void Function()? onOpportunityDeleted;

  @override
  State<OpportunityCard> createState() => _OpportunityCardState();
}

class _OpportunityCardState extends State<OpportunityCard> {
  bool _isApplied = false;

  Opportunity get _opportunity => widget.opportunity;

  @override
  void initState() {
    super.initState();
    final state = context.onboarding.state;
    final currentUser =
        state is Onboarded ? Option.of(state.currentUser) : const None();
    currentUser.map((t) {
      context.database
          .isUserAppliedForOpportunity(
        opportunityId: _opportunity.id,
        userId: t.id,
      )
          .then((isApplied) {
        setState(() {
          _isApplied = isApplied;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - 96;
    final database = context.database;
    final places = context.places;
    return CurrentUserBuilder(
      builder: (context, currentUser) {
        return AdminBuilder(
          builder: (context, isAdmin) {
            return ConditionalParentWidget(
              condition: _opportunity.userId == currentUser.id || isAdmin,
              conditionalBuilder: ({
                required Widget child,
              }) {
                return badges.Badge(
                  onTap: () => showDialog<AlertDialog>(
                    context: context,
                    builder: (_) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 5,
                      title: const Text('are your sure?'),
                      content:
                          const Text('do you want to delete this opportunity'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            database
                                .deleteOpportunity(widget.opportunity.id)
                                .then((value) {
                              widget.onOpportunityDeleted?.call();
                              Navigator.of(context, rootNavigator: true).pop();
                            }).onError((error, stackTrace) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  content: Text('Error deleting opportunity'),
                                ),
                              );
                            });
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pop,
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  ),
                  // onTap: () {

                  // },
                  position: badges.BadgePosition.custom(
                    top: 0,
                    end: 0,
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.transparent,
                  ),
                  badgeContent: const Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Colors.white,
                    size: 25,
                  ),
                  child: child,
                );
              },
              child: FutureBuilder(
                future: getOpImage(context, widget.opportunity),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ConditionalParentWidget(
                      condition: _isApplied,
                      conditionalBuilder: ({
                        required Widget child,
                      }) =>
                          child,
                      child: Container(
                        width: cardWidth,
                        height: 230,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const CupertinoActivityIndicator(),
                      ),
                    );
                  }

                  final provider = snapshot.data!;
                  final uuid = const Uuid().v4();
                  final heroImageTag =
                      'op-image-${widget.opportunity.id}-$uuid';
                  final heroTitleTag =
                      'op-title-${widget.opportunity.id}-$uuid';
                  return ConditionalParentWidget(
                    condition: _isApplied,
                    conditionalBuilder: ({
                      required Widget child,
                    }) =>
                        CardBanner(
                      text: 'Applied',
                      color: Colors.green.withOpacity(0.8),
                      child: child,
                    ),
                    child: SizedBox(
                      width: cardWidth,
                      height: 300,
                      child: InkWell(
                        onTap: () => context.push(
                          OpportunityPage(
                            opportunityId: widget.opportunity.id,
                            opportunity: Option.of(widget.opportunity),
                            heroImage: HeroImage(
                              imageProvider: provider,
                              heroTag: heroImageTag,
                            ),
                            titleHeroTag: heroTitleTag,
                            onApply: () {
                              setState(() {
                                _isApplied = true;
                              });
                              context.pop();
                            },
                            onDislike: () {
                              setState(() {
                                _isApplied = false;
                              });
                              context.pop();
                            },
                            onDismiss: () => context.pop(),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: heroImageTag,
                              child: Container(
                                width: cardWidth,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: provider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Hero(
                              tag: heroTitleTag,
                              child: Text(
                                widget.opportunity.title,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            FutureBuilder(
                              future: places.getPlaceById(
                                widget.opportunity.location.placeId,
                              ),
                              builder: (context, snapshot) {
                                final place = snapshot.data;
                                return switch (place) {
                                  null => const SkeletonLine(),
                                  None() => const SizedBox.shrink(),
                                  Some(:final value) => Text(
                                      getAddressComponent(
                                        value.addressComponents,
                                      ),
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                      ),
                                    ),
                                };
                              },
                            ),
                            Text(
                              DateFormat(
                                'MM/dd/yyyy',
                              ).format(
                                widget.opportunity.startTime,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
