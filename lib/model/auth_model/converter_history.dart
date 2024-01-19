class ConverterHistory {
  bool? success;
  String? message;
  List<ConverterHistoryData>? data;

  ConverterHistory({this.success, this.message, this.data});

  ConverterHistory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ConverterHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new ConverterHistoryData.fromJson(v));
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

class ConverterHistoryData {
  int? id;
  int? userId;
  String? convertedFrom;
  String? convertedTo;
  String? sourceCode;
  String? destinationCode;
  String? createdAt;
  String? updatedAt;

  ConverterHistoryData(
      {this.id,
      this.userId,
      this.convertedFrom,
      this.convertedTo,
      this.sourceCode,
      this.destinationCode,
      this.createdAt,
      this.updatedAt});

  ConverterHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    convertedFrom = json['converted_from'];
    convertedTo = json['converted_to'];
    sourceCode = json['source_code'];
    destinationCode = json['destination_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['converted_from'] = this.convertedFrom;
    data['converted_to'] = this.convertedTo;
    data['source_code'] = this.sourceCode;
    data['destination_code'] = this.destinationCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
