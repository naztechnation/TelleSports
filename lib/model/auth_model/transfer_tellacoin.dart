
class TransferTellacoin {
  bool? success;
  Data? data;
  String? message;

  TransferTellacoin({this.success, this.data, this.message});

  TransferTellacoin.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? plansId;
  int? tellaCoins;
  String? createdAt;
  String? updatedAt;
  Null? bank;
  Null? accountName;
  Null? accountNumber;

  Data(
      {this.id,
      this.userId,
      this.plansId,
      this.tellaCoins,
      this.createdAt,
      this.updatedAt,
      this.bank,
      this.accountName,
      this.accountNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    plansId = json['plans_id'];
    tellaCoins = json['tella_coins'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bank = json['bank'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
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
    return data;
  }
}
