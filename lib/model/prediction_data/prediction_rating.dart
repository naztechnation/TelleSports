class PredictRating {
  bool? success;
  PredictRatingData? data;

  PredictRating({this.success, this.data});

  PredictRating.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new PredictRatingData.fromJson(json['data']) : null;
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

class PredictRatingData {
  int? userId;
  String? predictionId;
  String? rating;
  String? updatedAt;
  String? createdAt;
  int? id;

  PredictRatingData(
      {this.userId,
      this.predictionId,
      this.rating,
      this.updatedAt,
      this.createdAt,
      this.id});

  PredictRatingData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    predictionId = json['prediction_id'];
    rating = json['rating'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['prediction_id'] = this.predictionId;
    data['rating'] = this.rating;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
