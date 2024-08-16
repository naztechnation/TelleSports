class BookiesDetails {
  BookiesDetailsData? data;

  BookiesDetails({this.data});

  BookiesDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new BookiesDetailsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BookiesDetailsData {
  String? bookingCode;
  String? destinationCode;
  BookingDetails? bookingDetails;
  BookingDetails? destinationDetails;
  FailedGames? failedGames;
  String? conversionStatus;
  String? conversionFailureReason;

  BookiesDetailsData(
      {this.bookingCode,
      this.destinationCode,
      this.bookingDetails,
      this.destinationDetails,
      this.failedGames,
      this.conversionStatus,
      this.conversionFailureReason});

  BookiesDetailsData.fromJson(Map<String, dynamic> json) {
    bookingCode = json['booking_code'];
    destinationCode = json['destination_code'];
    bookingDetails = json['booking_details'] != null
        ? new BookingDetails.fromJson(json['booking_details'])
        : null;
    destinationDetails = json['destination_details'] != null
        ? new BookingDetails.fromJson(json['destination_details'])
        : null;
    failedGames = json['failed_games'] != null
        ? new FailedGames.fromJson(json['failed_games'])
        : null;
    conversionStatus = json['conversion_status'];
    conversionFailureReason = json['conversion_failure_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_code'] = this.bookingCode;
    data['destination_code'] = this.destinationCode;
    if (this.bookingDetails != null) {
      data['booking_details'] = this.bookingDetails!.toJson();
    }
    if (this.destinationDetails != null) {
      data['destination_details'] = this.destinationDetails!.toJson();
    }
    if (this.failedGames != null) {
      data['failed_games'] = this.failedGames!.toJson();
    }
    data['conversion_status'] = this.conversionStatus;
    data['conversion_failure_reason'] = this.conversionFailureReason;
    return data;
  }
}

class BookingDetails {
  String? name;
  String? code;
  int? eventCount;
  List<EventDetails>? eventDetails;

  BookingDetails({this.name, this.code, this.eventCount, this.eventDetails});

  BookingDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    eventCount = json['event_count'];
    if (json['event_details'] != null) {
      eventDetails = <EventDetails>[];
      json['event_details'].forEach((v) {
        eventDetails!.add(new EventDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['event_count'] = this.eventCount;
    if (this.eventDetails != null) {
      data['event_details'] =
          this.eventDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventDetails {
  String? eventName;
  String? marketName;
  String? selection;
  String? handicap;

  EventDetails(
      {this.eventName, this.marketName, this.selection, this.handicap});

  EventDetails.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    marketName = json['market_name'];
    selection = json['selection'];
    handicap = json['handicap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_name'] = this.eventName;
    data['market_name'] = this.marketName;
    data['selection'] = this.selection;
    data['handicap'] = this.handicap;
    return data;
  }
}

class FailedGames {
  int? failedCount;
  String? gamesFailureMessage;
  List<EventDetails>? eventDetails;

  FailedGames({this.failedCount, this.gamesFailureMessage, this.eventDetails});

  FailedGames.fromJson(Map<String, dynamic> json) {
    failedCount = json['failed_count'];
    gamesFailureMessage = json['games_failure_message'];
    if (json['event_details'] != null) {
      eventDetails = <EventDetails>[];
      json['event_details'].forEach((v) {
        eventDetails!.add(new EventDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['failed_count'] = this.failedCount;
    data['games_failure_message'] = this.gamesFailureMessage;
    if (this.eventDetails != null) {
      data['event_details'] =
          this.eventDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
