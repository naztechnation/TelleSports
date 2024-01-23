class LoginUser {
  bool? success;
  String? message;
  String? error;
  Token? token;
  User? user;
  int? tellacoinBalance;
  Plan? plan;

  LoginUser({this.success, this.token, this.user, this.message,  this.error, this.tellacoinBalance, this.plan});

  LoginUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    error = json['error'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tellacoinBalance = json['tellacoin_balance'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }

    data['tellacoin_balance'] = this.tellacoinBalance;
     if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
     
    return data;
  }
}

class Token {
  String? token;

  Token({this.token});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
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
      this.updatedAt});

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
    return data;
  }
}

class Plan {
  int? id;
  String? name;
  String? tellacoin;
  String? price;
  List<String>? functionality;
  String? createdAt;
  String? updatedAt;

  Plan(
      {this.id,
      this.name,
      this.tellacoin,
      this.price,
      this.functionality,
      this.createdAt,
      this.updatedAt});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tellacoin = json['tellacoin'];
    price = json['price'];
    functionality = json['functionality'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tellacoin'] = this.tellacoin;
    data['price'] = this.price;
    data['functionality'] = this.functionality;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}