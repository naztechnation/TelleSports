class PlansList {
  bool? success;
  String? message;
  List<Datum>? data;

  PlansList({this.success, this.message, this.data});

  PlansList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Datum>[];
      json['data'].forEach((v) {
        data!.add(new Datum.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datum {
  int? id;
  String? name;
  String? tellacoin;
  String? price;
  List<String>? functionality;
  String? createdAt;
  String? updatedAt;

  Datum(
      {this.id,
      this.name,
      this.tellacoin,
      this.price,
      this.functionality,
      this.createdAt,
      this.updatedAt});

  Datum.fromJson(Map<String, dynamic> json) {
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
