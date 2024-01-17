import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intheloopapp/domains/models/opportunity.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/navigation_bloc/tapped_route.dart';
import 'package:intheloopapp/ui/conditional_parent_widget.dart';
import 'package:intheloopapp/utils/admin_builder.dart';
import 'package:intheloopapp/utils/bloc_utils.dart';
import 'package:intheloopapp/utils/current_user_builder.dart';
import 'package:intheloopapp/utils/hero_image.dart';
import 'package:intheloopapp/utils/opportunity_image.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({
    required this.opportunity,
    this.onOpportunityDeleted,
    super.key,
  });

  final Opportunity opportunity;
  final void Function()? onOpportunityDeleted;

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - 56;
    final database = context.database;
    return CurrentUserBuilder(
      builder: (context, currentUser) {
        return AdminBuilder(
          builder: (context, isAdmin) {
            return ConditionalParentWidget(
              condition: opportunity.userId == currentUser.id || isAdmin,
              conditionalBuilder: ({
                required Widget child,
              }) {
                return badges.Badge(
                  onTap: () {
                    database
                        .deleteOpportunity(opportunity.id)
                        .then((value) => onOpportunityDeleted?.call())
                        .onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text('Error deleting opportunity'),
                        ),
                      );
                    });
                  },
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
                future: getOpImage(context, opportunity),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      width: cardWidth,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const CupertinoActivityIndicator(),
                    );
                  }
            
                  final provider = snapshot.data!;
                  final uuid = const Uuid().v4();
                  final heroImageTag = 'op-image-${opportunity.id}-$uuid';
                  final heroTitleTag = 'op-title-${opportunity.id}-$uuid';
                  return SizedBox(
                    width: cardWidth,
                    height: 230,
                    child: InkWell(
                      onTap: () => context.push(
                        OpportunityPage(
                          opportunityId: opportunity.id,
                          opportunity: Some(opportunity),
                          heroImage: HeroImage(
                            imageProvider: provider,
                            heroTag: heroImageTag,
                          ),
                          titleHeroTag: heroTitleTag,
                          onApply: () => context.pop(),
                          onDislike: () => context.pop(),
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
                              opportunity.title,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat(
                              'MM/dd/yyyy',
                            ).format(
                              opportunity.startTime,
                            ),
                          ),
                        ],
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
