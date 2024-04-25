import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/events.dart';

import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_six.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_three.dart';
import 'package:tellesports/widgets/app_bar/appbar_trailing_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';

import '../../blocs/matches/match.dart';
import '../../model/matches_data/fixtues_stats.dart';
import '../../model/view_models/match_viewmodel.dart';
import '../../requests/repositories/matches_repository/match_repository_impl.dart';
import '../../utils/app_utils.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';


class ViewLivescoresDetailsScreen extends StatelessWidget {
  final String leagueId;
  final String homeTeamId;
  final String awayTeamId;
  const ViewLivescoresDetailsScreen(
      {Key? key,
      required this.leagueId,
      required this.homeTeamId,
      required this.awayTeamId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MatchCubit>(
      create: (BuildContext context) => MatchCubit(
          matchRepository: MatchRepositoryImpl(),
          viewModel: Provider.of<MatchViewModel>(context, listen: false)),
      child: ViewLivescoresDetails(
          leagueId: leagueId, homeTeamId: homeTeamId, awayTeamId: awayTeamId),
    );
  }
}
class ViewLivescoresDetails extends StatefulWidget {

   final String leagueId;
  final String homeTeamId;
  final String awayTeamId;
  ViewLivescoresDetails({Key? key,
  required this.leagueId,
      required this.homeTeamId,
      required this.awayTeamId
  })
      : super(
          key: key,
        );

  @override
  State<ViewLivescoresDetails> createState() => _ViewLivescoresDetailsState();
}

class _ViewLivescoresDetailsState extends State<ViewLivescoresDetails> {

   late MatchCubit _matchCubit;
  late Size size;
  List<Response> fixturesLists = [];
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _asyncInitMethod();
    super.initState();
  }

