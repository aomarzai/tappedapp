import 'package:intheloopapp/domains/models/opportunity.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/domains/models/user_model.dart';

abstract class DeepLinkRepository {
  Stream<DeepLinkRedirect> getDeepLinks();
  Future<String> getShareProfileDeepLink(UserModel user);
  Future<String> getShareOpportunityDeepLink(Opportunity opportunity);
}

enum DeepLinkType {
  shareProfile,
  shareOpportunity,
  connectStripeRedirect,
  connectStripeRefresh,
}

sealed class DeepLinkRedirect {
  const DeepLinkRedirect({
    required this.type,
  });

  final DeepLinkType type;
}

final class ShareProfileDeepLink extends DeepLinkRedirect {
  const ShareProfileDeepLink({
    required this.userId,
    required this.user,
  }) : super(type: DeepLinkType.shareProfile);

  final String userId;
  final Option<UserModel> user;
}

final class ShareOpportunityDeepLink extends DeepLinkRedirect {
  const ShareOpportunityDeepLink({
    required this.opportunityId,
    required this.opportunity,
  }) : super(type: DeepLinkType.shareOpportunity);

  final String opportunityId;
  final Option<Opportunity> opportunity;
}

final class ConnectStripeRedirectDeepLink extends DeepLinkRedirect {
  const ConnectStripeRedirectDeepLink({
    required this.id,
  })
      : super(
          type: DeepLinkType.connectStripeRedirect,
        );
      
  final String id;
}
