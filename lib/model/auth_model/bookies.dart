
class BookiesList {
  bool? success;
  String? message;
  List<BookiesData>? data;

  BookiesList({this.success, this.message, this.data});



  BookiesList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookiesData>[];
      json['data'].forEach((v) {
        data!.add(BookiesData.fromJson(v));
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

class BookiesData {
  String? bookie;
  String? from;
  String? to;
  String? name;
  String? img;

  BookiesData({this.bookie, this.from, this.to, this.name, this.img});

  BookiesData.fromJson(Map<String, dynamic> json) {
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
