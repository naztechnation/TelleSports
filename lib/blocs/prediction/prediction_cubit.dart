 

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tellesports/blocs/prediction/prediction.dart';

import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/prediction_repo/predict_repository.dart';

import '../../utils/exceptions.dart';
import 'prediction_states.dart';

class PredictionCubit extends Cubit<PredictStates> {
  PredictionCubit({required this.predictRepository, required this.viewModel})
      : super(const InitialState());
  final PredictRepository predictRepository;
  final UserViewModel viewModel;

  Future<void> getPrediction({
    required String day,
    
  }) async {
    try {
      emit(PredictListLoading());

      final predict = await predictRepository.getPrediction(
        selectedDate: day,
        
      );

      emit(PredictListLoaded(predict));
    } on ApiException catch (e) {
      emit(PredictApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(PredictNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  
Future<void> postPrediction({
    required String homeTeam,
    required String awayTeam,
    required String homeScore,
    required String awayScore,
    required String predictedWinner,
    required String odds,
    required String league,
    required String homeLogo,
    required String awayLogo,
    
  }) async {
    try {
      emit(PredictLoading());

      final predict = await predictRepository.postPrediction(homeTeam: homeTeam, 
      awayTeam: awayTeam, homeScore: homeScore, awayScore: awayScore, predictedWinner: predictedWinner, odds: odds,
       homeLogo: homeLogo, league: league, awayLogo: awayLogo
        
        
      );

      emit(PredictLoaded(predict));
    } on ApiException catch (e) {
      emit(PredictApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(PredictNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

   Future<void> postPredictionRating({
    required String predictionId, required String predictionRating
    
  }) async {
    try {
      emit(RatingPredictLoading());

      final predict = await predictRepository.postRatings(predictionId: predictionId, predictionRating: predictionRating
       
        
      );

      emit(RatingPredictLoaded(predict));
    } on ApiException catch (e) {
      emit(PredictApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(PredictNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

    Future<void> sendReport({required String complaintType,
   required String complaint, required String reportedUser,
    String? groupName, String? groupId, String? groupLeaderName}) async {
    try {
      emit(ReportUserLoading());

      final report = await predictRepository.sendComplaint(complaintType: complaintType, complaint: complaint, reportedUser: reportedUser, groupName: groupName ?? '', groupId: groupId ?? '', groupLeaderName: groupLeaderName ?? '');
       
        
      

      emit(ReportUserLoaded(report));
    } on ApiException catch (e) {
      emit(PredictApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(PredictNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

}
