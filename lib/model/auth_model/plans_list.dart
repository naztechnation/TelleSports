
class PlansList {
  PlansList({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  PlansList copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
  }) =>
      PlansList(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PlansList.fromJson(Map<String, dynamic> json) => PlansList(
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
    this.id,
    this.name,
    this.price,
    this.unit,
    this.noOfConversion,
    this.abilities,
    this.sportsApi,
    this.communities,
  });

  final int? id;
  final String? name;
  final String? price;
  final String? unit;
  final String? noOfConversion;
  final String? abilities;
  final String? sportsApi;
  final String? communities;

  Datum copyWith({
    int? id,
    String? name,
    String? price,
    String? unit,
    String? noOfConversion,
    String? abilities,
    String? sportsApi,
    String? communities,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        unit: unit ?? this.unit,
        noOfConversion: noOfConversion ?? this.noOfConversion,
        abilities: abilities ?? this.abilities,
        sportsApi: sportsApi ?? this.sportsApi,
        communities: communities ?? this.communities,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["Name"],
        price: json["price"],
        unit: json["unit"],
        noOfConversion: json["No_of_conversion"],
        abilities: json["Abilities"],
        sportsApi: json["sports_api"],
        communities: json["communities"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "price": price,
        "unit": unit,
        "No_of_conversion": noOfConversion,
        "Abilities": abilities,
        "sports_api": sportsApi,
        "communities": communities,
      };
}
