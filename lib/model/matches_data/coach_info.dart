class CoachInfo {
  String? get;
  Parameters? parameters;
  List<dynamic>? errors;
  int? results;
  Paging? paging;
  List<Response>? response;

  CoachInfo(
      {this.get,
      this.parameters,
      this.errors,
      this.results,
      this.paging,
      this.response});

  CoachInfo.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = json['parameters'] != null
        ? Parameters.fromJson(json['parameters'])
        : null;
    if (json['errors'] != null) {
      errors = <Null>[];
      json['errors'].forEach((v) {
        //   errors!.add(Null.fromJson(v));
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
      // data['errors'] = errors!.map((v) => v.toJson()).toList();
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
  String? team;

  Parameters({this.team});

  Parameters.fromJson(Map<String, dynamic> json) {
    team = json['team'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team'] = team;
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
  int? id;
  String? name;
  String? firstname;
  String? lastname;
  int? age;
  Birth? birth;
  String? nationality;
  var height;
  var weight;
  Team? team;
  List<Career>? career;

  Response(
      {this.id,
      this.name,
      this.firstname,
      this.lastname,
      this.age,
      this.birth,
      this.nationality,
      this.height,
      this.weight,
      this.team,
      this.career});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    age = json['age'];
    birth = json['birth'] != null ? Birth.fromJson(json['birth']) : null;
    nationality = json['nationality'];
    height = json['height'];
    weight = json['weight'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    if (json['career'] != null) {
      career = <Career>[];
      json['career'].forEach((v) {
        career!.add(Career.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['age'] = age;
    if (birth != null) {
      data['birth'] = birth!.toJson();
    }
    data['nationality'] = nationality;
    data['height'] = height;
    data['weight'] = weight;
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (career != null) {
      data['career'] = career!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Birth {
  String? date;
  String? place;
  String? country;

  Birth({this.date, this.place, this.country});

  Birth.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    place = json['place'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['place'] = place;
    data['country'] = country;
    return data;
  }
}

class Team {
  int? id;
  String? name;
  String? logo;

  Team({this.id, this.name, this.logo});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }
}

class Career {
  Team? team;
  String? start;
  String? end;

  Career({this.team, this.start, this.end});

  Career.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}
