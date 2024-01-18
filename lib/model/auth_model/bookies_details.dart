 

class BookiesDetails {
    final bool? success;
    final BookiesDetailsData? data;

    BookiesDetails({
        this.success,
        this.data,
    });

    factory BookiesDetails.fromJson(Map<String, dynamic> json) => BookiesDetails(
        success: json["success"],
        data: json["data"] == null ? null : BookiesDetailsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };
}

class BookiesDetailsData {
    final DataData? data;
    final int? status;
    final String? message;

    BookiesDetailsData({
        this.data,
        this.status,
        this.message,
    });

    factory BookiesDetailsData.fromJson(Map<String, dynamic> json) => BookiesDetailsData(
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "message": message,
    };
}

class DataData {
    final List<dynamic>? errors;
    final String? status;
    final Conversion? conversion;

    DataData({
        this.errors,
        this.status,
        this.conversion,
    });

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
        status: json["status"],
        conversion: json["conversion"] == null ? null : Conversion.fromJson(json["conversion"]),
    );

    Map<String, dynamic> toJson() => {
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
        "status": status,
        "conversion": conversion?.toJson(),
    };
}

class Conversion {
    final int? id;
    final Dump? dump;
    final dynamic errors;
    final int? status;
    final String? channel;
    final DateTime? endsAt;
    final int? gravity;
    final DateTime? startsAt;
    final DateTime? createdAt;
    final String? identifier;
    final DateTime? updatedAt;
    final Bookie? homeBookie;
    final String? bookingCode;
    final String? bookiesTrain;
    final String? destBookieKey;
    final String? destTotalOdds;
    final String? homeTotalOdds;
    final String? destinationCode;
    final int? percentProgress;
    final String? destTotalEvents;
    final String? homeTotalEvents;
    final Bookie? destinationBookie;
    final int? isFullConversion;
    final int? noOfHomeEntries;

    Conversion({
        this.id,
        this.dump,
        this.errors,
        this.status,
        this.channel,
        this.endsAt,
        this.gravity,
        this.startsAt,
        this.createdAt,
        this.identifier,
        this.updatedAt,
        this.homeBookie,
        this.bookingCode,
        this.bookiesTrain,
        this.destBookieKey,
        this.destTotalOdds,
        this.homeTotalOdds,
        this.destinationCode,
        this.percentProgress,
        this.destTotalEvents,
        this.homeTotalEvents,
        this.destinationBookie,
        this.isFullConversion,
        this.noOfHomeEntries,
    });

