class  BankCountryCode {
  bool? success;
  BankCountryCodeData? data;

  BankCountryCode({this.success, this.data});

  BankCountryCode.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new BankCountryCodeData.fromJson(json['data']) : null;
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

class BankCountryCodeData {
  String? status;
  String? message;
  List<CountryData>? data;

  BankCountryCodeData({this.status, this.message, this.data});

  BankCountryCodeData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CountryData>[];
      json['data'].forEach((v) {
        data!.add(new CountryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryData {
  int? id;
  String? code;
  String? name;

  CountryData({this.id, this.code, this.name});

  CountryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}
