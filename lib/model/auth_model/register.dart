

class RegisterUser {
    bool? success;
    int? code;
    String? message;
    Errors? errors;

    RegisterUser({
        this.success,
        this.message,
        this.code,
        this.errors,
    });

    factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        success: json["success"],
        message: json["message"],
        code: json["code"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "code": code,
        "errors": errors?.toJson(),
    };
}

class Errors {
    List<String>? username;
    List<String>? email;
    List<String>? phone;

    Errors({
        this.username,
        this.email,
        this.phone,
    });

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        username: json["username"] == null ? [] : List<String>.from(json["username"]!.map((x) => x)),
        email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
        phone: json["phone"] == null ? [] : List<String>.from(json["phone"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "username": username == null ? [] : List<dynamic>.from(username!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "phone": phone == null ? [] : List<dynamic>.from(phone!.map((x) => x)),
    };
}
