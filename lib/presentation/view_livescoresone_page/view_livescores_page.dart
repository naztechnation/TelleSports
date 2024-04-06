import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../blocs/matches/match.dart';
import '../../model/matches_data/match_fixtures.dart' as fixture;
import '../../model/matches_data/match_fixtures.dart';
import '../../model/view_models/match_viewmodel.dart';
import '../../requests/repositories/matches_repository/match_repository_impl.dart';
import '../../utils/app_utils.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';
import '../community_screens/provider/auth_provider.dart';
import '../view_livescoresone_page/widgets/matchcard_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

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
    final checkUserExist = Provider.of<AuthProviders>(context, listen: false);

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

  TextEditingController searchController = TextEditingController();

  late MatchCubit _matchCubit;
  String searchParameter = '';
  String todaysDate = '';

  String liveAll = 'live=all';
  var now = DateTime.now();

  List<fixture.Response> fixtures = [];

  bool _dataAdded = false;

  @override
  void initState() {
    todaysDate = DateFormat('yyyy-MM-dd').format(now);

    searchParameter = 'date=$todaysDate';
    _asyncInitMethod();
    super.initState();
  }

  void _asyncInitMethod() {
    _matchCubit = context.read<MatchCubit>();
    checkLeagueStatus(leagueId: widget.leagueId!);
  }

  checkLeagueStatus({
    String leagueId = '',
  }) {
    if (leagueId == '') {
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
        searchParameter = liveAll;
        checkLeagueStatus(leagueId: widget.leagueId!);
      } else {
        searchParameter = 'date=$todaysDate';
        checkLeagueStatus(leagueId: widget.leagueId!);
      }
      Color tempColor = _color1;
      _color1 = _color2;
      _color2 = tempColor;
    });
  }

  List<Response> _liveMatchResult = [];

  List<Response> _liveDummyData = [];

  void searchLiveScoreResults(String query) {
    List<Response> dummySearchList = [];
    dummySearchList.addAll(_liveDummyData);
    if (query.isNotEmpty) {
      List<Response> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.teams!.home!.name!
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item.teams!.away!.name!
                .toLowerCase()
                .contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });

    
        _liveMatchResult.clear();
        _liveMatchResult.addAll(dummyListData);
      

      return;
    } else {
       
        _liveMatchResult.clear();
        _liveMatchResult.addAll(_liveDummyData);
      
    }
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
                  fixtures = _matchCubit.viewModel.matchFixturesList;
                } else {
                  fixtures = _matchCubit.viewModel.matchFixturesList;
                }

                if (!_dataAdded) {
                  _liveMatchResult.clear();
                  _liveDummyData.clear();
                  _liveMatchResult.addAll(fixtures);
                  _liveDummyData.addAll(fixtures);
                  _dataAdded = true;
                }

                return SizedBox(
                    width: mediaQueryData.size.width,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(height: 10.v),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          child: Column(children: [
                            SizedBox(height: 20.v),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                        right: 0.v,
                                      ),
                                      decoration: AppDecoration.outlineBlack900
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder8),
                                      child: Row(children: [
                                        GestureDetector(
                                          onTap: () {
                                            selectedIndex = 0;
                                            toggleColor();
                                          },
                                          child: Container(
                                            height: 50.v,
                                            width: 65.h,
                                            child: Center(
                                              child: Text(
                                                "ALL",
                                                style: TextStyle(
                                                    color: selectedIndex == 0
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: selectedIndex == 0
                                                    ? Colors.red
                                                    : Colors.white),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectedIndex = 1;
                                            toggleColor();
                                          },
                                          child: Container(
                                            height: 50.v,
                                            width: 65.h,
                                            child: Center(
                                              child: Text(
                                                "LIVE",
                                                style: TextStyle(
                                                    color: selectedIndex == 1
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: selectedIndex == 1
                                                    ? Colors.red
                                                    : Colors.white),
                                          ),
                                        ),
                                      ])),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      height: 60,
                                      child: CustomTextFormField(
                                        controller: searchController,
                                        hintText: "Search",
                                        maxLines: 1,
                                        suffix: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                            
                                          });
                                          } ,
                                          child: Container(
                                            height: 46,
                                            width: 60,
                                            margin: const EdgeInsets.symmetric(vertical: 4),
                                            decoration: BoxDecoration(color: Color(0XFF288763),
                                             borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
                                            child: Icon(Icons.search, color: Colors.white, size: 28,)),
                                        ),
                                        onChanged: (value) {
                                          searchLiveScoreResults(value);

                                          if(searchController.text.isEmpty){
                                            setState(() {
                                              
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ]),
                            SizedBox(height: 30.v),
                          if(_liveMatchResult.isNotEmpty)...[
                            ListView.separated(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 8.v);
                                },
                                itemCount: _liveMatchResult.length,
                                itemBuilder: (context, index) {
                                  return MatchcardItemWidget(
                                    onTapCardMatch: () {
                                      AppNavigator.pushAndStackPage(context,
                                          page: ViewLivescoresDetailsScreen(
                                            leagueId:
                                                'id=${_liveMatchResult[index].fixture?.id.toString() ?? ''}',
                                            awayTeamId: _liveMatchResult[0]
                                                .teams!
                                                .away!
                                                .id
                                                .toString(),
                                            homeTeamId: _liveMatchResult[0]
                                                .teams!
                                                .home!
                                                .id
                                                .toString(),
                                          ));
                                    },
                                    match: _liveMatchResult[index],
                                  );
                                })
                          ]else...[
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.47,
                              child: Align(child: Text('Opps No results found!!!', 
                              style: TextStyle(color: Colors.green.shade600),)))
                          ]  
                          ]))
                    ])));
              })),
    ));
  }
}