    factory Conversion.fromJson(Map<String, dynamic> json) => Conversion(
        id: json["id"],
        dump: json["dump"] == null ? null : Dump.fromJson(json["dump"]),
        errors: json["errors"],
        status: json["status"],
        channel: json["channel"],
        endsAt: json["ends_at"] == null ? null : DateTime.parse(json["ends_at"]),
        gravity: json["gravity"],
        startsAt: json["starts_at"] == null ? null : DateTime.parse(json["starts_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        identifier: json["identifier"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        homeBookie: json["home_bookie"] == null ? null : Bookie.fromJson(json["home_bookie"]),
        bookingCode: json["booking_code"],
        bookiesTrain: json["bookies_train"],
        destBookieKey: json["dest_bookie_key"],
        destTotalOdds: json["dest_total_odds"],
        homeTotalOdds: json["home_total_odds"],
        destinationCode: json["destination_code"],
        percentProgress: json["percent_progress"],
        destTotalEvents: json["dest_total_events"],
        homeTotalEvents: json["home_total_events"],
        destinationBookie: json["destination_bookie"] == null ? null : Bookie.fromJson(json["destination_bookie"]),
        isFullConversion: json["is_full_conversion"],
        noOfHomeEntries: json["no_of_home_entries"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dump": dump?.toJson(),
        "errors": errors,
        "status": status,
        "channel": channel,
        "ends_at": endsAt?.toIso8601String(),
        "gravity": gravity,
        "starts_at": startsAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "identifier": identifier,
        "updated_at": updatedAt?.toIso8601String(),
        "home_bookie": homeBookie?.toJson(),
        "booking_code": bookingCode,
        "bookies_train": bookiesTrain,
        "dest_bookie_key": destBookieKey,
        "dest_total_odds": destTotalOdds,
        "home_total_odds": homeTotalOdds,
        "destination_code": destinationCode,
        "percent_progress": percentProgress,
        "dest_total_events": destTotalEvents,
        "home_total_events": homeTotalEvents,
        "destination_bookie": destinationBookie?.toJson(),
        "is_full_conversion": isFullConversion,
        "no_of_home_entries": noOfHomeEntries,
    };
}

class Bookie {
    final int? id;
    final String? name;
    final dynamic status;
    final dynamic details;
    final String? keyName;
    final int? countryId;
    final dynamic createdAt;
    final DateTime? updatedAt;

    Bookie({
        this.id,
        this.name,
        this.status,
        this.details,
        this.keyName,
        this.countryId,
        this.createdAt,
        this.updatedAt,
    });

    factory Bookie.fromJson(Map<String, dynamic> json) => Bookie(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        details: json["details"],
        keyName: json["key_name"],
        countryId: json["country_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "details": details,
        "key_name": keyName,
        "country_id": countryId,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Dump {
    final DumpDestination? home;
    final List<ListElement>? lists;
    final DumpDestination? destination;

    Dump({
        this.home,
        this.lists,
        this.destination,
    });

    factory Dump.fromJson(Map<String, dynamic> json) => Dump(
        home: json["home"] == null ? null : DumpDestination.fromJson(json["home"]),
        lists: json["lists"] == null ? [] : List<ListElement>.from(json["lists"]!.map((x) => ListElement.fromJson(x))),
        destination: json["destination"] == null ? null : DumpDestination.fromJson(json["destination"]),
    );

    Map<String, dynamic> toJson() => {
        "home": home?.toJson(),
        "lists": lists == null ? [] : List<dynamic>.from(lists!.map((x) => x.toJson())),
        "destination": destination?.toJson(),
    };
}

class DumpDestination {
    final double? odds;
    final String? bookie;
    final int? noOfEntries;

    DumpDestination({
        this.odds,
        this.bookie,
        this.noOfEntries,
    });

    factory DumpDestination.fromJson(Map<String, dynamic> json) => DumpDestination(
        odds: json["odds"]?.toDouble(),
        bookie: json["bookie"],
        noOfEntries: json["no_of_entries"],
    );

    Map<String, dynamic> toJson() => {
        "odds": odds,
        "bookie": bookie,
        "no_of_entries": noOfEntries,
    };
}

class ListElement {
    final ListDestination? home;
    final Sport? sport;
    final ListDestination? destination;
    final bool? isConverted;
    final dynamic exemptReason;

    ListElement({
        this.home,
        this.sport,
        this.destination,
        this.isConverted,
        this.exemptReason,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        home: json["home"] == null ? null : ListDestination.fromJson(json["home"]),
        sport: json["sport"] == null ? null : Sport.fromJson(json["sport"]),
        destination: json["destination"] == null ? null : ListDestination.fromJson(json["destination"]),
        isConverted: json["is_converted"],
        exemptReason: json["exempt_reason"],
    );

    Map<String, dynamic> toJson() => {
        "home": home?.toJson(),
        "sport": sport?.toJson(),
        "destination": destination?.toJson(),
        "is_converted": isConverted,
        "exempt_reason": exemptReason,
    };
}

class ListDestination {
    final SportId? sportId;
    final String? awayTeam;
    final String? homeTeam;
    final DateTime? itemDate;
    final String? itemName;
    final double? oddValue;
    final MarketName? marketName;
    final OutcomeName? outcomeName;
    final String? categoryName;
    final String? tournamentName;
    final DateTime? itemUtcDate;

    ListDestination({
        this.sportId,
        this.awayTeam,
        this.homeTeam,
        this.itemDate,
        this.itemName,
        this.oddValue,
        this.marketName,
        this.outcomeName,
        this.categoryName,
        this.tournamentName,
        this.itemUtcDate,
    });

    factory ListDestination.fromJson(Map<String, dynamic> json) => ListDestination(
        sportId: sportIdValues.map[json["sport_id"]]!,
        awayTeam: json["away_team"],
        homeTeam: json["home_team"],
        itemDate: json["item_date"] == null ? null : DateTime.parse(json["item_date"]),
        itemName: json["item_name"],
        oddValue: json["odd_value"]?.toDouble(),
        marketName: marketNameValues.map[json["market_name"]]!,
        outcomeName: outcomeNameValues.map[json["outcome_name"]]!,
        categoryName: json["category_name"],
        tournamentName: json["tournament_name"],
        itemUtcDate: json["item_utc_date"] == null ? null : DateTime.parse(json["item_utc_date"]),
    );

    Map<String, dynamic> toJson() => {
        "sport_id": sportIdValues.reverse[sportId],
        "away_team": awayTeam,
        "home_team": homeTeam,
        "item_date": itemDate?.toIso8601String(),
        "item_name": itemName,
        "odd_value": oddValue,
        "market_name": marketNameValues.reverse[marketName],
        "outcome_name": outcomeNameValues.reverse[outcomeName],
        "category_name": categoryName,
        "tournament_name": tournamentName,
        "item_utc_date": itemUtcDate?.toIso8601String(),
    };
}

enum MarketName {
    MARKET_NAME_TOTAL,
    TOTAL
}

final marketNameValues = EnumValues({
    "Total": MarketName.MARKET_NAME_TOTAL,
    " - Total": MarketName.TOTAL
});

enum OutcomeName {
    TOTAL_UNDER_25
}

final outcomeNameValues = EnumValues({
    "Total Under (2.5)": OutcomeName.TOTAL_UNDER_25
});

enum SportId {
    SOCCER
}

final sportIdValues = EnumValues({
    "soccer": SportId.SOCCER
});

class Sport {
    final SportId? id;
    final String? icon;

    Sport({
        this.id,
        this.icon,
    });

    factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        id: sportIdValues.map[json["id"]]!,
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": sportIdValues.reverse[id],
        "icon": icon,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
