class TeamsTransfer {
  String? get;
  Parameters? parameters;
  List<dynamic>? errors;
  int? results;
  Paging? paging;
  List<Response>? response;

  TeamsTransfer(
      {this.get,
      this.parameters,
      this.errors,
      this.results,
      this.paging,
      this.response});

  TeamsTransfer.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = json['parameters'] != null
        ? Parameters.fromJson(json['parameters'])
        : null;
    if (json['errors'] != null) {
      errors = <Null>[];
      //	json['errors'].forEach((v) { errors!.add(Null.fromJson(v)); });
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
  Player? player;
  String? update;
  List<Transfers>? transfers;

  Response({this.player, this.update, this.transfers});

  Response.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    update = json['update'];
    if (json['transfers'] != null) {
      transfers = <Transfers>[];
      json['transfers'].forEach((v) {
        transfers!.add(Transfers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (player != null) {
      data['player'] = player!.toJson();
    }
    data['update'] = update;
    if (transfers != null) {
      data['transfers'] = transfers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Player {
  int? id;
  String? name;

  Player({this.id, this.name});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Transfers {
  String? date;
  String? type;
  Teams? teams;

  Transfers({this.date, this.type, this.teams});

  Transfers.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    type = json['type'];
    teams = json['teams'] != null ? Teams.fromJson(json['teams']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['type'] = type;
    if (teams != null) {
      data['teams'] = teams!.toJson();
    }
    return data;
  }
}

class Teams {
  In? inn;
  In? out;

  Teams({this.inn, this.out});

  Teams.fromJson(Map<String, dynamic> json) {
    inn = json['in'] != null ? In.fromJson(json['in']) : null;
    out = json['out'] != null ? In.fromJson(json['out']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (inn != null) {
      data['in'] = inn!.toJson();
    }
    if (out != null) {
      data['out'] = out!.toJson();
    }
    return data;
  }
}

class In {
  int? id;
  String? name;
  String? logo;

  In({this.id, this.name, this.logo});

  In.fromJson(Map<String, dynamic> json) {
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
