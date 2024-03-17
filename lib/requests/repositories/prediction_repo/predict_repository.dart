
import 'package:tellesports/model/prediction_data/predict_match.dart';
import 'package:tellesports/model/prediction_data/prediction_rating.dart';
import 'package:tellesports/model/report/complaint.dart';

import '../../../model/prediction_data/predicted_match_list.dart';



abstract class PredictRepository {
  Future<PredictMatch> postPrediction({
    required String homeTeam,
    required String awayTeam,
    required String homeScore,
    required String awayScore,
    required String predictedWinner,
    required String odds,
    required String league,
    required String homeLogo,
    required String awayLogo,

  });

   Future<PredictMatchList> getPrediction({
    required String selectedDate,
    

  });

   Future<PredictRating> postRatings({
    required String predictionId,
    required String predictionRating,
    

  });

   Future<Complaint> sendComplaint({
    required String complaintType,
    required String complaint,
    required String reportedUser,
      String groupName,
      String groupId,
      String groupLeaderName,
     

  });
 
}
