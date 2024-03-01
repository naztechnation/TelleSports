class LoginUser {
  bool? success;
  String? message;
  String? error;
  Token? token;
  User? user;
  int? tellacoinBalance;
  UserWallet? userWallet;
  Plan? plan;
  String? profilePicture;

  LoginUser({this.success, this.token, this.user, this.message,  this.error, this.tellacoinBalance, this.plan});

  LoginUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    error = json['error'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tellacoinBalance = json['tellacoin_balance'];
    userWallet = json['user_wallet'] != null
        ? new UserWallet.fromJson(json['user_wallet'])
        : null;
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    profilePicture = json['profile_picture'];
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
     if (this.userWallet != null) {
      data['user_wallet'] = this.userWallet!.toJson();
    }
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    data['profile_picture'] = this.profilePicture;
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
  var isAdmin;
  var isActive;
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

class UserWallet {
  int? id;
  int? userId;
  int? plansId;
  int? tellaCoins;
  String? createdAt;
  String? updatedAt;
  String? bank;
  String? accountName;
  String? accountNumber;
  Plan? plan;

  UserWallet(
      {this.id,
      this.userId,
      this.plansId,
      this.tellaCoins,
      this.createdAt,
      this.updatedAt,
      this.bank,
      this.accountName,
      this.accountNumber,
      this.plan});

  UserWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    plansId = json['plans_id'];
    tellaCoins = json['tella_coins'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bank = json['bank'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['plans_id'] = this.plansId;
    data['tella_coins'] = this.tellaCoins;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['bank'] = this.bank;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    return data;
  }
}