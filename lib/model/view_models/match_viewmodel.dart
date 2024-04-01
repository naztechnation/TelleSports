

import '../../core/constants/enums.dart';
import '../matches_data/coach_info.dart';
import '../matches_data/fixtues_stats.dart' as fixure_by_id;
import '../matches_data/league_table.dart' as league_table;
import '../matches_data/teams_info.dart' as team_info;
import '../matches_data/teams_stats.dart' as team_stats;

import '../matches_data/league_lists.dart' as league;
import '../matches_data/match_fixtures.dart' as fixtures;
import '../matches_data/team_squad.dart' as team_squad;
import '../matches_data/teams_transfer.dart' as team_transfer;
import 'base_viewmodel.dart';

class MatchViewModel extends BaseViewModel {
  fixtures.MatchFixtures? _matchFixtures;
  league.LeagueLists? _leagueList;
  fixure_by_id.FixtureStats? _fixtureStats;
  team_info.TeamsInfo? _teamsInfo;
  team_stats.TeamsStats? _teamsStats;
  CoachInfo? _coachInfo;
  team_transfer.TeamsTransfer? _teamsTransfer;
  team_squad.TeamSquad? _teamSquad;
  league_table.LeagueTable? _leagueTable;

  Future<void> loadFixtureList(fixtures.MatchFixtures fixtures) async {
    _matchFixtures = fixtures;

    setViewState(ViewState.success);
  }

  Future<void> loadFixtureById(fixure_by_id.FixtureStats fixtures) async {
    _fixtureStats = fixtures;

    setViewState(ViewState.success);
  }

  Future<void> loadLeagueList(league.LeagueLists leagueList) async {
    _leagueList = leagueList;

    setViewState(ViewState.success);
  }

  Future<void> loadTeamInfo(team_info.TeamsInfo teamsInfo) async {
    _teamsInfo = teamsInfo;

    setViewState(ViewState.success);
  }

  Future<void> loadTeamStats(team_stats.TeamsStats teamsStats) async {
    _teamsStats = teamsStats;

    setViewState(ViewState.success);
  }

  Future<void> loadTeamSquad(team_squad.TeamSquad teamSquad) async {
    _teamSquad = teamSquad;

    setViewState(ViewState.success);
  }

  Future<void> loadCoach(CoachInfo coachInfo) async {
    _coachInfo = coachInfo;

    setViewState(ViewState.success);
  }

  Future<void> leagueTable(league_table.LeagueTable leagueTable) async {
    _leagueTable = leagueTable;

    setViewState(ViewState.success);
  }

  Future<void> loadTeamTransfer(
      team_transfer.TeamsTransfer teamsTransfer) async {
    _teamsTransfer = teamsTransfer;

    setViewState(ViewState.success);
  }

  List<fixtures.Response> get matchFixturesList =>
      _matchFixtures!.response ?? [];

  List<fixure_by_id.Response> get fixtureStatistics =>
      _fixtureStats!.response ?? [];
  List<fixure_by_id.Statistics> get fixtureStats =>
      _fixtureStats!.response?[0].statistics ?? [];
  List<fixure_by_id.Events> get fixtureEvents =>
      _fixtureStats!.response?[0].events ?? [];

  List<fixure_by_id.Lineups> get fixtureLineUps =>
      _fixtureStats!.response?[0].lineups ?? [];

  List<List<league_table.Standing>> get tableList =>
      _leagueTable!.response?[0].league?.standings ?? [];

  List<league_table.Standing> get leagueTableList => leagueTables();

  List<team_squad.Response> get squadStats => _teamSquad!.response ?? [];
  List<team_info.Response> get teamInfo => _teamsInfo!.response!;
  team_stats.Response get teamStats => _teamsStats!.response!;

  List<league.Response> get leagueList => _leagueList!.response ?? [];
  List<league.Seasons> get seasons => seasonsList();

  List<league_table.Standing> leagueTables() {
    List<league_table.Standing> list = [];

    for (var item in tableList) {
      list.addAll(item);
    }

    return list;
  }

  List<league.Seasons> seasonsList() {
    List<league.Seasons> list = [];

    for (var item in leagueList) {
      list.addAll(item.seasons!);
    }

    return list;
  }
}
