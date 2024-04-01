import 'package:flutter_bloc/flutter_bloc.dart';
 

import '../../model/view_models/match_viewmodel.dart';
import '../../requests/repositories/matches_repository/match_repository.dart';
import '../../utils/exceptions.dart';
import 'match_states.dart';

class MatchCubit extends Cubit<MatchStates> {
  MatchCubit({required this.matchRepository, required this.viewModel})
      : super(const InitialState());
  final MatchRepository matchRepository;
  final MatchViewModel viewModel;

  Future<void> getMatchFixtures({
    required String searchParameter,
  }) async {
    try {
      emit(MatchLoading());

      final fixtures = await matchRepository.getMatchFixtures(
          searchParameter: searchParameter);
      await viewModel.loadFixtureList(fixtures);
      emit(MatchLoaded(fixtures));
    } on ApiException catch (e) {
      emit(MatchApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(MatchNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getFixturesById({
    required String searchParameter,
  }) async {
    try {
      emit(MatchLoading());

      final fixtures = await matchRepository.getFixturesById(
          searchParameter: searchParameter);
      await viewModel.loadFixtureById(fixtures);
      emit(FixtureByIdLoaded(fixtures));
    } on ApiException catch (e) {
      emit(MatchApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(MatchNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getLeagues() async {
    try {
      emit(MatchLoading());

      final league = await matchRepository.getLeagues();
      await viewModel.loadLeagueList(league);
      emit(LeagueLoaded(league));
    } on ApiException catch (e) {
      emit(MatchApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(MatchNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getTeamsInfo({required String teamsId}) async {
    try {
      emit(TeamsInfoLoading());

      final teamsInfo = await matchRepository.getTeamInfo(teamId: teamsId);
      await viewModel.loadTeamInfo(teamsInfo);

      emit(TeamsInfoLoaded(teamsInfo));
    } on ApiException catch (e) {
      emit(TeamInfoApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(TeamInfoNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getTeamsStat(
      {required String teamsId, required String leagueId}) async {
    try {
      emit(TeamsStatLoading());

      final teamsStats = await matchRepository.getTeamStats(
          teamId: teamsId, leagueId: leagueId);
      await viewModel.loadTeamStats(teamsStats);

      emit(TeamsStatLoaded(teamsStats));
    } on ApiException catch (e) {
      emit(TeamApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(TeamNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getCoachInfo({required String teamsId}) async {
    try {
      emit(CoachInfoLoading());

      final coachInfo = await matchRepository.getCoachInfo(teamId: teamsId);
      await viewModel.loadCoach(coachInfo);

      emit(CoachInfoLoaded(coachInfo));
    } on ApiException catch (e) {
      emit(TeamApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(TeamNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getLeagueTable({required String leagueId}) async {
    try {
      emit(LeagueTableLoading());

      final leagueTable =
          await matchRepository.getLeagueTable(leagueId: leagueId);
      await viewModel.leagueTable(leagueTable);

      emit(LeagueTableLoaded(leagueTable));
    } on ApiException catch (e) {
      emit(TeamApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(TeamNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getTeamTransfer({
    required String teamsId,
  }) async {
    try {
      emit(TeamTransferLoading());

      final teamTransferInfo =
          await matchRepository.getTeamTransfer(teamId: teamsId);
      await viewModel.loadTeamTransfer(teamTransferInfo);

      emit(TeamTransferLoaded(teamTransferInfo));
    } on ApiException catch (e) {
      emit(TeamApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(TeamNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getTeamSquad({
    required String teamsId,
  }) async {
    try {
      emit(TeamSquadLoading());

      final squadInfo = await matchRepository.getTeamSquad(teamId: teamsId);
      await viewModel.loadTeamSquad(squadInfo);

      emit(TeamSquadLoaded(squadInfo));
    } on ApiException catch (e) {
      emit(TeamApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(TeamNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getTrophies({
    required String id,
  }) async {
    try {
      emit(MatchLoading());

      final trophies = await matchRepository.getTrophiesInfo(id: id);
      // await viewModel.loadFixtureList(trophies);
      emit(TrophiesLoaded(trophies));
    } on ApiException catch (e) {
      emit(MatchApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(MatchNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}
