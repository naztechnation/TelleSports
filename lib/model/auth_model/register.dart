class RegisterUser {
  bool? success;
  String? code;
  String? message;
  String? email;

  RegisterUser({this.success, this.code, this.message});

  RegisterUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    data['email'] = this.email;
    return data;
  }
}
