class TeamSquad {
  String? get;
  Parameters? parameters;
  List<dynamic>? errors;
  int? results;
  Paging? paging;
  List<Response>? response;

  TeamSquad(
      {this.get,
      this.parameters,
      this.errors,
      this.results,
      this.paging,
      this.response});

  TeamSquad.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = json['parameters'] != null
        ? Parameters.fromJson(json['parameters'])
        : null;
    if (json['errors'] != null) {
      errors = <Null>[];
      //	json['errors'].forEach((v) { errors!.add(new Null.fromJson(v)); });
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
      data['errors'] = errors!.map((v) => v.toJson()).toList();
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
  String? season;

  Parameters({this.team, this.season});

  Parameters.fromJson(Map<String, dynamic> json) {
    team = json['team'];
    season = json['season'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team'] = team;
    data['season'] = season;
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
  List<Statistics>? statistics;

  Response({this.player, this.statistics});

  Response.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    if (json['statistics'] != null) {
      statistics = <Statistics>[];
      json['statistics'].forEach((v) {
        statistics!.add(Statistics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (player != null) {
      data['player'] = player!.toJson();
    }
    if (statistics != null) {
      data['statistics'] = statistics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Player {
  int? id;
  String? name;
  String? firstname;
  String? lastname;
  int? age;
  Birth? birth;
  String? nationality;
  String? height;
  String? weight;
  bool? injured;
  String? photo;

  Player(
      {this.id,
      this.name,
      this.firstname,
      this.lastname,
      this.age,
      this.birth,
      this.nationality,
      this.height,
      this.weight,
      this.injured,
      this.photo});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    age = json['age'];
    birth = json['birth'] != null ? Birth.fromJson(json['birth']) : null;
    nationality = json['nationality'];
    height = json['height'];
    weight = json['weight'];
    injured = json['injured'];
    photo = json['photo'];
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
    data['injured'] = injured;
    data['photo'] = photo;
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

class Statistics {
  Team? team;
  League? league;
  Games? games;
  Substitutes? substitutes;
  Shots? shots;
  Goals? goals;
  Passes? passes;
  Tackles? tackles;
  Duels? duels;
  Dribbles? dribbles;
  Fouls? fouls;
  Cards? cards;
  Penalty? penalty;

  Statistics(
      {this.team,
      this.league,
      this.games,
      this.substitutes,
      this.shots,
      this.goals,
      this.passes,
      this.tackles,
      this.duels,
      this.dribbles,
      this.fouls,
      this.cards,
      this.penalty});

  Statistics.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    league = json['league'] != null ? League.fromJson(json['league']) : null;
    games = json['games'] != null ? Games.fromJson(json['games']) : null;
    substitutes = json['substitutes'] != null
        ? Substitutes.fromJson(json['substitutes'])
        : null;
    shots = json['shots'] != null ? Shots.fromJson(json['shots']) : null;
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
    passes = json['passes'] != null ? Passes.fromJson(json['passes']) : null;
    tackles =
        json['tackles'] != null ? Tackles.fromJson(json['tackles']) : null;
    duels = json['duels'] != null ? Duels.fromJson(json['duels']) : null;
    dribbles =
        json['dribbles'] != null ? Dribbles.fromJson(json['dribbles']) : null;
    fouls = json['fouls'] != null ? Fouls.fromJson(json['fouls']) : null;
    cards = json['cards'] != null ? Cards.fromJson(json['cards']) : null;
    penalty =
        json['penalty'] != null ? Penalty.fromJson(json['penalty']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (league != null) {
      data['league'] = league!.toJson();
    }
    if (games != null) {
      data['games'] = games!.toJson();
    }
    if (substitutes != null) {
      data['substitutes'] = substitutes!.toJson();
    }
    if (shots != null) {
      data['shots'] = shots!.toJson();
    }
    if (goals != null) {
      data['goals'] = goals!.toJson();
    }
    if (passes != null) {
      data['passes'] = passes!.toJson();
    }
    if (tackles != null) {
      data['tackles'] = tackles!.toJson();
    }
    if (duels != null) {
      data['duels'] = duels!.toJson();
    }
    if (dribbles != null) {
      data['dribbles'] = dribbles!.toJson();
    }
    if (fouls != null) {
      data['fouls'] = fouls!.toJson();
    }
    if (cards != null) {
      data['cards'] = cards!.toJson();
    }
    if (penalty != null) {
      data['penalty'] = penalty!.toJson();
    }
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

class League {
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  var season;

  League({this.id, this.name, this.country, this.logo, this.flag, this.season});

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    flag = json['flag'];
    season = json['season'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country'] = country;
    data['logo'] = logo;
    data['flag'] = flag;
    data['season'] = season;
    return data;
  }
}

class Games {
  int? appearences;
  int? lineups;
  int? minutes;
  Null? number;
  String? position;
  String? rating;
  bool? captain;

  Games(
      {this.appearences,
      this.lineups,
      this.minutes,
      this.number,
      this.position,
      this.rating,
      this.captain});

  Games.fromJson(Map<String, dynamic> json) {
    appearences = json['appearences'];
    lineups = json['lineups'];
    minutes = json['minutes'];
    number = json['number'];
    position = json['position'];
    rating = json['rating'];
    captain = json['captain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appearences'] = appearences;
    data['lineups'] = lineups;
    data['minutes'] = minutes;
    data['number'] = number;
    data['position'] = position;
    data['rating'] = rating;
    data['captain'] = captain;
    return data;
  }
}

class Substitutes {
  int? inn;
  int? out;
  int? bench;

  Substitutes({this.inn, this.out, this.bench});

  Substitutes.fromJson(Map<String, dynamic> json) {
    inn = json['in'];
    out = json['out'];
    bench = json['bench'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['in'] = inn;
    data['out'] = out;
    data['bench'] = bench;
    return data;
  }
}

class Shots {
  int? total;
  int? on;

  Shots({this.total, this.on});

  Shots.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    on = json['on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['on'] = on;
    return data;
  }
}

class Goals {
  int? total;
  int? conceded;
  int? assists;
  int? saves;

  Goals({this.total, this.conceded, this.assists, this.saves});

  Goals.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    conceded = json['conceded'];
    assists = json['assists'];
    saves = json['saves'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['conceded'] = conceded;
    data['assists'] = assists;
    data['saves'] = saves;
    return data;
  }
}

class Passes {
  int? total;
  int? key;
  int? accuracy;

  Passes({this.total, this.key, this.accuracy});

  Passes.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    key = json['key'];
    accuracy = json['accuracy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['key'] = key;
    data['accuracy'] = accuracy;
    return data;
  }
}

class Tackles {
  int? total;
  int? blocks;
  int? interceptions;

  Tackles({this.total, this.blocks, this.interceptions});

  Tackles.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    blocks = json['blocks'];
    interceptions = json['interceptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['blocks'] = blocks;
    data['interceptions'] = interceptions;
    return data;
  }
}

class Duels {
  int? total;
  int? won;

  Duels({this.total, this.won});

  Duels.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    won = json['won'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['won'] = won;
    return data;
  }
}

class Dribbles {
  int? attempts;
  int? success;
  Null? past;

  Dribbles({this.attempts, this.success, this.past});

  Dribbles.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    success = json['success'];
    past = json['past'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attempts'] = attempts;
    data['success'] = success;
    data['past'] = past;
    return data;
  }
}

class Fouls {
  int? drawn;
  int? committed;

  Fouls({this.drawn, this.committed});

  Fouls.fromJson(Map<String, dynamic> json) {
    drawn = json['drawn'];
    committed = json['committed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['drawn'] = drawn;
    data['committed'] = committed;
    return data;
  }
}

class Cards {
  int? yellow;
  int? yellowred;
  int? red;

  Cards({this.yellow, this.yellowred, this.red});

  Cards.fromJson(Map<String, dynamic> json) {
    yellow = json['yellow'];
    yellowred = json['yellowred'];
    red = json['red'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yellow'] = yellow;
    data['yellowred'] = yellowred;
    data['red'] = red;
    return data;
  }
}

class Penalty {
  var won;
  var commited;
  int? scored;
  int? missed;
  int? saved;

  Penalty({this.won, this.commited, this.scored, this.missed, this.saved});

  Penalty.fromJson(Map<String, dynamic> json) {
    won = json['won'];
    commited = json['commited'];
    scored = json['scored'];
    missed = json['missed'];
    saved = json['saved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['won'] = won;
    data['commited'] = commited;
    data['scored'] = scored;
    data['missed'] = missed;
    data['saved'] = saved;
    return data;
  }
}
