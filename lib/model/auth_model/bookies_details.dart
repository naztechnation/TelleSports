class BookiesDetails {
    BookiesDetails({
        required this.success,
        required this.data,
    });

    final bool? success;
    final BookiesDetailsData? data;

    BookiesDetails copyWith({
        bool? success,
        BookiesDetailsData? data,
    }) {
        return BookiesDetails(
            success: success ?? this.success,
            data: data ?? this.data,
        );
    }

    factory BookiesDetails.fromJson(Map<String, dynamic> json){ 
        return BookiesDetails(
            success: json["success"],
            data: json["data"] == null ? null : BookiesDetailsData.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };

    @override
    String toString(){
        return "$success, $data, ";
    }
}

class BookiesDetailsData {
    BookiesDetailsData({
        required this.data,
        required this.message,
        required this.status,
    });

    final DataData? data;
    final String? message;
    final int? status;

    BookiesDetailsData copyWith({
        DataData? data,
        String? message,
        int? status,
    }) {
        return BookiesDetailsData(
            data: data ?? this.data,
            message: message ?? this.message,
            status: status ?? this.status,
        );
    }

    factory BookiesDetailsData.fromJson(Map<String, dynamic> json){ 
        return BookiesDetailsData(
            data: json["data"] == null ? null : DataData.fromJson(json["data"]),
            message: json["message"],
            status: json["status"],
        );
    }

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "status": status,
    };

    @override
    String toString(){
        return "$data, $message, $status, ";
    }
}

class DataData {
    DataData({
        required this.errors,
        required this.conversion,
        required this.status,
    });

    final List<dynamic> errors;
    final Conversion? conversion;
    final String? status;

    DataData copyWith({
        List<dynamic>? errors,
        Conversion? conversion,
        String? status,
    }) {
        return DataData(
            errors: errors ?? this.errors,
            conversion: conversion ?? this.conversion,
            status: status ?? this.status,
        );
    }

    factory DataData.fromJson(Map<String, dynamic> json){ 
        return DataData(
            errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
            conversion: json["conversion"] == null ? null : Conversion.fromJson(json["conversion"]),
            status: json["status"],
        );
    }

    Map<String, dynamic> toJson() => {
        "errors": errors.map((x) => x).toList(),
        "conversion": conversion?.toJson(),
        "status": status,
    };

    @override
    String toString(){
        return "$errors, $conversion, $status, ";
    }
}

class Conversion {
    Conversion({
        required this.id,
        required this.bookiesTrain,
        required this.bookingCode,
        required this.destinationCode,
        required this.dump,
        required this.channel,
        required this.status,
        required this.startsAt,
        required this.endsAt,
        required this.gravity,
        required this.createdAt,
        required this.updatedAt,
        required this.percentProgress,
        required this.errors,
    });

    final int? id;
    final String? bookiesTrain;
    final String? bookingCode;
    final String? destinationCode;
    final Dump? dump;
    final String? channel;
    final int? status;
    final DateTime? startsAt;
    final DateTime? endsAt;
    final int? gravity;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? percentProgress;
    final List<dynamic> errors;

    Conversion copyWith({
        int? id,
        String? bookiesTrain,
        String? bookingCode,
        String? destinationCode,
        Dump? dump,
        String? channel,
        int? status,
        DateTime? startsAt,
        DateTime? endsAt,
        int? gravity,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? percentProgress,
        List<dynamic>? errors,
    }) {
        return Conversion(
            id: id ?? this.id,
            bookiesTrain: bookiesTrain ?? this.bookiesTrain,
            bookingCode: bookingCode ?? this.bookingCode,
            destinationCode: destinationCode ?? this.destinationCode,
            dump: dump ?? this.dump,
            channel: channel ?? this.channel,
            status: status ?? this.status,
            startsAt: startsAt ?? this.startsAt,
            endsAt: endsAt ?? this.endsAt,
            gravity: gravity ?? this.gravity,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            percentProgress: percentProgress ?? this.percentProgress,
            errors: errors ?? this.errors,
        );
    }

