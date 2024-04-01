class FixtureStats {
  FixtureStats({
    this.get,
    this.parameters,
    this.errors,
    this.results,
    this.paging,
    this.response,
  });
  String? get;
  Parameters? parameters;
  List<dynamic>? errors;
  int? results;
  Paging? paging;
  List<Response>? response;

  FixtureStats.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = Parameters.fromJson(json['parameters']);
    errors = List.castFrom<dynamic, dynamic>(json['errors']);
    results = json['results'];
    paging = Paging.fromJson(json['paging']);
    response =
        List.from(json['response']).map((e) => Response.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['get'] = get;
    _data['parameters'] = parameters?.toJson();
    _data['errors'] = errors;
    _data['results'] = results;
    _data['paging'] = paging?.toJson();
    _data['response'] = response?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Parameters {
  Parameters({
    this.id,
  });
  String? id;

  Parameters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    return _data;
  }
}

class Paging {
  Paging({
    this.current,
    this.total,
  });
  int? current;
  int? total;

  Paging.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current'] = current;
    _data['total'] = total;
    return _data;
  }
}

class Response {
  Response({
    this.fixture,
    this.league,
    this.teams,
    this.goals,
    this.score,
    this.events,
    this.lineups,
    this.statistics,
    this.players,
  });
  Fixture? fixture;
  League? league;
  Teams? teams;
  Goals? goals;
  Score? score;
  List<Events>? events;
  List<Lineups>? lineups;
  List<Statistics>? statistics;
  List<Players>? players;

  Response.fromJson(Map<String, dynamic> json) {
    fixture = Fixture.fromJson(json['fixture']);
    league = League.fromJson(json['league']);
    teams = Teams.fromJson(json['teams']);
    goals = Goals.fromJson(json['goals']);
    score = Score.fromJson(json['score']);
    events = List.from(json['events']).map((e) => Events.fromJson(e)).toList();
    lineups =
        List.from(json['lineups']).map((e) => Lineups.fromJson(e)).toList();
    statistics = List.from(json['statistics'])
        .map((e) => Statistics.fromJson(e))
        .toList();
    players =
        List.from(json['players']).map((e) => Players.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fixture'] = fixture?.toJson();
    _data['league'] = league?.toJson();
    _data['teams'] = teams?.toJson();
    _data['goals'] = goals?.toJson();
    _data['score'] = score?.toJson();
    _data['events'] = events?.map((e) => e.toJson()).toList();
    _data['lineups'] = lineups?.map((e) => e.toJson()).toList();
    _data['statistics'] = statistics?.map((e) => e.toJson()).toList();
    _data['players'] = players?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Fixture {
  Fixture({
    this.id,
    this.referee,
    this.timezone,
    this.date,
    this.timestamp,
    this.periods,
    this.venue,
    this.status,
  });
  int? id;
  String? referee;
  String? timezone;
  String? date;
  int? timestamp;
  Periods? periods;
  Venue? venue;
  Status? status;

  Fixture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referee = json['referee'];
    timezone = json['timezone'];
    date = json['date'];
    timestamp = json['timestamp'];
    periods = Periods.fromJson(json['periods']);
    venue = Venue.fromJson(json['venue']);
    status = Status.fromJson(json['status']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['referee'] = referee;
    _data['timezone'] = timezone;
    _data['date'] = date;
    _data['timestamp'] = timestamp;
    _data['periods'] = periods?.toJson();
    _data['venue'] = venue?.toJson();
    _data['status'] = status?.toJson();
    return _data;
  }
}

class Periods {
  Periods({
    this.first,
    this.second,
  });
  int? first;
  int? second;

  Periods.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    second = json['second'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first'] = first;
    _data['second'] = second;
    return _data;
  }
}

class Venue {
  Venue({
    this.id,
    this.name,
    this.city,
  });
  int? id;
  String? name;
  String? city;

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['city'] = city;
    return _data;
  }
}

class Status {
  Status({
    this.long,
    this.short,
    this.elapsed,
  });
  String? long;
  String? short;
  int? elapsed;

  Status.fromJson(Map<String, dynamic> json) {
    long = json['long'];
    short = json['short'];
    elapsed = json['elapsed'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['long'] = long;
    _data['short'] = short;
    _data['elapsed'] = elapsed;
    return _data;
  }
}

class League {
  League({
    this.id,
    this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
    this.round,
  });
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  int? season;
  String? round;

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    flag = json['flag'];
    season = json['season'];
    round = json['round'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['country'] = country;
    _data['logo'] = logo;
    _data['flag'] = flag;
    _data['season'] = season;
    _data['round'] = round;
    return _data;
  }
}

class Teams {
  Teams({
    this.home,
    this.away,
  });
  Home? home;
  Away? away;

  Teams.fromJson(Map<String, dynamic> json) {
    home = Home.fromJson(json['home']);
    away = Away.fromJson(json['away']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['home'] = home?.toJson();
    _data['away'] = away?.toJson();
    return _data;
  }
}

class Home {
  Home({
    this.id,
    this.name,
    this.logo,
    this.winner,
  });
  int? id;
  String? name;
  String? logo;
  bool? winner;

  Home.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    winner = json['winner'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['logo'] = logo;
    _data['winner'] = winner;
    return _data;
  }
}

class Away {
  Away({
    this.id,
    this.name,
    this.logo,
    this.winner,
  });
  int? id;
  String? name;
  String? logo;
  bool? winner;

  Away.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    winner = json['winner'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['logo'] = logo;
    _data['winner'] = winner;
    return _data;
  }
}

class Goals {
  Goals({
    this.home,
    this.away,
  });
  int? home;
  int? away;

  Goals.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['home'] = home;
    _data['away'] = away;
    return _data;
  }
}

class Score {
  Score({
    this.halftime,
    this.fulltime,
    this.extratime,
    this.penalty,
  });
  Halftime? halftime;
  Fulltime? fulltime;
  Extratime? extratime;
  Penalty? penalty;

  Score.fromJson(Map<String, dynamic> json) {
    halftime = Halftime.fromJson(json['halftime']);
    fulltime = Fulltime.fromJson(json['fulltime']);
    extratime = Extratime.fromJson(json['extratime']);
    penalty = Penalty.fromJson(json['penalty']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['halftime'] = halftime?.toJson();
    _data['fulltime'] = fulltime?.toJson();
    _data['extratime'] = extratime?.toJson();
    _data['penalty'] = penalty?.toJson();
    return _data;
  }
}

class Halftime {
  Halftime({
    this.home,
    this.away,
  });
  int? home;
  int? away;

  Halftime.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['home'] = home;
    _data['away'] = away;
    return _data;
  }
}

class Fulltime {
  Fulltime({
    this.home,
    this.away,
  });
  int? home;
  int? away;

  Fulltime.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['home'] = home;
    _data['away'] = away;
    return _data;
  }
}

class Extratime {
  Extratime({
    this.home,
    this.away,
  });
  var home;
  var away;

  Extratime.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['home'] = home;
    _data['away'] = away;
    return _data;
  }
}

class Penalty {
  Penalty({
    this.home,
    this.away,
  });
  var home;
  var away;

