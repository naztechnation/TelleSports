  
class BookiesDetails {
    final bool? success;
    final BookiesDetailsData? data;

    BookiesDetails({
        this.success,
        this.data,
    });

    BookiesDetails copyWith({
        bool? success,
        BookiesDetailsData? data,
    }) => 
        BookiesDetails(
            success: success ?? this.success,
            data: data ?? this.data,
        );

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
    final String? message;
    final int? status;

    BookiesDetailsData({
        this.data,
        this.message,
        this.status,
    });

    BookiesDetailsData copyWith({
        DataData? data,
        String? message,
        int? status,
    }) => 
        BookiesDetailsData(
            data: data ?? this.data,
            message: message ?? this.message,
            status: status ?? this.status,
        );

    factory BookiesDetailsData.fromJson(Map<String, dynamic> json) => BookiesDetailsData(
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "status": status,
    };
}

class DataData {
    final List<dynamic>? errors;
    final Conversion? conversion;

    DataData({
        this.errors,
        this.conversion,
    });

    DataData copyWith({
        List<dynamic>? errors,
        Conversion? conversion,
    }) => 
        DataData(
            errors: errors ?? this.errors,
            conversion: conversion ?? this.conversion,
        );

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
        conversion: json["conversion"] == null ? null : Conversion.fromJson(json["conversion"]),
    );

    Map<String, dynamic> toJson() => {
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
        "conversion": conversion?.toJson(),
    };
}

class Conversion {
    final int? id;
    final int? identifier;
    final String? bookiesTrain;
    final String? bookingCode;
    final String? destinationCode;
    final Dump? dump;
    final String? channel;
    final int? status;
    final DateTime? startsAt;
    final DateTime? endsAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic errors;
    final Bookie? homeBookie;
    final Bookie? destinationBookie;

    Conversion({
        this.id,
        this.identifier,
        this.bookiesTrain,
        this.bookingCode,
        this.destinationCode,
        this.dump,
        this.channel,
        this.status,
        this.startsAt,
        this.endsAt,
        this.createdAt,
        this.updatedAt,
        this.errors,
        this.homeBookie,
        this.destinationBookie,
    });

    Conversion copyWith({
        int? id,
        int? identifier,
        String? bookiesTrain,
        String? bookingCode,
        String? destinationCode,
        Dump? dump,
        String? channel,
        int? status,
        DateTime? startsAt,
        DateTime? endsAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic errors,
        Bookie? homeBookie,
        Bookie? destinationBookie,
    }) => 
        Conversion(
            id: id ?? this.id,
            identifier: identifier ?? this.identifier,
            bookiesTrain: bookiesTrain ?? this.bookiesTrain,
            bookingCode: bookingCode ?? this.bookingCode,
            destinationCode: destinationCode ?? this.destinationCode,
            dump: dump ?? this.dump,
            channel: channel ?? this.channel,
            status: status ?? this.status,
            startsAt: startsAt ?? this.startsAt,
            endsAt: endsAt ?? this.endsAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            errors: errors ?? this.errors,
            homeBookie: homeBookie ?? this.homeBookie,
            destinationBookie: destinationBookie ?? this.destinationBookie,
        );