    factory Conversion.fromJson(Map<String, dynamic> json){ 
        return Conversion(
            id: json["id"],
            bookiesTrain: json["bookies_train"],
            bookingCode: json["booking_code"],
            destinationCode: json["destination_code"],
            dump: json["dump"] == null ? null : Dump.fromJson(json["dump"]),
            channel: json["channel"],
            status: json["status"],
            startsAt: DateTime.tryParse(json["starts_at"] ?? ""),
            endsAt: DateTime.tryParse(json["ends_at"] ?? ""),
            gravity: json["gravity"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            percentProgress: json["percent_progress"],
            errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "bookies_train": bookiesTrain,
        "booking_code": bookingCode,
        "destination_code": destinationCode,
        "dump": dump?.toJson(),
        "channel": channel,
        "status": status,
        "starts_at": startsAt?.toIso8601String(),
        "ends_at": endsAt?.toIso8601String(),
        "gravity": gravity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "percent_progress": percentProgress,
        "errors": errors.map((x) => x).toList(),
    };

    @override
    String toString(){
        return "$id, $bookiesTrain, $bookingCode, $destinationCode, $dump, $channel, $status, $startsAt, $endsAt, $gravity, $createdAt, $updatedAt, $percentProgress, $errors, ";
    }
}

class Dump {
    Dump({
        required this.home,
        required this.destination,
        required this.lists,
    });

    final DumpDestination? home;
    final DumpDestination? destination;
    final List<ListElement> lists;

    Dump copyWith({
        DumpDestination? home,
        DumpDestination? destination,
        List<ListElement>? lists,
    }) {
        return Dump(
            home: home ?? this.home,
            destination: destination ?? this.destination,
            lists: lists ?? this.lists,
        );
    }

    factory Dump.fromJson(Map<String, dynamic> json){ 
        return Dump(
            home: json["home"] == null ? null : DumpDestination.fromJson(json["home"]),
            destination: json["destination"] == null ? null : DumpDestination.fromJson(json["destination"]),
            lists: json["lists"] == null ? [] : List<ListElement>.from(json["lists"]!.map((x) => ListElement.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "home": home?.toJson(),
        "destination": destination?.toJson(),
        "lists": lists.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$home, $destination, $lists, ";
    }
}

class DumpDestination {
    DumpDestination({
        required this.bookie,
        required this.odds,
    });

    final String? bookie;
    final String? odds;

    DumpDestination copyWith({
        String? bookie,
        String? odds,
    }) {
        return DumpDestination(
            bookie: bookie ?? this.bookie,
            odds: odds ?? this.odds,
        );
    }

    factory DumpDestination.fromJson(Map<String, dynamic> json){ 
        return DumpDestination(
            bookie: json["bookie"],
            odds: json["odds"],
        );
    }

    Map<String, dynamic> toJson() => {
        "bookie": bookie,
        "odds": odds,
    };

    @override
    String toString(){
        return "$bookie, $odds, ";
    }
}

class ListElement {
    ListElement({
        required this.sport,
        required this.isConverted,
        required this.exemptReason,
        required this.home,
        required this.destination,
    });

    final Sport? sport;
    final bool? isConverted;
    final String? exemptReason;
    final DestinationDestination? home;
    final dynamic? destination;

    ListElement copyWith({
        Sport? sport,
        bool? isConverted,
        String? exemptReason,
        DestinationDestination? home,
        dynamic? destination,
    }) {
        return ListElement(
            sport: sport ?? this.sport,
            isConverted: isConverted ?? this.isConverted,
            exemptReason: exemptReason ?? this.exemptReason,
            home: home ?? this.home,
            destination: destination ?? this.destination,
        );
    }

    factory ListElement.fromJson(Map<String, dynamic> json){ 
        return ListElement(
            sport: json["sport"] == null ? null : Sport.fromJson(json["sport"]),
            isConverted: json["is_converted"],
            exemptReason: json["exempt_reason"],
            home: json["home"] == null ? null : DestinationDestination.fromJson(json["home"]),
            destination: json["destination"],
        );
    }

    Map<String, dynamic> toJson() => {
        "sport": sport?.toJson(),
        "is_converted": isConverted,
        "exempt_reason": exemptReason,
        "home": home?.toJson(),
        "destination": destination,
    };

    @override
    String toString(){
        return "$sport, $isConverted, $exemptReason, $home, $destination, ";
    }
}

class DestinationDestination {
    DestinationDestination({
        required this.itemName,
        required this.homeTeam,
        required this.awayTeam,
        required this.itemDate,
        required this.tournamentName,
        required this.categoryName,
        required this.sportId,
        required this.marketName,
        required this.outcomeName,
        required this.oddValue,
        required this.itemUtcDate,
    });

    final String? itemName;
    final String? homeTeam;
    final String? awayTeam;
    final DateTime? itemDate;
    final String? tournamentName;
    final String? categoryName;
    final String? sportId;
    final String? marketName;
    final String? outcomeName;
    final String? oddValue;
    final DateTime? itemUtcDate;

    DestinationDestination copyWith({
        String? itemName,
        String? homeTeam,
        String? awayTeam,
        DateTime? itemDate,
        String? tournamentName,
        String? categoryName,
        String? sportId,
        String? marketName,
        String? outcomeName,
        String? oddValue,
        DateTime? itemUtcDate,
    }) {
        return DestinationDestination(
            itemName: itemName ?? this.itemName,
            homeTeam: homeTeam ?? this.homeTeam,
            awayTeam: awayTeam ?? this.awayTeam,
            itemDate: itemDate ?? this.itemDate,
            tournamentName: tournamentName ?? this.tournamentName,
            categoryName: categoryName ?? this.categoryName,
            sportId: sportId ?? this.sportId,
            marketName: marketName ?? this.marketName,
            outcomeName: outcomeName ?? this.outcomeName,
            oddValue: oddValue ?? this.oddValue,
            itemUtcDate: itemUtcDate ?? this.itemUtcDate,
        );
    }

    factory DestinationDestination.fromJson(Map<String, dynamic> json){ 
        return DestinationDestination(
            itemName: json["item_name"],
            homeTeam: json["home_team"],
            awayTeam: json["away_team"],
            itemDate: DateTime.tryParse(json["item_date"] ?? ""),
            tournamentName: json["tournament_name"],
            categoryName: json["category_name"],
            sportId: json["sport_id"],
            marketName: json["market_name"],
            outcomeName: json["outcome_name"],
            oddValue: json["odd_value"],
            itemUtcDate: DateTime.tryParse(json["item_utc_date"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "home_team": homeTeam,
        "away_team": awayTeam,
        "item_date": itemDate?.toIso8601String(),
        "tournament_name": tournamentName,
        "category_name": categoryName,
        "sport_id": sportId,
        "market_name": marketName,
        "outcome_name": outcomeName,
        "odd_value": oddValue,
        "item_utc_date": itemUtcDate?.toIso8601String(),
    };

    @override
    String toString(){
        return "$itemName, $homeTeam, $awayTeam, $itemDate, $tournamentName, $categoryName, $sportId, $marketName, $outcomeName, $oddValue, $itemUtcDate, ";
    }
}

class Sport {
    Sport({
        required this.id,
        required this.icon,
    });

    final String? id;
    final String? icon;

    Sport copyWith({
        String? id,
        String? icon,
    }) {
        return Sport(
            id: id ?? this.id,
            icon: icon ?? this.icon,
        );
    }

    factory Sport.fromJson(Map<String, dynamic> json){ 
        return Sport(
            id: json["id"],
            icon: json["icon"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
    };

    @override
    String toString(){
        return "$id, $icon, ";
    }
}
