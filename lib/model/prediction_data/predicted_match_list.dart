class PredictMatchList {
  bool? success;
  List<PredictMatchListData>? data;

  PredictMatchList({this.success, this.data});

  PredictMatchList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PredictMatchListData>[];
      json['data'].forEach((v) {
        data!.add(new PredictMatchListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PredictMatchListData {
  int? id;
  int? userId;
  String? homeTeam;
  String? homeScore;
  String? awayTeam;
  String? awayScore;
  String? predictedWinner;
  String? odds;
  String? league;
  String? currentRating;
  String? createdAt;
  String? updatedAt;

  PredictMatchListData(
      {this.id,
      this.userId,
      this.homeTeam,
      this.homeScore,
      this.awayTeam,
      this.awayScore,
      this.predictedWinner,
      this.odds,
      this.league,
      this.currentRating,
      this.createdAt,
      this.updatedAt});

  PredictMatchListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    homeTeam = json['home_team'];
    homeScore = json['home_score'];
    awayTeam = json['away_team'];
    awayScore = json['away_score'];
    predictedWinner = json['predicted_winner'];
    odds = json['odds'];
    league = json['league'];
    currentRating = json['current_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['home_team'] = this.homeTeam;
    data['home_score'] = this.homeScore;
    data['away_team'] = this.awayTeam;
    data['away_score'] = this.awayScore;
    data['predicted_winner'] = this.predictedWinner;
    data['odds'] = this.odds;
    data['league'] = this.league;
    data['current_rating'] = this.currentRating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