    factory Conversion.fromJson(Map<String, dynamic> json) => Conversion(
        id: json["id"],
        identifier: json["identifier"],
        bookiesTrain: json["bookies_train"],
        bookingCode: json["booking_code"],
        destinationCode: json["destination_code"],
        dump: json["dump"] == null ? null : Dump.fromJson(json["dump"]),
        channel: json["channel"],
        status: json["status"],
        startsAt: json["starts_at"] == null ? null : DateTime.parse(json["starts_at"]),
        endsAt: json["ends_at"] == null ? null : DateTime.parse(json["ends_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        errors: json["errors"],
        homeBookie: json["home_bookie"] == null ? null : Bookie.fromJson(json["home_bookie"]),
        destinationBookie: json["destination_bookie"] == null ? null : Bookie.fromJson(json["destination_bookie"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "identifier": identifier,
        "bookies_train": bookiesTrain,
        "booking_code": bookingCode,
        "destination_code": destinationCode,
        "dump": dump?.toJson(),
        "channel": channel,
        "status": status,
        "starts_at": startsAt?.toIso8601String(),
        "ends_at": endsAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "errors": errors,
        "home_bookie": homeBookie?.toJson(),
        "destination_bookie": destinationBookie?.toJson(),
    };
}

class Bookie {
    final int? id;
    final String? name;
    final String? keyName;
    final int? countryId;
    final dynamic status;
    final dynamic createdAt;
    final DateTime? updatedAt;

    Bookie({
        this.id,
        this.name,
        this.keyName,
        this.countryId,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    Bookie copyWith({
        int? id,
        String? name,
        String? keyName,
        int? countryId,
        dynamic status,
        dynamic createdAt,
        DateTime? updatedAt,
    }) => 
        Bookie(
            id: id ?? this.id,
            name: name ?? this.name,
            keyName: keyName ?? this.keyName,
            countryId: countryId ?? this.countryId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Bookie.fromJson(Map<String, dynamic> json) => Bookie(
        id: json["id"],
        name: json["name"],
        keyName: json["key_name"],
        countryId: json["country_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "key_name": keyName,
        "country_id": countryId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Dump {
    final bool? usedNeq;
    final DumpDestination? home;
    final DumpDestination? destination;
    final List<ListElement>? lists;
    final DateTime? startsAt;
    final DateTime? endsAt;

    Dump({
        this.usedNeq,
        this.home,
        this.destination,
        this.lists,
        this.startsAt,
        this.endsAt,
    });

    Dump copyWith({
        bool? usedNeq,
        DumpDestination? home,
        DumpDestination? destination,
        List<ListElement>? lists,
        DateTime? startsAt,
        DateTime? endsAt,
    }) => 
        Dump(
            usedNeq: usedNeq ?? this.usedNeq,
            home: home ?? this.home,
            destination: destination ?? this.destination,
            lists: lists ?? this.lists,
            startsAt: startsAt ?? this.startsAt,
            endsAt: endsAt ?? this.endsAt,
        );

    factory Dump.fromJson(Map<String, dynamic> json) => Dump(
        usedNeq: json["used_neq"],
        home: json["home"] == null ? null : DumpDestination.fromJson(json["home"]),
        destination: json["destination"] == null ? null : DumpDestination.fromJson(json["destination"]),
        lists: json["lists"] == null ? [] : List<ListElement>.from(json["lists"]!.map((x) => ListElement.fromJson(x))),
        startsAt: json["starts_at"] == null ? null : DateTime.parse(json["starts_at"]),
        endsAt: json["ends_at"] == null ? null : DateTime.parse(json["ends_at"]),
    );

    Map<String, dynamic> toJson() => {
        "used_neq": usedNeq,
        "home": home?.toJson(),
        "destination": destination?.toJson(),
        "lists": lists == null ? [] : List<dynamic>.from(lists!.map((x) => x.toJson())),
        "starts_at": startsAt?.toIso8601String(),
        "ends_at": endsAt?.toIso8601String(),
    };
}

class DumpDestination {
    final String? bookie;
    final String? bookieName;
    final String? bookieCountry;
    final String? odds;
    final int? noOfEntries;

    DumpDestination({
        this.bookie,
        this.bookieName,
        this.bookieCountry,
        this.odds,
        this.noOfEntries,
    });

    DumpDestination copyWith({
        String? bookie,
        String? bookieName,
        String? bookieCountry,
        String? odds,
        int? noOfEntries,
    }) => 
        DumpDestination(
            bookie: bookie ?? this.bookie,
            bookieName: bookieName ?? this.bookieName,
            bookieCountry: bookieCountry ?? this.bookieCountry,
            odds: odds ?? this.odds,
            noOfEntries: noOfEntries ?? this.noOfEntries,
        );

    factory DumpDestination.fromJson(Map<String, dynamic> json) => DumpDestination(
        bookie: json["bookie"],
        bookieName: json["bookie_name"],
        bookieCountry: json["bookie_country"],
        odds: json["odds"],
        noOfEntries: json["no_of_entries"],
    );

    Map<String, dynamic> toJson() => {
        "bookie": bookie,
        "bookie_name": bookieName,
        "bookie_country": bookieCountry,
        "odds": odds,
        "no_of_entries": noOfEntries,
    };
}

class ListElement {
    final Sport? sport;
    final bool? isNeq;
    final bool? isConverted;
    final dynamic exemptReason;
    final ListDestination? home;
    final ListDestination? destination;

    ListElement({
        this.sport,
        this.isNeq,
        this.isConverted,
        this.exemptReason,
        this.home,
        this.destination,
    });

    ListElement copyWith({
        Sport? sport,
        bool? isNeq,
        bool? isConverted,
        dynamic exemptReason,
        ListDestination? home,
        ListDestination? destination,
    }) => 
        ListElement(
            sport: sport ?? this.sport,
            isNeq: isNeq ?? this.isNeq,
            isConverted: isConverted ?? this.isConverted,
            exemptReason: exemptReason ?? this.exemptReason,
            home: home ?? this.home,
            destination: destination ?? this.destination,
        );

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        sport: json["sport"] == null ? null : Sport.fromJson(json["sport"]),
        isNeq: json["is_neq"],
        isConverted: json["is_converted"],
        exemptReason: json["exempt_reason"],
        home: json["home"] == null ? null : ListDestination.fromJson(json["home"]),
        destination: json["destination"] == null ? null : ListDestination.fromJson(json["destination"]),
    );

    Map<String, dynamic> toJson() => {
        "sport": sport?.toJson(),
        "is_neq": isNeq,
        "is_converted": isConverted,
        "exempt_reason": exemptReason,
        "home": home?.toJson(),
        "destination": destination?.toJson(),
    };
}

class ListDestination {
    final String? itemName;
    final String? homeTeam;
    final String? awayTeam;
    final DateTime? itemDate;
    final String? sportId;
    final String? tournamentName;
    final String? categoryName;
    final String? marketName;
    final String? outcomeName;
    final double? oddValue;
    final DateTime? itemUtcDate;

    ListDestination({
        this.itemName,
        this.homeTeam,
        this.awayTeam,
        this.itemDate,
        this.sportId,
        this.tournamentName,
        this.categoryName,
        this.marketName,
        this.outcomeName,
        this.oddValue,
        this.itemUtcDate,
    });

    ListDestination copyWith({
        String? itemName,
        String? homeTeam,
        String? awayTeam,
        DateTime? itemDate,
        String? sportId,
        String? tournamentName,
        String? categoryName,
        String? marketName,
        String? outcomeName,
        double? oddValue,
        DateTime? itemUtcDate,
    }) => 
        ListDestination(
            itemName: itemName ?? this.itemName,
            homeTeam: homeTeam ?? this.homeTeam,
            awayTeam: awayTeam ?? this.awayTeam,
            itemDate: itemDate ?? this.itemDate,
            sportId: sportId ?? this.sportId,
            tournamentName: tournamentName ?? this.tournamentName,
            categoryName: categoryName ?? this.categoryName,
            marketName: marketName ?? this.marketName,
            outcomeName: outcomeName ?? this.outcomeName,
            oddValue: oddValue ?? this.oddValue,
            itemUtcDate: itemUtcDate ?? this.itemUtcDate,
        );

    factory ListDestination.fromJson(Map<String, dynamic> json) => ListDestination(
        itemName: json["item_name"],
        homeTeam: json["home_team"],
        awayTeam: json["away_team"],
        itemDate: json["item_date"] == null ? null : DateTime.parse(json["item_date"]),
        sportId: json["sport_id"],
        tournamentName: json["tournament_name"],
        categoryName: json["category_name"],
        marketName: json["market_name"],
        outcomeName: json["outcome_name"],
        oddValue: json["odd_value"]?.toDouble(),
        itemUtcDate: json["item_utc_date"] == null ? null : DateTime.parse(json["item_utc_date"]),
    );

    Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "home_team": homeTeam,
        "away_team": awayTeam,
        "item_date": itemDate?.toIso8601String(),
        "sport_id": sportId,
        "tournament_name": tournamentName,
        "category_name": categoryName,
        "market_name": marketName,
        "outcome_name": outcomeName,
        "odd_value": oddValue,
        "item_utc_date": itemUtcDate?.toIso8601String(),
    };
}

class Sport {
    final String? id;
    final String? icon;

    Sport({
        this.id,
        this.icon,
    });

    Sport copyWith({
        String? id,
        String? icon,
    }) => 
        Sport(
            id: id ?? this.id,
            icon: icon ?? this.icon,
        );

    factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        id: json["id"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
    };
}
