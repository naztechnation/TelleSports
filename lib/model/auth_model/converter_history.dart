class ConverterHistory {
  ConverterHistory({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  ConverterHistory copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
  }) =>
      ConverterHistory(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ConverterHistory.fromJson(Map<String, dynamic> json) =>
      ConverterHistory(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.convertedFrom,
    this.convertedTo,
    this.sourceCode,
    this.destinationCode,
    this.status,
  });

  final String? createdAt;
  final String? updatedAt;
  final String? userId;
  final String? convertedFrom;
  final String? convertedTo;
  final String? sourceCode;
  final dynamic destinationCode;
  final String? status;

  Datum copyWith({
    String? createdAt,
    String? updatedAt,
    String? userId,
    String? convertedFrom,
    String? convertedTo,
    String? sourceCode,
    dynamic destinationCode,
    String? status,
  }) =>
      Datum(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
        convertedFrom: convertedFrom ?? this.convertedFrom,
        convertedTo: convertedTo ?? this.convertedTo,
        sourceCode: sourceCode ?? this.sourceCode,
        destinationCode: destinationCode ?? this.destinationCode,
        status: status ?? this.status,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userId: json["user_id"],
        convertedFrom: json["converted_from"],
        convertedTo: json["converted_to"],
        sourceCode: json["source_code"],
        destinationCode: json["destination_code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_id": userId,
        "converted_from": convertedFrom,
        "converted_to": convertedTo,
        "source_code": sourceCode,
        "destination_code": destinationCode,
        "status": status,
      };
}