  Penalty.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['home'] = home;
    _data['away'] = away;
    return _data;
  }
}

class Events {
  Events({
    this.time,
    this.team,
    this.player,
    this.assist,
    this.type,
    this.detail,
    this.comments,
  });
  Time? time;
  Team? team;
  Player? player;
  Assist? assist;
  String? type;
  String? detail;
  var comments;

  Events.fromJson(Map<String, dynamic> json) {
    time = Time.fromJson(json['time']);
    team = Team.fromJson(json['team']);
    player = Player.fromJson(json['player']);
    assist = Assist.fromJson(json['assist']);
    type = json['type'];
    detail = json['detail'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time?.toJson();
    _data['team'] = team?.toJson();
    _data['player'] = player?.toJson();
    _data['assist'] = assist?.toJson();
    _data['type'] = type;
    _data['detail'] = detail;
    _data['comments'] = comments;
    return _data;
  }
}

class Time {
  Time({
    this.elapsed,
    this.extra,
  });
  int? elapsed;
  var extra;

  Time.fromJson(Map<String, dynamic> json) {
    elapsed = json['elapsed'];
    extra = json['extra'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['elapsed'] = elapsed;
    _data['extra'] = extra;
    return _data;
  }
}

class Team {
  Team({
    this.id,
    this.name,
    this.logo,
  });
  int? id;
  String? name;
  String? logo;

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['logo'] = logo;
    return _data;
  }
}

class Player {
  Player({
    this.id,
    this.name,
  });
  int? id;
  int? number;
  String? name;
  String? pos;

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    pos = json['pos'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['pos'] = pos;
    _data['number'] = number;
    return _data;
  }
}

class Assist {
  Assist({
    this.id,
    this.name,
  });
  int? id;
  String? name;

  Assist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class Lineups {
  Lineups({
    this.team,
    this.coach,
    this.formation,
    this.startXI,
    this.substitutes,
  });
  Team? team;
  Coach? coach;
  String? formation;
  List<StartXI>? startXI;
  List<Substitutes>? substitutes;

  Lineups.fromJson(Map<String, dynamic> json) {
    team = Team.fromJson(json['team']);
    coach = Coach.fromJson(json['coach']);
    formation = json['formation'];
    startXI =
        List.from(json['startXI']).map((e) => StartXI.fromJson(e)).toList();
    substitutes = List.from(json['substitutes'])
        .map((e) => Substitutes.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['team'] = team?.toJson();
    _data['coach'] = coach?.toJson();
    _data['formation'] = formation;
    _data['startXI'] = startXI?.map((e) => e.toJson()).toList();
    _data['substitutes'] = substitutes?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Coach {
  Coach({
    this.id,
    this.name,
  });
  int? id;
  String? name;

  Coach.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class StartXI {
  StartXI({
    this.player,
  });
  Player? player;

  StartXI.fromJson(Map<String, dynamic> json) {
    player = Player.fromJson(json['player']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['player'] = player?.toJson();
    return _data;
  }
}

class Substitutes {
  Substitutes({
    this.player,
  });
  Player? player;

  Substitutes.fromJson(Map<String, dynamic> json) {
    player = Player.fromJson(json['player']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['player'] = player?.toJson();
    return _data;
  }
}

class Statistics {
  Statistics({
    this.team,
    this.statistics,
  });
  Team? team;
  List<Stats>? statistics;

  Statistics.fromJson(Map<String, dynamic> json) {
    team = Team.fromJson(json['team']);
    statistics =
        List.from(json['statistics']).map((e) => Stats.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['team'] = team?.toJson();
    _data['statistics'] = statistics?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Stats {
  Stats({
    this.type,
    this.value,
  });
  String? type;
  var value;

  Stats.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    return _data;
  }
}

class Players {
  Players({
    this.team,
    this.players,
  });
  Team? team;
  List<Players>? players;

  Players.fromJson(Map<String, dynamic> json) {
    team = 
   json['team'] != null ? new Team.fromJson(json['team']) : null;
    
    players =
    json['players'] != null ? List.from(json['players']).map((e) => Players.fromJson(e)).toList() : null;
        
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['team'] = team?.toJson();
    _data['players'] = players?.map((e) => e.toJson()).toList();
    return _data;
  }
}
