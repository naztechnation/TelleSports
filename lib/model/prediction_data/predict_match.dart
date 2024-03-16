class PredictMatch {
  bool? success;
  PredictMatchData? data;

  PredictMatch({this.success, this.data});

  PredictMatch.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new PredictMatchData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PredictMatchData {
  int? userId;
  String? homeTeam;
  String? homeScore;
  String? awayTeam;
  String? awayScore;
  String? predictedWinner;
  String? odds;
  String? league;
  String? updatedAt;
  String? createdAt;
  int? id;

  PredictMatchData(
      {this.userId,
      this.homeTeam,
      this.homeScore,
      this.awayTeam,
      this.awayScore,
      this.predictedWinner,
      this.odds,
      this.league,
      this.updatedAt,
      this.createdAt,
      this.id});

  PredictMatchData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    homeTeam = json['home_team'];
    homeScore = json['home_score'];
    awayTeam = json['away_team'];
    awayScore = json['away_score'];
    predictedWinner = json['predicted_winner'];
    odds = json['odds'];
    league = json['league'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['home_team'] = this.homeTeam;
    data['home_score'] = this.homeScore;
    data['away_team'] = this.awayTeam;
    data['away_score'] = this.awayScore;
    data['predicted_winner'] = this.predictedWinner;
    data['odds'] = this.odds;
    data['league'] = this.league;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
