

class BookiesList {
  bool? success;
  String? message;
  List<Data>? data;

  BookiesList({this.success, this.message, this.data});



  BookiesList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? bookie;
  String? from;
  String? to;
  String? name;
  String? img;

  Data({this.bookie, this.from, this.to, this.name, this.img});

  Data.fromJson(Map<String, dynamic> json) {
    bookie = json['bookie'];
    from = json['from'];
    to = json['to'];
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['bookie'] = bookie;
    data['from'] =  from;
    data['to'] =  to;
    data['name'] =  name;
    data['img'] =  img;
    return data;
  }
}
