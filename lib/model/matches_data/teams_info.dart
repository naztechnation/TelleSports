class TeamsInfo {
  String? get;
  Parameters? parameters;
  List<dynamic>? errors;
  int? results;
  Paging? paging;
  List<Response>? response;

  TeamsInfo(
      {this.get,
      this.parameters,
      this.errors,
      this.results,
      this.paging,
      this.response});

  TeamsInfo.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = json['parameters'] != null
        ? Parameters.fromJson(json['parameters'])
        : null;
    if (json['errors'] != null) {
      errors = <Null>[];
      json['errors'].forEach((v) {
        // errors!.add(Null.fromJson(v));
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
      // data['errors'] = this.errors!.map((v) => v.toJson()).toList();
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
  String? id;

  Parameters({this.id});

  Parameters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
  Team? team;
  Venue? venue;

  Response({this.team, this.venue});

  Response.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    return data;
  }
}

class Team {
  int? id;
  String? name;
  String? code;
  String? country;
  int? founded;
  bool? national;
  String? logo;

  Team(
      {this.id,
      this.name,
      this.code,
      this.country,
      this.founded,
      this.national,
      this.logo});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    country = json['country'];
    founded = json['founded'];
    national = json['national'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['country'] = country;
    data['founded'] = founded;
    data['national'] = national;
    data['logo'] = logo;
    return data;
  }
}

class Venue {
  int? id;
  String? name;
  String? address;
  String? city;
  int? capacity;
  String? surface;
  String? image;

  Venue(
      {this.id,
      this.name,
      this.address,
      this.city,
      this.capacity,
      this.surface,
      this.image});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    capacity = json['capacity'];
    surface = json['surface'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['capacity'] = capacity;
    data['surface'] = surface;
    data['image'] = image;
    return data;
  }
}
