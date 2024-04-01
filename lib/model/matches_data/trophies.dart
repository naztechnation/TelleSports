class Trophies {
  String? get;
  Parameters? parameters;
  List<dynamic>? errors;
  int? results;
  Paging? paging;
  List<Response>? response;

  Trophies(
      {this.get,
      this.parameters,
      this.errors,
      this.results,
      this.paging,
      this.response});

  Trophies.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = json['parameters'] != null
        ? Parameters.fromJson(json['parameters'])
        : null;
    if (json['errors'] != null) {
      errors = <Null>[];
      json['errors'].forEach((v) {
        //errors!.add(Null.fromJson(v));
      });
    }
    results = json['results'];
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['get'] = get;
    if (parameters != null) {
      data['parameters'] = parameters!.toJson();
    }
    if (errors != null) {
      //data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['results'] = results;
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parameters {
  String? coach;

  Parameters({this.coach});

  Parameters.fromJson(Map<String, dynamic> json) {
    coach = json['coach'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coach'] = coach;
    return data;
  }
}

class Paging {
  int? current;
  int? total;

  Paging({this.current, this.total});

  Paging.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current;
    data['total'] = total;
    return data;
  }
}

class Response {
  String? league;
  String? country;
  String? season;
  String? place;

  Response({this.league, this.country, this.season, this.place});

  Response.fromJson(Map<String, dynamic> json) {
    league = json['league'];
    country = json['country'];
    season = json['season'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['league'] = league;
    data['country'] = country;
    data['season'] = season;
    data['place'] = place;
    return data;
  }
}
