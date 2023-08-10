import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/data/places_repository.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/onboarding_bloc/onboarding_bloc.dart';
import 'package:intheloopapp/ui/error/error_view.dart';
import 'package:intheloopapp/ui/loading/loading_view.dart';
import 'package:intheloopapp/ui/profile/components/bookings_sliver.dart';
import 'package:intheloopapp/ui/profile/components/header_sliver.dart';
import 'package:intheloopapp/ui/profile/components/info_sliver.dart';
import 'package:intheloopapp/ui/profile/components/loops_sliver.dart';
import 'package:intheloopapp/ui/profile/components/opportunity_sliver.dart';
import 'package:intheloopapp/ui/profile/components/reviews_sliver.dart';
import 'package:intheloopapp/ui/profile/components/services_sliver.dart';
import 'package:intheloopapp/ui/profile/profile_cubit.dart';
import 'package:intheloopapp/ui/themes.dart';
import 'package:intheloopapp/ui/user_avatar.dart';
import 'package:intheloopapp/ui/user_card.dart';

import '../../domains/navigation_bloc/tapped_route.dart';

class ProfileView extends StatelessWidget {
  ProfileView({
    required this.visitedUserId,
    required this.visitedUser,
    this.collapsedBarHeight = 60.0,
    this.expandedBarHeight = 300.0,
    super.key,
  });

  final String visitedUserId;
  final double collapsedBarHeight;
  final double expandedBarHeight;

  final scrollController = ScrollController();

  // callers can provide a user to avoid a database call
  final Option<UserModel> visitedUser;

