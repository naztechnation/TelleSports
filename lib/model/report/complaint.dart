

class Complaint {
  bool? success;
  ComplaintData? data;

  Complaint({this.success, this.data});

  Complaint.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ComplaintData.fromJson(json['data']) : null;
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

class ComplaintData {
  UserReport? userReport;
  String? complaintType;
  String? updatedAt;
  String? createdAt;
  int? id;

  ComplaintData(
      {this.userReport,
      this.complaintType,
      this.updatedAt,
      this.createdAt,
      this.id});

  ComplaintData.fromJson(Map<String, dynamic> json) {
    userReport = json['user_report'] != null
        ? new UserReport.fromJson(json['user_report'])
        : null;
    complaintType = json['complaint_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userReport != null) {
      data['user_report'] = this.userReport!.toJson();
    }
    data['complaint_type'] = this.complaintType;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class UserReport {
  UserComplaintAttributes? userComplaintAttributes;

  UserReport({this.userComplaintAttributes});

  UserReport.fromJson(Map<String, dynamic> json) {
    userComplaintAttributes = json['user_complaint_attributes'] != null
        ? new UserComplaintAttributes.fromJson(
            json['user_complaint_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userComplaintAttributes != null) {
      data['user_complaint_attributes'] =
          this.userComplaintAttributes!.toJson();
    }
    return data;
  }
}

class UserComplaintAttributes {
  String? reportedUsername;
  String? complaint;
  String? username;

  UserComplaintAttributes(
      {this.reportedUsername, this.complaint, this.username});

  UserComplaintAttributes.fromJson(Map<String, dynamic> json) {
    reportedUsername = json['reported_username'];
    complaint = json['complaint'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reported_username'] = this.reportedUsername;
    data['complaint'] = this.complaint;
    data['username'] = this.username;
    return data;
  }
}
