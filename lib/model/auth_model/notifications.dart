

class NotificationsList {
  bool? success;
  List<NotificationsListData>? data;

  NotificationsList({this.success, this.data});

  NotificationsList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <NotificationsListData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationsListData.fromJson(v));
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

class NotificationsListData {
  int? id;
  int? userId;
  String? message;
  int? read;
  String? createdAt;
  String? updatedAt;

  NotificationsListData(
      {this.id,
      this.userId,
      this.message,
      this.read,
      this.createdAt,
      this.updatedAt});

  NotificationsListData.fromJson(Map<String, dynamic> json) {
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
