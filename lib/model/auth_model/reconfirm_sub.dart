

class ConfirmedSubscription {
  bool? success;
  String? message;
  SubData? data;

  ConfirmedSubscription({this.success, this.message, this.data});

  ConfirmedSubscription.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? SubData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SubData {
  int? id;
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? plan;
  int? unit;
  String? freeConversion;
  String? emailVerifiedAt;
  String? isAdmin;
  String? isActive;
  String? activationCode;
  String? createdAt;
  String? updatedAt;

  SubData(
      {this.id,
      this.userId,
      this.name,
      this.email,
      this.phone,
      this.plan,
      this.unit,
      this.freeConversion,
      this.emailVerifiedAt,
      this.isAdmin,
      this.isActive,
      this.activationCode,
      this.createdAt,
      this.updatedAt});

  SubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    plan = json['plan'];
    unit = json['unit'];
    freeConversion = json['free_conversion'];
    emailVerifiedAt = json['email_verified_at'];
    isAdmin = json['is_admin'];
    isActive = json['is_active'];
    activationCode = json['activation_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['plan'] = plan;
    data['unit'] = unit;
    data['free_conversion'] = freeConversion;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_admin'] = isAdmin;
    data['is_active'] = isActive;
    data['activation_code'] = activationCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