  void _asyncInitMethod() {
    _matchCubit = context.read<MatchCubit>();
    _matchCubit.getFixturesById(searchParameter: widget.leagueId);
  }
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

   

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<MatchCubit, MatchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MatchLoading) {
              return Container(
                  color: Colors.white,
                  height: AppUtils.deviceScreenSize(context).height,
                  width: AppUtils.deviceScreenSize(context).width,
                  child: const LoadingPage(length: 20));
            } else if (state is MatchNetworkErr) {
              return EmptyWidget(
                title: 'Network error',
                description: state.message,
                onRefresh: () => _matchCubit.getFixturesById(
                    searchParameter: widget.leagueId),
              );
            } else if (state is MatchApiErr) {
              return EmptyWidget(
                title: 'Network error',
                description: state.message,
                onRefresh: () => _matchCubit.getFixturesById(
                    searchParameter: widget.leagueId),
              );
            }
            fixturesLists = _matchCubit.viewModel.fixtureStatistics;
              
           return SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                 SizedBox(height: 10.v),
                    _buildTopnavMatchDetails(context),
                    
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                     
                        if(fixturesLists.first.fixture?.status?.short == 'FT') CustomImageView(
                                        imagePath: ImageConstant.imgUser,
                                        height: 24.adaptSize,
                                        width: 24.adaptSize,
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(height: 15,),
                                   if(fixturesLists.first.fixture?.status?.short == 'FT')   _buildTimeline(context,title: 'FT',description: '${fixturesLists.first.score?.fulltime?.home} - ${fixturesLists.first.score?.fulltime?.away}'),
                    
                      SizedBox(height: 16.v),
                    
                      FixtureEvents(homeTeam: fixturesLists.first.teams?.home?.name ?? '',),
                      SizedBox(height: 16.v),
                      
                      if(fixturesLists.first.fixture?.status?.short != 'NS') CustomImageView(
                                        imagePath: ImageConstant.imgUser,
                                        height: 24.adaptSize,
                                        width: 24.adaptSize,
                                        alignment: Alignment.center,
                                      ),
                 SizedBox(height: 10.v),

                      
                      // Expanded(
                      //   child: SingleChildScrollView(
                      //     child: Padding(
                      //       padding: EdgeInsets.only(bottom: 5.v),
                      //       child: Column(
                      //         children: [
                      //           Container(
                      //             padding: EdgeInsets.symmetric(
                      //               horizontal: 8.h,
                      //               vertical: 6.v,
                      //             ),
                      //             decoration: AppDecoration.fillWhiteA.copyWith(
                      //               borderRadius: BorderRadiusStyle.roundedBorder4,
                      //             ),
                      //             child: Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 CustomImageView(
                      //                   imagePath: ImageConstant.imgUser,
                      //                   height: 24.adaptSize,
                      //                   width: 24.adaptSize,
                      //                   alignment: Alignment.center,
                      //                 ),
                      //                 SizedBox(height: 6.v),
                      //                 _buildContent(context),
                      //                 CustomImageView(
                      //                   imagePath: ImageConstant.imgTail,
                      //                   height: 16.v,
                      //                   width: 24.h,
                      //                   alignment: Alignment.center,
                      //                 ),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(left: 55.h),
                      //                   child: Row(
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     children: [
                      //                       Padding(
                      //                         padding: EdgeInsets.only(bottom: 19.v),
                      //                         child: Column(
                      //                           children: [
                      //                             Align(
                      //                               alignment: Alignment.centerRight,
                      //                               child: Text(
                      //                                 "In: Pable Rosario",
                      //                                 style: theme.textTheme.labelLarge,
                      //                               ),
                      //                             ),
                      //                             SizedBox(height: 1.v),
                      //                             Text(
                      //                               "Out: Hicham Boudaoui",
                      //                               style: CustomTextStyles
                      //                                   .labelMediumGray700,
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                       Padding(
                      //                         padding: EdgeInsets.only(
                      //                           left: 18.h,
                      //                           top: 2.v,
                      //                         ),
                      //                         child: _buildTail(
                      //                           context,
                      //                           leftIcon: ImageConstant.imgLeftIcon,
                      //                           description: "86’",
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 3.v),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(left: 51.h),
                      //                   child: _buildTimeline(
                      //                     context,
                      //                     title: "In: Evann Guessand",
                      //                     description: "Out: Gaetan Laborde",
                      //                     televisionImage: ImageConstant.imgLeftIcon,
                      //                     description1: "86’",
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 4.v),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(right: 31.h),
                      //                   child: _buildTimeline2(
                      //                     context,
                      //                     description: "84’",
                      //                     title: "In: Marvin Sanaya",
                      //                     description1: "Out: Loubadhe Abakar Sylla",
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 3.v),
                      //                 Align(
                      //                   alignment: Alignment.centerRight,
                      //                   child: Padding(
                      //                     padding: EdgeInsets.only(right: 65.h),
                      //                     child: Row(
                      //                       mainAxisAlignment: MainAxisAlignment.end,
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Padding(
                      //                           padding: EdgeInsets.only(top: 2.v),
                      //                           child: _buildTail(
                      //                             context,
                      //                             leftIcon: ImageConstant.imgTelevision,
                      //                             description: "84’",
                      //                           ),
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                             left: 18.h,
                      //                             bottom: 19.v,
                      //                           ),
                      //                           child: Column(
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               Text(
                      //                                 "Ibrahima Sissoko",
                      //                                 style: theme.textTheme.labelLarge,
                      //                               ),
                      //                               SizedBox(height: 1.v),
                      //                               Text(
                      //                                 "Foul",
                      //                                 style: CustomTextStyles
                      //                                     .labelMediumGray700,
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 3.v),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(left: 51.h),
                      //                   child: _buildTimeline(
                      //                     context,
                      //                     title: "In: Evann Guessand",
                      //                     description: "Out: Gaetan Laborde",
                      //                     televisionImage:
                      //                         ImageConstant.imgTelevisionRed400,
                      //                     description1: "83’",
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 3.v),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(left: 51.h),
                      //                   child: _buildTimeline(
                      //                     context,
                      //                     title: "In: Evann Guessand",
                      //                     description: "Out: Gaetan Laborde",
                      //                     televisionImage: ImageConstant.imgLeftIcon,
                      //                     description1: "82’",
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 3.v),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(left: 51.h),
                      //                   child: Row(
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     children: [
                      //                       Padding(
                      //                         padding: EdgeInsets.only(bottom: 39.v),
                      //                         child: _buildTimeline1(
                      //                           context,
                      //                           titleText: "In: Evann Guessandd",
                      //                           descriptionText: "Out: Gaetan Laborde",
                      //                         ),
                      //                       ),
                      //                       Padding(
                      //                         padding: EdgeInsets.only(
                      //                           left: 11.h,
                      //                           top: 2.v,
                      //                         ),
                      //                         child: Column(
                      //                           children: [
                      //                             CustomImageView(
                      //                               imagePath: ImageConstant
                      //                                   .imgLeftIconWhiteA700,
                      //                               height: 16.adaptSize,
                      //                               width: 16.adaptSize,
                      //                             ),
                      //                             SizedBox(height: 5.v),
                      //                             Text(
                      //                               "77’",
                      //                               style: theme.textTheme.labelMedium,
                      //                             ),
                      //                             SizedBox(height: 3.v),
                      //                             Container(
                      //                               width: 29.h,
                      //                               padding: EdgeInsets.symmetric(
                      //                                 horizontal: 6.h,
                      //                                 vertical: 1.v,
                      //                               ),
                      //                               decoration:
                      //                                   AppDecoration.fillRed.copyWith(
                      //                                 borderRadius: BorderRadiusStyle
                      //                                     .roundedBorder8,
                      //                               ),
                      //                               child: Text(
                      //                                 "2-0",
                      //                                 style: CustomTextStyles
                      //                                     .bodySmallInterOnPrimaryContainer,
                      //                               ),
                      //                             ),
                      //                             SizedBox(height: 4.v),
                      //                             CustomImageView(
                      //                               imagePath: ImageConstant.imgTail,
                      //                               height: 10.v,
                      //                               width: 1.h,
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 3.v),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(left: 51.h),
                      //                   child: _buildTimeline(
                      //                     context,
                      //                     title: "In: Evann Guessand",
                      //                     description: "Out: Gaetan Laborde",
                      //                     televisionImage: ImageConstant.imgLeftIcon,
                      //                     description1: "68’",
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 4.v),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(right: 31.h),
                      //                   child: _buildTimeline2(
                      //                     context,
                      //                     description: "64’",
                      //                     title: "In: Marvin Sanaya",
                      //                     description1: "Out: Loubadhe Abakar Sylla",
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 4.v),
                      //                 _buildContent1(context),
                      //                 CustomImageView(
                      //                   imagePath: ImageConstant.imgTail,
                      //                   height: 16.v,
                      //                   width: 24.h,
                      //                   alignment: Alignment.center,
                      //                 ),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(left: 51.h),
                      //                   child: Row(
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     children: [
                      //                       Padding(
                      //                         padding: EdgeInsets.only(bottom: 39.v),
                      //                         child: _buildTimeline1(
                      //                           context,
                      //                           titleText: "In: Evann Guessand",
                      //                           descriptionText: "Out: Gaetan Laborde",
                      //                         ),
                      //                       ),
                      //                       Padding(
                      //                         padding: EdgeInsets.only(
                      //                           left: 12.h,
                      //                           top: 2.v,
                      //                         ),
                      //                         child: Column(
                      //                           children: [
                      //                             CustomImageView(
                      //                               imagePath: ImageConstant
                      //                                   .imgLeftIconWhiteA700,
                      //                               height: 16.adaptSize,
                      //                               width: 16.adaptSize,
                      //                             ),
                      //                             SizedBox(height: 5.v),
                      //                             Text(
                      //                               "45+2’",
                      //                               style: theme.textTheme.labelMedium,
                      //                             ),
                      //                             SizedBox(height: 3.v),
                      //                             Container(
                      //                               width: 28.h,
                      //                               padding: EdgeInsets.symmetric(
                      //                                 horizontal: 6.h,
                      //                                 vertical: 1.v,
                      //                               ),
                      //                               decoration:
                      //                                   AppDecoration.fillRed.copyWith(
                      //                                 borderRadius: BorderRadiusStyle
                      //                                     .roundedBorder8,
                      //                               ),
                      //                               child: Text(
                      //                                 "1-0",
                      //                                 style: CustomTextStyles
                      //                                     .bodySmallInterOnPrimaryContainer,
                      //                               ),
                      //                             ),
                      //                             SizedBox(height: 4.v),
                      //                             CustomImageView(
                      //                               imagePath: ImageConstant.imgTail,
                      //                               height: 10.v,
                      //                               width: 1.h,
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 3.v),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(left: 51.h),
                      //                   child: _buildTimeline(
                      //                     context,
                      //                     title: "In: Evann Guessand",
                      //                     description: "Out: Gaetan Laborde",
                      //                     televisionImage: ImageConstant.imgTelevision,
                      //                     description1: "6’",
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 10.v),
                      //                 CustomImageView(
                      //                   imagePath: ImageConstant.imgUser,
                      //                   height: 24.adaptSize,
                      //                   width: 24.adaptSize,
                      //                   alignment: Alignment.center,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           SizedBox(height: 16.v),
                      //           _buildLegend(context),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
          }),
         bottomNavigationBar: _buildLegend(context),
      ),
    );
  }

  Widget _buildTopnavMatchDetails(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillWhiteA,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 6.v),
          CustomAppBar(
            height: 60.v,
            leadingWidth: 44.h,
            leading: AppbarLeadingImage(
              onTap: (){
                Navigator.pop(context);
              },
              imagePath: ImageConstant.imgArrowBack,
              margin: EdgeInsets.only(
                left: 20.h,
                top: 3.v,
                bottom: 5.v,
              ),
            ),
            centerTitle: true,
            title: Column(
              children: [
                AppbarSubtitleThree(
                  text: fixturesLists.first.league?.name ?? '',
                ),
                AppbarSubtitleSix(
                  text: AppUtils.formatComplexDate(dateTime: fixturesLists.first.fixture?.date ?? ''),
                  margin: EdgeInsets.symmetric(horizontal: 5.h),
                ),
              ],
            ),
            actions: [
              // AppbarTrailingImage(
              //   imagePath: ImageConstant.imgShare,
              //   margin: EdgeInsets.fromLTRB(20.h, 3.v, 20.h, 5.v),
              // ),
            ],
          ),
          SizedBox(height: 3.v),
          Container(
            width: double.infinity,
            decoration: AppDecoration.fillDeeporange50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColumn(
                  context,
                  screenNameText: fixturesLists.first.teams?.home?.name ?? '',
                  signalImage: fixturesLists.first.teams?.home?.logo ?? '',
                ),
                const SizedBox(width: 12,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.v),
                  child: Column(
                    children: [
                      Text(
                        "Full Time",
                        style: CustomTextStyles.labelMediumGray700,
                      ),
                      Text(
                       (fixturesLists.first.score?.fulltime?.home == null) ? "NS": "${fixturesLists.first.score?.fulltime?.home.toString() ?? ''} : ${fixturesLists.first.score?.fulltime?.away.toString() ?? ''}",
                        style: CustomTextStyles.titleMediumGray800,
                      ),
                      Text(
                      (fixturesLists.first.score?.halftime?.home == null) ? "":  "HT ${fixturesLists.first.score?.halftime?.home.toString() ?? ''} : ${fixturesLists.first.score?.halftime?.away.toString() ?? ''}",
                        style: CustomTextStyles.labelMediumGray700,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12,),

                _buildColumn(
                  context,
                  screenNameText: fixturesLists.first.teams?.away?.name ?? '',
                  signalImage: fixturesLists.first.teams?.away?.logo ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 
  Widget _buildLegend(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 120,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 15.v,
      ),
      decoration: AppDecoration.fillRed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLeftIconRed400,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
                          SizedBox(width: 6),

              Text(
                "Substitution",
                style: theme.textTheme.labelMedium,
              ),
          SizedBox(width: 12),

              CustomImageView(
                imagePath: ImageConstant.imgTelevisionRed400,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
                          SizedBox(width: 6),

              Text(
                "Red Card",
                style: theme.textTheme.labelMedium,
              ),
          SizedBox(width: 12),

              CustomImageView(
                imagePath: ImageConstant.imgTelevision,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
                          SizedBox(width: 6),
              
              Text(
                "Yellow Card",
                style: theme.textTheme.labelMedium,
              ),
          SizedBox(width: 12),

              CustomImageView(
                imagePath: ImageConstant.imgClose,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
                          SizedBox(width: 6),

              Text(
                "Corner",
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
          SizedBox(height: 10.v),
          Wrap(
            children: [
              CustomImageView(
                    imagePath: ImageConstant.imgLeftIconWhiteA700,
                    height: 16.adaptSize,
                    width: 16.adaptSize,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Goal",
                    style: theme.textTheme.labelMedium,
                  ),
          SizedBox(width: 12),

                   CustomImageView(
                          imagePath: ImageConstant.imgLeftIconWhiteA70016x16,
                          height: 16.adaptSize,
                          width: 16.adaptSize,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Own-goal",
                          style: theme.textTheme.labelMedium,
                        ),
          SizedBox(width: 12),

                        CustomImageView(
                              imagePath: ImageConstant.imgLeftIcon16x16,
                              height: 16.adaptSize,
                              width: 16.adaptSize,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Penalty",
                              style: theme.textTheme.labelMedium,
                            ),
          SizedBox(width: 12),

              CustomImageView(
                            imagePath: ImageConstant.imgLeftIcon1,
                            height: 16.adaptSize,
                            width: 16.adaptSize,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Penalty Missed",
                            style: theme.textTheme.labelMedium,
                          ),
            ],
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildColumn(
    BuildContext context, {
    required String screenNameText,
    required String signalImage,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 8.v,
        ),
        decoration: AppDecoration.fillRed,
        child: Column(
          children: [
            CustomImageView(
              imagePath: signalImage,
              height: 40.adaptSize,
              width: 40.adaptSize,
            ),
            SizedBox(height: 3.v),
            Text(
              screenNameText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.titleSmallBluegray900.copyWith(
                color: appTheme.blueGray900,
              ),
            ),
            SizedBox(height: 3.v),
            // CustomImageView(
            //   imagePath: signalImage,
            //   height: 16.adaptSize,
            //   width: 16.adaptSize,
            // ),
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildTail(
    BuildContext context, {
    required String leftIcon,
    required String description,
  }) {
    return Column(
      children: [
        CustomImageView(
          imagePath: leftIcon,
          height: 16.adaptSize,
          width: 16.adaptSize,
        ),
        SizedBox(height: 5.v),
        Text(
          description,
          style: theme.textTheme.labelMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: 3.v),
        CustomImageView(
          imagePath: ImageConstant.imgTail,
          height: 10.v,
          width: 1.h,
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildTimeline(
    BuildContext context, {
    required String title,
    required String description,
   
  }) {
    return Container(
      height: 43,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(

      color: Colors.red,
      borderRadius: BorderRadius.circular(8)

      ),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
                  title,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(width: 10.v),
                Text(
                  description,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
          
        ],
      ),
    );
  }

}