  Widget _profilePage(
    UserModel currentUser,
    UserModel visitedUser,
    DatabaseRepository databaseRepository,
    PlacesRepository places,
  ) =>
      BlocProvider(
        create: (context) => ProfileCubit(
          places: places,
          databaseRepository: databaseRepository,
          currentUser: currentUser,
          visitedUser: visitedUser,
        )
          ..getLatestLoop()
          ..getLatestOpportunity()
          ..getLatestBooking()
          ..getLatestReview()
          ..initBadges()
          ..initServices()
          ..loadIsFollowing(currentUser.id, visitedUser.id)
          ..loadIsBlocked()
          ..loadIsVerified(visitedUser.id)
          ..initPlace(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return BlocListener<OnboardingBloc, OnboardingState>(
              listener: (context, userState) {
                if (userState is Onboarded) {
                  if (userState.currentUser.id == visitedUser.id) {
                    context
                        .read<ProfileCubit>()
                        .refetchVisitedUser(newUserData: userState.currentUser);
                  }
                }
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) =>
                    context.read<ProfileCubit>().onNotification(
                          scrollController,
                          expandedBarHeight,
                          collapsedBarHeight,
                        ),
                child: CustomScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: state.isBlocked
                      ? _blockedSlivers(
                          context,
                          state,
                          currentUser,
                          visitedUser,
                        )
                      : _unblockedSlivers(
                          context,
                          state,
                          currentUser,
                          visitedUser,
                        ),
                ),
              ),
            );
          },
        ),
      );

  List<Widget> _unblockedSlivers(
    BuildContext context,
    ProfileState state,
    UserModel currentUser,
    UserModel visitedUser,
  ) =>
      [
        SliverAppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          expandedHeight: expandedBarHeight,
          collapsedHeight: collapsedBarHeight,
          pinned: true,
          stretch: true,
          onStretchTrigger: () async {
            final cubit = context.read<ProfileCubit>();
            await Future.wait([
              HapticFeedback.mediumImpact(),
              cubit.getLatestLoop(),
              cubit.getLatestOpportunity(),
              cubit.getLatestBooking(),
              cubit.getLatestReview(),
              cubit.initBadges(),
              cubit.initServices(),
              cubit.refetchVisitedUser(),
              cubit.loadIsFollowing(currentUser.id, visitedUser.id),
              cubit.loadIsVerified(visitedUser.id),
            ]);
          },
          // automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            titlePadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            centerTitle: false,
            title: Text.rich(
              TextSpan(
                text: visitedUser.displayName,
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
                children: [
                  if (state.isVerified)
                    const WidgetSpan(
                      child: Icon(
                        Icons.verified,
                        size: 18,
                        color: tappedAccent,
                      ),
                      alignment: PlaceholderAlignment.middle,
                    ),
                ],
              ),
              overflow: TextOverflow.fade,
              maxLines: 2,
            ),
            background: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (visitedUser.profilePicture == null)
                      ? const AssetImage(
                          'assets/default_avatar.png',
                        ) as ImageProvider
                      : CachedNetworkImageProvider(
                          visitedUser.profilePicture!,
                        ),
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: HeaderSliver(),
        ),
        //const
        const SliverToBoxAdapter(
          child: SizedBox(height: 8),
        ),
         SliverToBoxAdapter(
          
            child:
               
                  GestureDetector(
                    onTap: () => context.push(
              FollowRelationshipPage(
                userId: state.visitedUser.id,
                index: 0,
              ),),
                    child: _displayCommonFollowers(
                    context, 
                    currentUser, 
                    visitedUser,),
                  ),
               
                //Text('what'),
            
          ), 
          //put method here
        
        
        const SliverToBoxAdapter(
          child: ServicesSliver(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 12),
        ),
        const SliverToBoxAdapter(
          child: ReviewsSliver(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 12),
        ),
        const SliverToBoxAdapter(
          child: BookingsSliver(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 18),
        ),
        const SliverToBoxAdapter(
          child: OpportunitySliver(),
        ),
        const SliverToBoxAdapter(
          child: LoopsSliver(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 18),
        ),
        const SliverToBoxAdapter(
          child: InfoSliver(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 50,
          ),
        ),
      ];

  List<Widget> _blockedSlivers(
    BuildContext context,
    ProfileState state,
    UserModel currentUser,
    UserModel visitedUser,
  ) =>
      [
        SliverAppBar(
          expandedHeight: expandedBarHeight,
          collapsedHeight: collapsedBarHeight,
          pinned: true,
          stretch: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          onStretchTrigger: () async {
            final cubit = context.read<ProfileCubit>();
            await Future.wait([
              cubit.getLatestLoop(),
              cubit.getLatestOpportunity(),
              cubit.getLatestBooking(),
              cubit.initBadges(),
              cubit.initServices(),
              cubit.refetchVisitedUser(),
              cubit.loadIsFollowing(currentUser.id, visitedUser.id),
              cubit.loadIsVerified(visitedUser.id),
            ]);
          },
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            titlePadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            centerTitle: false,
            title: Text.rich(
              TextSpan(
                text: visitedUser.artistName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
                children: [
                  if (state.isVerified)
                    const WidgetSpan(
                      child: Icon(
                        Icons.verified,
                        size: 18,
                        color: tappedAccent,
                      ),
                      alignment: PlaceholderAlignment.middle,
                    )
                  else
                    const WidgetSpan(
                      child: SizedBox.shrink(),
                    ),
                ],
              ),
              overflow: TextOverflow.fade,
              maxLines: 2,
            ),
            background: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (visitedUser.profilePicture == null)
                      ? const AssetImage(
                          'assets/default_avatar.png',
                        ) as ImageProvider
                      : CachedNetworkImageProvider(
                          visitedUser.profilePicture!,
                        ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Blocked',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'You have blocked this user, and they cannot see your profile.',
                textAlign: TextAlign.center,
              ),
              FilledButton(
                onPressed: () => context.read<ProfileCubit>().unblock(),
                child: const Text('Unblock'),
              ),
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final databaseRepository =
        RepositoryProvider.of<DatabaseRepository>(context);
    final places = RepositoryProvider.of<PlacesRepository>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        // selector: (state) => (state is Onboarded) ? state.currentUser : null,
        buildWhen: (previous, current) {
          if (previous is Onboarded && current is Onboarded) {
            return previous.currentUser.id != current.currentUser.id;
          }

          return true;
        },
        builder: (context, state) {
          final currentUser = (state is Onboarded) ? state.currentUser : null;
          if (currentUser == null) {
            return const ErrorView();
          }

          return switch ((visitedUser, currentUser.id == visitedUserId)) {
            (_, true) => _profilePage(
                currentUser,
                currentUser,
                databaseRepository,
                places,
              ),
            (None(), false) => FutureBuilder<Option<UserModel>>(
                future: databaseRepository.getUserById(visitedUserId),
                builder: (context, snapshot) {
                  final user = snapshot.data;

                  return switch (user) {
                    null => const LoadingView(),
                    None() => const LoadingView(),
                    Some(:final value) => _profilePage(
                        currentUser,
                        value,
                        databaseRepository,
                        places,
                      ),
                  };
                },
              ),
            (Some(:final value), false) => _profilePage(
                currentUser,
                value,
                databaseRepository,
                places,
              ),
          };
        },
      ),
    );
  }

