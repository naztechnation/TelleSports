 

import 'package:equatable/equatable.dart';

import '../../model/matches_data/coach_info.dart';
import '../../model/matches_data/fixtues_stats.dart';
import '../../model/matches_data/league_lists.dart';
import '../../model/matches_data/league_table.dart';
import '../../model/matches_data/match_fixtures.dart';
import '../../model/matches_data/team_squad.dart';
import '../../model/matches_data/teams_info.dart';
import '../../model/matches_data/teams_stats.dart';
import '../../model/matches_data/teams_transfer.dart';
import '../../model/matches_data/trophies.dart'; 

abstract class MatchStates extends Equatable {
  const MatchStates();
}

class InitialState extends MatchStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class MatchLoading extends MatchStates {
  @override
  List<Object> get props => [];
}

class MatchLoaded extends MatchStates {
  final MatchFixtures matchData;
  const MatchLoaded(this.matchData);
  @override
  List<Object> get props => [matchData];
}

class TrophiesLoaded extends MatchStates {
  final Trophies trophies;
  const TrophiesLoaded(this.trophies);
  @override
  List<Object> get props => [trophies];
}

class LeagueLoaded extends MatchStates {
  final LeagueLists leagueData;
  const LeagueLoaded(this.leagueData);
  @override
  List<Object> get props => [leagueData];
}

class FixtureByIdLoaded extends MatchStates {
  final FixtureStats leagueData;
  const FixtureByIdLoaded(this.leagueData);
  @override
  List<Object> get props => [leagueData];
}

class TeamsInfoLoading extends MatchStates {
  @override
  List<Object> get props => [];
}

class TeamsInfoLoaded extends MatchStates {
  final TeamsInfo playersInfoLoaded;
  const TeamsInfoLoaded(this.playersInfoLoaded);
  @override
  List<Object> get props => [playersInfoLoaded];
}

class TeamsStatLoading extends MatchStates {
  @override
  List<Object> get props => [];
}

class TeamsStatLoaded extends MatchStates {
  final TeamsStats statsInfoLoaded;
  const TeamsStatLoaded(this.statsInfoLoaded);
  @override
  List<Object> get props => [statsInfoLoaded];
}

class CoachInfoLoading extends MatchStates {
  @override
  List<Object> get props => [];
}

class CoachInfoLoaded extends MatchStates {
  final CoachInfo coachInfo;
  const CoachInfoLoaded(this.coachInfo);
  @override
  List<Object> get props => [coachInfo];
}

class TeamTransferLoading extends MatchStates {
  @override
  List<Object> get props => [];
}

class TeamTransferLoaded extends MatchStates {
  final TeamsTransfer teamsTransfer;
  const TeamTransferLoaded(this.teamsTransfer);
  @override
  List<Object> get props => [teamsTransfer];
}

class TeamSquadLoading extends MatchStates {
  @override
  List<Object> get props => [];
}

class TeamSquadLoaded extends MatchStates {
  final TeamSquad teamSquad;
  const TeamSquadLoaded(this.teamSquad);
  @override
  List<Object> get props => [teamSquad];
}

class LeagueTableLoading extends MatchStates {
  @override
  List<Object> get props => [];
}

class LeagueTableLoaded extends MatchStates {
  final LeagueTable leagueTable;
  const LeagueTableLoaded(this.leagueTable);
  @override
  List<Object> get props => [leagueTable];
}
class MatchNetworkErr extends MatchStates {
  final String? message;
  const MatchNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class MatchApiErr extends MatchStates {
  final String? message;
  const MatchApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class TeamInfoNetworkErr extends MatchStates {
  final String? message;
  const TeamInfoNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class TeamInfoApiErr extends MatchStates {
  final String? message;
  const TeamInfoApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class TeamNetworkErr extends MatchStates {
  final String? message;
  const TeamNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class TeamApiErr extends MatchStates {
  final String? message;
  const TeamApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
