import 'package:equatable/equatable.dart';
import 'package:tellesports/model/prediction_data/predicted_match_list.dart';

import '../../model/prediction_data/predict_match.dart';
import '../../model/prediction_data/prediction_rating.dart';
import '../../model/user_model/transfer_tellacoin.dart'; 


abstract class PredictStates extends Equatable {
  const PredictStates();
}

class InitialState extends PredictStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class PredictListLoading extends PredictStates {
  @override
  List<Object> get props => [];
}

class PredictListLoaded extends PredictStates {
  final PredictMatchList predict;
  const PredictListLoaded(this.predict);
  @override
  List<Object> get props => [predict];
}

class PredictLoading extends PredictStates {
  @override
  List<Object> get props => [];
}

class PredictLoaded extends PredictStates {
  final PredictMatch predict;
  const PredictLoaded(this.predict);
  @override
  List<Object> get props => [predict];
}

class RatingPredictLoading extends PredictStates {
  @override
  List<Object> get props => [];
}

class RatingPredictLoaded extends PredictStates {
  final PredictRating predict;
  const RatingPredictLoaded(this.predict);
  @override
  List<Object> get props => [predict];
}

class PredictNetworkErr extends PredictStates {
  final String? message;
  const PredictNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class PredictApiErr extends PredictStates {
  final String? message;
  const PredictApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