Widget _displayCommonFollowers (BuildContext context, UserModel currentUser, UserModel visitedUser)  {
    
    
    final databaseRepository =
        RepositoryProvider.of<DatabaseRepository>(context);
        return Container(
          child: FutureBuilder(
              future: databaseRepository.getCommonFollowers(currentUser.id, visitedUser.id),
              builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return SizedBox.shrink();
            //return CircularProgressIndicator();
            }
          else{
          final feaUsers = snapshot.data ?? [];
          return switch(feaUsers.length){
          0 => SizedBox.shrink(),
          >0  =>   listAvatar(context, feaUsers),
                    
           /*
           1 => Row(children: [getAvatar(feaUsers[0])]),
           2 => Row(
             children: [
               getAvatar(feaUsers[0]),
               getAvatar(feaUsers[1]),
             ],
           ),
           >3 => Row(
             children: [
               getAvatar(feaUsers[0]),
               getAvatar(feaUsers[1]),
               getAvatar(feaUsers[2]),
             ],),
           */  
           _ => SizedBox.shrink(),
          /* 
          0 => CircularProgressIndicator(),
           1 => Text(feaUsers[0].username.toString()),
           2 => Text(feaUsers[0].username.toString() + feaUsers[1].username.toString()),
           >3 => Text(feaUsers[0].username.toString() + feaUsers[1].username.toString() + feaUsers[2].username.toString()),
           _ => Text(feaUsers.length.toString()),
           */
          };
          }
              },
            ),
        );
    return Text('PROMBLEM');
    /*return Column(
      children: [Text('followed by: '),
        Transform.scale(
        scale: .5,
        child:
            Row(
              children: [
                
              UserCard(user: currentUser), 
              UserCard(user: visitedUser),],),
          
        ),],
    );*/ 
    /*
        Future<List<UserModel>> commons = await databaseRepository.getCommonFollowers(currentUser.id, visitedUser.id);*/

}
Widget getAvatar(BuildContext context, UserModel user){
  return Container(
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(17)
    ),
    child: UserAvatar(
      radius: 14,
      pushUser: Some(user),
      imageUrl: user.profilePicture,
      ),
  );
}

Widget listAvatar(BuildContext context, List<UserModel> users){
  List<UserModel> Dusers;
  List<Widget> result = [];
  if(users.length > 3) {
    Dusers = users.sublist(0, 3);
    }else {
    Dusers = users;
    }
    for(int i = 0; i < Dusers.length; i++){
    result.add(Padding(
      padding: EdgeInsets.only(left: i*20), 
      child: getAvatar(context, Dusers[i])
      ));
  }
  if(users.length > 3){
     var r = users.length - 3;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Followed by: '), 
      Stack(children: result), 
      Text('and ' + r.toString() + ' others') ]
       );
       }
  else{
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Followed by: '), Stack(children: result), ] );
    }
}

}
