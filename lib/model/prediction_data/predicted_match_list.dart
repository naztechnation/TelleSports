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
  String? homeImage;
  String? awayTeam;
  String? awayScore;
  String? awayImage;
  String? predictedWinner;
  String? odds;
  String? league;
  String? currentRating;
  String? createdAt;
  String? updatedAt;
  User? user;

  PredictMatchListData(
      {this.id,
      this.userId,
      this.homeTeam,
      this.homeScore,
      this.homeImage,
      this.awayTeam,
      this.awayScore,
      this.awayImage,
      this.predictedWinner,
      this.odds,
      this.league,
      this.currentRating,
      this.createdAt,
      this.updatedAt,
      this.user});

  PredictMatchListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    homeTeam = json['home_team'];
    homeScore = json['home_score'];
    homeImage = json['home_image'];
    awayTeam = json['away_team'];
    awayScore = json['away_score'];
    awayImage = json['away_image'];
    predictedWinner = json['predicted_winner'];
    odds = json['odds'];
    league = json['league'];
    currentRating = json['current_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['home_team'] = this.homeTeam;
    data['home_score'] = this.homeScore;
    data['home_image'] = this.homeImage;
    data['away_team'] = this.awayTeam;
    data['away_score'] = this.awayScore;
    data['away_image'] = this.awayImage;
    data['predicted_winner'] = this.predictedWinner;
    data['odds'] = this.odds;
    data['league'] = this.league;
    data['current_rating'] = this.currentRating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? userId;
  String? username;
  String? email;
  String? phone;
  int? isAdmin;
  int? isActive;
  String? activationCode;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User(
      {this.id,
      this.userId,
      this.username,
      this.email,
      this.phone,
      this.isAdmin,
      this.isActive,
      this.activationCode,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    isAdmin = json['is_admin'];
    isActive = json['is_active'];
    activationCode = json['activation_code'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['is_admin'] = this.isAdmin;
    data['is_active'] = this.isActive;
    data['activation_code'] = this.activationCode;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
