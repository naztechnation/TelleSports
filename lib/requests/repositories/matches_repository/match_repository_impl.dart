 
import '../../../model/matches_data/coach_info.dart';
import '../../../model/matches_data/fixtues_stats.dart';
import '../../../model/matches_data/league_lists.dart';
import '../../../model/matches_data/league_table.dart';
import '../../../model/matches_data/match_fixtures.dart';
import '../../../model/matches_data/team_squad.dart';
import '../../../model/matches_data/teams_info.dart';
import '../../../model/matches_data/teams_stats.dart';
import '../../../model/matches_data/teams_transfer.dart';
import '../../../model/matches_data/trophies.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'match_repository.dart';

class MatchRepositoryImpl implements MatchRepository {
  @override
  Future<MatchFixtures> getMatchFixtures({
    required String searchParameter,
  }) async {
    final map = await Requests().get(
        AppStrings.rapidFixtureUrl(searchParameter: searchParameter),
        headers: AppStrings.rapidHeaders);

    return MatchFixtures.fromJson(map);
  }

  @override
  Future<LeagueLists> getLeagues() async {
    final map = await Requests()
        .get(AppStrings.league, headers: AppStrings.rapidHeaders);

    return LeagueLists.fromJson(map);
  }

  @override
  Future<FixtureStats> getFixturesById(
      {required String searchParameter}) async {
    final map = await Requests().get(
        AppStrings.rapidFixtureUrl(searchParameter: searchParameter),
        headers: AppStrings.rapidHeaders);

    return FixtureStats.fromJson(map);
  }

  @override
  Future<TeamsInfo> getTeamInfo({required String teamId}) async {
    final map = await Requests().get(AppStrings.teamInfoUrl(teamId: teamId),
        headers: AppStrings.rapidHeaders);

    return TeamsInfo.fromJson(map);
  }

  @override
  Future<TeamsStats> getTeamStats({
    required String teamId,
    required String leagueId,
  }) async {
    final map = await Requests().get(
        AppStrings.teamStatsUrl(
          teamId: teamId,
          leagueId: leagueId,
        ),
        headers: AppStrings.rapidHeaders);

    return TeamsStats.fromJson(map);
  }

  @override
  Future<CoachInfo> getCoachInfo({required String teamId}) async {
    final map = await Requests().get(AppStrings.coachInfoUrl(teamId: teamId),
        headers: AppStrings.rapidHeaders);

    return CoachInfo.fromJson(map);
  }

  @override
  Future<TeamsTransfer> getTeamTransfer({required String teamId}) async {
    final map = await Requests().get(AppStrings.teamTransferUrl(teamId: teamId),
        headers: AppStrings.rapidHeaders);

    return TeamsTransfer.fromJson(map);
  }

  @override
  Future<TeamSquad> getTeamSquad({required String teamId}) async {
    final map = await Requests().get(
        AppStrings.teamsSquadUrl(
          teamId: teamId,
        ),
        headers: AppStrings.rapidHeaders);

    return TeamSquad.fromJson(map);
  }

  @override
  Future<Trophies> getTrophiesInfo({required String id}) async {
    final map = await Requests().get(
        AppStrings.trophiesUrl(
          id: id,
        ),
        headers: AppStrings.rapidHeaders);

    return Trophies.fromJson(map);
  }

  @override
  Future<LeagueTable> getLeagueTable({required String leagueId}) async {
    final map = await Requests().get(
        AppStrings.leagueTableUrl(
          leagueId: leagueId,
        ),
        headers: AppStrings.rapidHeaders);

    return LeagueTable.fromJson(map);
  }
}
