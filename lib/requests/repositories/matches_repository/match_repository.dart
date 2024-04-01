 
 

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

abstract class MatchRepository {
  Future<MatchFixtures> getMatchFixtures({
    required String searchParameter,
  });

  Future<LeagueLists> getLeagues();

  Future<FixtureStats> getFixturesById({
    required String searchParameter,
  });

  Future<TeamsInfo> getTeamInfo({
    required String teamId,
  });
  Future<TeamsTransfer> getTeamTransfer({
    required String teamId,
  });

  Future<TeamSquad> getTeamSquad({
    required String teamId,
  });

  Future<CoachInfo> getCoachInfo({
    required String teamId,
  });

  Future<Trophies> getTrophiesInfo({
    required String id,
  });
  Future<TeamsStats> getTeamStats({
    required String teamId,
    required String leagueId,
  });

  Future<LeagueTable> getLeagueTable({
    required String leagueId,
  });
}
