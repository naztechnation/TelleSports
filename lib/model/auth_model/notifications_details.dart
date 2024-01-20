

class NotificationsDetails {
  bool? success;
  NotificationsDetailsData? data;

  NotificationsDetails({this.success, this.data});

  NotificationsDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new NotificationsDetailsData.fromJson(json['data']) : null;
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

class NotificationsDetailsData {
  int? id;
  int? userId;
  String? message;
  int? read;
  String? createdAt;
  String? updatedAt;

  NotificationsDetailsData(
      {this.id,
      this.userId,
      this.message,
      this.read,
      this.createdAt,
      this.updatedAt});

  NotificationsDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    message = json['message'];
    read = json['read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['message'] = this.message;
    data['read'] = this.read;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
