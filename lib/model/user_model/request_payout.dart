

class RequestPayout {
  bool? success;
  Data? data;

  RequestPayout({this.success, this.data});

  RequestPayout.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? bank;
  String? accountBankCode;
  String? accountNumber;
  String? amount;
  String? currency;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.bank,
      this.accountBankCode,
      this.accountNumber,
      this.amount,
      this.currency,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    accountBankCode = json['account_bank_code'];
    accountNumber = json['account_number'];
    amount = json['amount'];
    currency = json['currency'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank'] = this.bank;
    data['account_bank_code'] = this.accountBankCode;
    data['account_number'] = this.accountNumber;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
