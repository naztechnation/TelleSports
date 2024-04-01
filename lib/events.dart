import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/widgets/modals.dart';

import 'core/app_export.dart';
import 'model/matches_data/fixtues_stats.dart';
import 'model/view_models/match_viewmodel.dart';

class FixtureEvents extends StatelessWidget {

  final String homeTeam;

  const FixtureEvents({super.key, required this.homeTeam});
  @override
  Widget build(BuildContext context) {

    final event =
        Provider.of<MatchViewModel>(context, listen: true).fixtureEvents;

    return (event.isEmpty)
        ? Align(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.16,),
                Icon(
                  Icons.calendar_month,
                  size: 52,
                  color: Colors.deepOrangeAccent[400],
                ),
                Text(
                  'No Events',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
        )
        : buildEventsList(event);
  }

  Widget buildEventsList(List<Events> events) {
    return Expanded(
      child: ListView.builder(
        itemCount: events.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: events[index].assist!.id == null &&
                          events[index].type != 'subst'
                      ? buildEventHead(events[index], context)
                      // subst event
                      : _buildTimeline(
                        context,
                        title:
                            "In: ${events[index].player?.name ?? ''}",
                        description:
                            (events[index].assist != null) ? "Out: ${events[index].assist?.name ?? ''}" : "",
                        televisionImage: ImageConstant.imgLeftIconRed400,
                        description1:
                            "${events[index].time?.elapsed}’", homeTeams: events[index].team?.name ?? '',
                      ),
                ),
              ),
             // Text(events[index].team?.name ?? '')
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimeline(
    BuildContext context, {
    required String title,
    required String description,
    required String televisionImage,
    required String description1,
    required String homeTeams,
  }) {
     
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0),
      child: Row(
        mainAxisAlignment:  (homeTeam == homeTeams) ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: (homeTeam == homeTeams) ?CrossAxisAlignment.end :CrossAxisAlignment.end,
        children: [

           if(homeTeam != homeTeams)     Padding(
            padding: EdgeInsets.only(
              right: 25.h,
              top: 2.v,
            ),
            child: Column(
              children: [
                CustomImageView(
                  imagePath: televisionImage,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                ),
                SizedBox(height: 5.v),
                Text(
                  description1,
                  style: theme.textTheme.labelMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 3.v),
               
              ],
            ),
          ),
      
          
          Padding(
            padding: EdgeInsets.only(bottom: 8.v),
            child: Column(
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 1.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    description,
                    style: CustomTextStyles.labelMediumGray700.copyWith(
                      color: appTheme.gray700,
                    ),
                  ),
                ),
      
                 Text(
                  homeTeams,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                
                Text(
                  (homeTeam == homeTeams).toString(),
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
      if(homeTeam == homeTeams)     Padding(
            padding: EdgeInsets.only(
              left: 25.h,
              top: 2.v,
            ),
            child: Column(
              children: [
                CustomImageView(
                  imagePath: televisionImage,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                ),
                SizedBox(height: 5.v),
                Text(
                  description1,
                  style: theme.textTheme.labelMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 3.v),
               
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEventHead(Events event, BuildContext context) {
    switch (event.type?.toLowerCase()) {
      case 'card':
        return _buildTimeline(
          context,
          title: event.player?.name ?? '',
          description: "",
          televisionImage: event.detail == 'Yellow Card'
              ? ImageConstant.imgTelevision
              : ImageConstant.imgTelevisionRed400,
          description1: "${event.time?.elapsed}’",
          homeTeams: event.team?.name ?? ''
        );

      case 'normal goal':
      case 'goal':
        return _buildTimeline(
          context,
          title:"Goal: ${ event.player?.name ?? ''}",
          description: event.assist?.name != null ? "Assist: ${ event.assist?.name ?? ''}": '',
          televisionImage: ImageConstant
                                                .imgLeftIconWhiteA700,
          description1: "${event.time?.elapsed}’",
                      homeTeams: event.team?.name ?? ''
        
        );

      case 'own goal':
        return _buildTimeline(
          context,
          title:"Scored: ${ event.player?.name ?? ''}",
          description: event.assist?.name != null ? "Assist: ${ event.assist?.name ?? ''}": '',
          televisionImage: ImageConstant.imgLeftIconWhiteA70016x16,
          description1: "${event.time?.elapsed}’",
          homeTeams: event.team?.name ?? ''
        
        );
//
      case 'penalty':
        return _buildTimeline(
          context,
          title:"Scored: ${ event.player?.name ?? ''}",
          description: event.assist?.name != null ? "Assist: ${ event.assist?.name ?? ''}": '',
          televisionImage: ImageConstant.imgLeftIcon16x16,
          description1: "${event.time?.elapsed}’",
          homeTeams: event.team?.name ?? ''
        
        );

      case 'missed penalty':
        return _buildTimeline(
          context,
          title:"Missed: ${ event.player?.name ?? ''}",
          description: event.assist?.name != null ? "Assist: ${ event.assist?.name ?? ''}": '',
          televisionImage: ImageConstant.imgLeftIcon1,
          description1: "${event.time?.elapsed}’",
          homeTeams: event.team?.name ?? ''
        
        );
    }
    return Container();
  }
}
