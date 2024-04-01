import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';

import '../../blocs/matches/match.dart';
import '../../model/matches_data/match_fixtures.dart' as fixture;
import '../../model/view_models/match_viewmodel.dart';
import '../../requests/repositories/matches_repository/match_repository_impl.dart';
import '../../utils/app_utils.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';
import '../view_livescoresone_page/widgets/matchcard_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

import 'view_livescores_details_screen.dart';

class ViewLivescoresPage extends StatelessWidget {
  final String? leagueId;
  final String? startSeason;
  final String? endSeason;
  final String? year;
  const ViewLivescoresPage(
      {Key? key,
      this.leagueId = '',
      this.startSeason = '',
      this.year = '',
      this.endSeason = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MatchCubit>(
      create: (BuildContext context) => MatchCubit(
          matchRepository: MatchRepositoryImpl(),
          viewModel: Provider.of<MatchViewModel>(context, listen: false)),
      child: ViewLivescores(
        leagueId: leagueId,
        startSeason: startSeason,
        endSeason: endSeason,
        year: year,
      ),
    );
  }
}

class ViewLivescores extends StatefulWidget {
  final String? leagueId;
  final String? startSeason;
  final String? endSeason;
  final String? year;
  const ViewLivescores(
      {Key? key,
      this.leagueId = '',
      this.startSeason = '',
      this.year = '',
      this.endSeason = ''})
      : super(key: key);

  @override
  ViewLivescoresState createState() => ViewLivescoresState();
}

class ViewLivescoresState extends State<ViewLivescores>
    with AutomaticKeepAliveClientMixin<ViewLivescores> {
  @override
  bool get wantKeepAlive => true;

  late MatchCubit _matchCubit;
  String searchParameter = '';
  String todaysDate = '';

  String liveAll = 'live=all';
  var now = DateTime.now();

  List<fixture.Response> fixtures = [];

  @override
  void initState() {
    todaysDate = DateFormat('yyyy-MM-dd').format(now);

    searchParameter = todaysDate;
    _asyncInitMethod();
    super.initState();
  }

  void _asyncInitMethod() {
    _matchCubit = context.read<MatchCubit>();
    checkLeagueStatus(widget.leagueId!);
  }

  checkLeagueStatus(String leagueId) {
    if (leagueId == '') {
      searchParameter = 'date=$todaysDate';

      _matchCubit.getMatchFixtures(searchParameter: searchParameter);
    } else {
      _matchCubit.getMatchFixtures(
          searchParameter:
              'league=${widget.leagueId}&season=${widget.year}&from=${widget.startSeason}&to=${widget.endSeason}');
    }
  }

  checkLeagueLiveStatus(String leagueId) {
    if (leagueId == '') {
      searchParameter = liveAll;
      _matchCubit.getMatchFixtures(searchParameter: searchParameter);
    } else {
      _matchCubit.getMatchFixtures(
          searchParameter:
              '?league=${widget.leagueId}&season=${widget.year}&date=$todaysDate');
    }
  }

  int selectedIndex = 0;

  Color _color1 = const Color(0xff0a0637);
  Color _color2 = Colors.white;

  void toggleColor() {
    setState(() {
      if (selectedIndex == 0) {
        checkLeagueStatus(widget.leagueId!);
      } else {
        checkLeagueStatus(widget.leagueId!);
      }
      Color tempColor = _color1;
      _color1 = _color2;
      _color2 = tempColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: () =>
          _matchCubit.getMatchFixtures(searchParameter: searchParameter),
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
                    onRefresh: () => _matchCubit.getMatchFixtures(
                        searchParameter: searchParameter),
                  );
                } else if (state is MatchApiErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _matchCubit.getMatchFixtures(
                        searchParameter: searchParameter),
                  );
                }

                if (widget.leagueId != '') {
                  fixtures =
                      _matchCubit.viewModel.matchFixturesList;
                } else {
                  fixtures = _matchCubit.viewModel.matchFixturesList;
                }

                return SizedBox(
                    width: mediaQueryData.size.width,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(height: 16.v),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          child: Column(children: [
                            SizedBox(height: 20.v),
                            _buildTopNavLivescores(context),
                            SizedBox(height: 30.v),
                            _buildMatchCard(context)
                          ]))
                    ])));
              })),
    ));
  }

  Widget _buildTopNavLivescores(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          padding: EdgeInsets.only(
            right: 0.v,
          ),
          decoration: AppDecoration.outlineBlack900
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: Row(children: [
            CustomElevatedButton(
                onPressed: () {
                  selectedIndex = 0;
                  toggleColor();
                },
                height: 32.v,
                width: 65.h,
                text: "ALL",
                buttonStyle: selectedIndex == 0
                    ? CustomButtonStyles.fillRedTL12
                    : ElevatedButton.styleFrom(backgroundColor: Colors.white),
                buttonTextStyle: selectedIndex == 0
                    ? CustomTextStyles.labelMediumWhiteA700
                    : theme.textTheme.labelMedium),
            CustomElevatedButton(
                onPressed: () {
                  selectedIndex = 1;
                  toggleColor();
                },
                height: 32.v,
                width: 65.h,
                text: "LIVE",
                buttonStyle: selectedIndex == 1
                    ? CustomButtonStyles.fillRedTL12
                    : ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),
                buttonTextStyle: selectedIndex == 1
                    ? CustomTextStyles.labelMediumWhiteA700
                    : theme.textTheme.labelMedium),
            // Padding(
            //     padding: EdgeInsets.only(left: 22.h, top: 9.v, bottom: 9.v),
            //     child: Text("LIVE", style: theme.textTheme.labelMedium)),
            // Spacer(),
            // Padding(
            //     padding: EdgeInsets.only(top: 10.v, bottom: 7.v),
            //     child:
            //         Text("Upcoming", style: theme.textTheme.labelMedium)),
            // Padding(
            //     padding: EdgeInsets.fromLTRB(27.h, 8.v, 18.h, 9.v),
            //     child: Text("Result", style: theme.textTheme.labelMedium))
          ])),
      // CustomElevatedButton(
      //     height: 32.v,
      //     width: 80.h,
      //     text: "Search",
      //     margin: EdgeInsets.only(left: 8.h),
      //     rightIcon: Container(
      //         margin: EdgeInsets.only(left: 4.h),
      //         child: CustomImageView(
      //             imagePath: ImageConstant.imgSearch,
      //             height: 20.adaptSize,
      //             width: 20.adaptSize)),
      //     buttonStyle: CustomButtonStyles.outlineBlack,
      //     buttonTextStyle: CustomTextStyles.labelLargeInterGray500)
    ]);
  }

  Widget _buildMatchCard(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 8.v);
        },
        itemCount: fixtures.length,
        itemBuilder: (context, index) {
          return MatchcardItemWidget(onTapCardMatch: () {
            AppNavigator.pushAndStackPage(context, page: ViewLivescoresDetailsScreen(
      leagueId:
                                        'id=${fixtures[index].fixture?.id.toString() ?? ''}',
                                    awayTeamId: fixtures[0]
                                        .teams!
                                        .away!
                                        .id
                                        .toString(),
                                    homeTeamId: fixtures[0]
                                        .teams!
                                        .home!
                                        .id
                                        .toString(),
    ));
          },  match: fixtures[index],);
        });
  }

  onTapCardMatch(BuildContext context) {
    
  }
}
