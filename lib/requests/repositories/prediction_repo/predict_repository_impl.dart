  
import 'package:tellesports/model/prediction_data/predict_match.dart';

import 'package:tellesports/model/prediction_data/predicted_match_list.dart';

import 'package:tellesports/model/prediction_data/prediction_rating.dart';

import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'predict_repository.dart';

class PredictRepositoryImpl implements PredictRepository {
  


  @override
  Future<PredictMatchList> getPrediction({required String selectedDate})  async {
    final map = await Requests().post(AppStrings.getPredictionListUrl(selectedDate),);
    return PredictMatchList.fromJson(map);
  }

  @override
  Future<PredictMatch> postPrediction({required String homeTeam,
   required String awayTeam, required String homeScore, required String awayScore,
    required String predictedWinner, required String odds, required String league,
     required String homeLogo, required String awayLogo})async {
    final map = await Requests().post(AppStrings.postPredictionUrl, body: {
      "home_team": homeTeam,
      "away_team": awayTeam,
      "away_score": awayScore,
      "predicted_winner": predictedWinner,
      "odds": odds,
      "league": league,
      "home_score": homeScore
    });
    return PredictMatch.fromJson(map);
  }
  @override
  Future<PredictRating> postRatings({required String predictionId, required String predictionRating})async {
    final map = await Requests().post(AppStrings.predictionRatingUrl, body: {
      "prediction_id": predictionId,
      "rating": predictionRating,
      
    });
    return PredictRating.fromJson(map);
  }

 


}
