import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:intheloopapp/ui/themes.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.backgroundImageUrl,
    this.verified,
    this.radius,
    this.minRadius,
    this.maxRadius,
  });

  final String? backgroundImageUrl;
  final bool? verified;
  final double? radius;
  final double? minRadius;
  final double? maxRadius;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.bottomEnd(end: -5, bottom: -4),
      badgeContent: const Icon(
        Icons.check,
        color: Colors.white,
        size: 10,
      ),
      showBadge: verified ?? false,
      badgeStyle: const badges.BadgeStyle(
        shape: badges.BadgeShape.twitter,
        badgeColor: tappedAccent,
      ),
      child: CircleAvatar(
        radius: radius,
        minRadius: minRadius,
        maxRadius: maxRadius,
        backgroundImage:
            (backgroundImageUrl == null || backgroundImageUrl!.isEmpty)
                ? const AssetImage('assets/default_avatar.png') as ImageProvider
                : CachedNetworkImageProvider(
                    backgroundImageUrl!,
                  ),
      ),
    );
  }
}
