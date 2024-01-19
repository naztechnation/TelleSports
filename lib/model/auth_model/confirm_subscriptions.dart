class ConfirmSubscription {
  ConfirmSubscription({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  ConfirmSubscription copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      ConfirmSubscription(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ConfirmSubscription.fromJson(Map<String, dynamic> json) =>
      ConfirmSubscription(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
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
    this.updatedAt,
  });

  final int? id;
  final String? userId;
  final String? name;
  final String? email;
  final String? phone;
  final String? plan;
  var unit;
  final String? freeConversion;
  final dynamic emailVerifiedAt;
  final String? isAdmin;
  final String? isActive;
  final String? activationCode;
  final String? createdAt;
  final String? updatedAt;

  Data copyWith({
    int? id,
    String? userId,
    String? name,
    String? email,
    String? phone,
    String? plan,
    var unit,
    String? freeConversion,
    dynamic emailVerifiedAt,
    String? isAdmin,
    String? isActive,
    String? activationCode,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        plan: plan ?? this.plan,
        unit: unit ?? this.unit,
        freeConversion: freeConversion ?? this.freeConversion,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        isAdmin: isAdmin ?? this.isAdmin,
        isActive: isActive ?? this.isActive,
        activationCode: activationCode ?? this.activationCode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        plan: json["plan"],
        unit: json["unit"],
        freeConversion: json["free_conversion"],
        emailVerifiedAt: json["email_verified_at"],
        isAdmin: json["is_admin"],
        isActive: json["is_active"],
        activationCode: json["activation_code"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "plan": plan,
        "unit": unit,
        "free_conversion": freeConversion,
        "email_verified_at": emailVerifiedAt,
        "is_admin": isAdmin,
        "is_active": isActive,
        "activation_code": activationCode,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
