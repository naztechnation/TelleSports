class TeamsStats {
  String? get;
  Parameters? parameters;
  List<dynamic>? errors;
  int? results;
  Paging? paging;
  Response? response;

  TeamsStats(
      {this.get,
      this.parameters,
      this.errors,
      this.results,
      this.paging,
      this.response});

  TeamsStats.fromJson(Map<String, dynamic> json) {
    get = json['get'];
    parameters = json['parameters'] != null
        ? Parameters.fromJson(json['parameters'])
        : null;
    if (json['errors'] != null) {
      errors = <Null>[];
      //json['errors'].forEach((v) { errors!.add(Null.fromJson(v)); });
    }
    results = json['results'];
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
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
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Parameters {
  String? league;
  String? team;
  String? season;

  Parameters({this.league, this.team, this.season});

  Parameters.fromJson(Map<String, dynamic> json) {
    league = json['league'];
    team = json['team'];
    season = json['season'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['league'] = league;
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
  League? league;
  Team? team;
  String? form;
  Fixtures? fixtures;
  Goals? goals;
  Biggest? biggest;
  Played? cleanSheet;
  Played? failedToScore;
  Penalty? penalty;
  List<Lineups>? lineups;
  Cards? cards;

  Response(
      {this.league,
      this.team,
      this.form,
      this.fixtures,
      this.goals,
      this.biggest,
      this.cleanSheet,
      this.failedToScore,
      this.penalty,
      this.lineups,
      this.cards});

  Response.fromJson(Map<String, dynamic> json) {
    league = json['league'] != null ? League.fromJson(json['league']) : null;
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    form = json['form'];
    fixtures =
        json['fixtures'] != null ? Fixtures.fromJson(json['fixtures']) : null;
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
    biggest =
        json['biggest'] != null ? Biggest.fromJson(json['biggest']) : null;
    cleanSheet = json['clean_sheet'] != null
        ? Played.fromJson(json['clean_sheet'])
        : null;
    failedToScore = json['failed_to_score'] != null
        ? Played.fromJson(json['failed_to_score'])
        : null;
    penalty =
        json['penalty'] != null ? Penalty.fromJson(json['penalty']) : null;
    if (json['lineups'] != null) {
      lineups = <Lineups>[];
      json['lineups'].forEach((v) {
        lineups!.add(Lineups.fromJson(v));
      });
    }
    cards = json['cards'] != null ? Cards.fromJson(json['cards']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (league != null) {
      data['league'] = league!.toJson();
    }
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['form'] = form;
    if (fixtures != null) {
      data['fixtures'] = fixtures!.toJson();
    }
    if (goals != null) {
      data['goals'] = goals!.toJson();
    }
    if (biggest != null) {
      data['biggest'] = biggest!.toJson();
    }
    if (cleanSheet != null) {
      data['clean_sheet'] = cleanSheet!.toJson();
    }
    if (failedToScore != null) {
      data['failed_to_score'] = failedToScore!.toJson();
    }
    if (penalty != null) {
      data['penalty'] = penalty!.toJson();
    }
    if (lineups != null) {
      data['lineups'] = lineups!.map((v) => v.toJson()).toList();
    }
    if (cards != null) {
      data['cards'] = cards!.toJson();
    }
    return data;
  }
}

class League {
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  int? season;

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

class Fixtures {
  Played? played;
  Played? wins;
  Played? draws;
  Wins? loses;

  Fixtures({this.played, this.wins, this.draws, this.loses});

  Fixtures.fromJson(Map<String, dynamic> json) {
    played = json['played'] != null ? Played.fromJson(json['played']) : null;
    wins = json['wins'] != null ? Played.fromJson(json['wins']) : null;
    draws = json['draws'] != null ? Played.fromJson(json['draws']) : null;
    loses = json['loses'] != null ? Wins.fromJson(json['loses']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (played != null) {
      data['played'] = played!.toJson();
    }
    if (wins != null) {
      data['wins'] = wins!.toJson();
    }
    if (draws != null) {
      data['draws'] = draws!.toJson();
    }
    if (loses != null) {
      data['loses'] = loses!.toJson();
    }
    return data;
  }
}

class Played {
  var home;
  var away;
  var total;

  Played({this.home, this.away, this.total});

  Played.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['home'] = home;
    data['away'] = away;
    data['total'] = total;
    return data;
  }
}

class Goals {
  For? forr;
  For? against;

  Goals({this.forr, this.against});

  Goals.fromJson(Map<String, dynamic> json) {
    forr = json['for'] != null ? For.fromJson(json['for']) : null;
    against = json['against'] != null ? For.fromJson(json['against']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forr != null) {
      data['for'] = forr!.toJson();
    }
    if (against != null) {
      data['against'] = against!.toJson();
    }
    return data;
  }
}

class For {
  Played? total;
  Average? average;
  Minute? minute;

  For({this.total, this.average, this.minute});

  For.fromJson(Map<String, dynamic> json) {
    total = json['total'] != null ? Played.fromJson(json['total']) : null;
    average =
        json['average'] != null ? Average.fromJson(json['average']) : null;
    minute = json['minute'] != null ? Minute.fromJson(json['minute']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (total != null) {
      data['total'] = total!.toJson();
    }
    if (average != null) {
      data['average'] = average!.toJson();
    }
    if (minute != null) {
      data['minute'] = minute!.toJson();
    }
    return data;
  }
}

class Average {
  String? home;
  String? away;
  String? total;

  Average({this.home, this.away, this.total});

  Average.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['home'] = home;
    data['away'] = away;
    data['total'] = total;
    return data;
  }
}

class Minute {
  ZeroToFifteen? one;
  ZeroToFifteen? two;
  ZeroToFifteen? three;
  ZeroToFifteen? four;
  ZeroToFifteen? five;
  ZeroToFifteen? six;
  ZeroToFifteen? seven;
  ZeroToFifteen? eight;

  Minute(
      {this.one,
      this.two,
      this.three,
      this.four,
      this.five,
      this.six,
      this.seven,
      this.eight});

  Minute.fromJson(Map<String, dynamic> json) {
    one = json['0-15'] != null ? ZeroToFifteen.fromJson(json['0-15']) : null;
    two = json['16-30'] != null ? ZeroToFifteen.fromJson(json['16-30']) : null;
    three =
        json['31-45'] != null ? ZeroToFifteen.fromJson(json['31-45']) : null;
    four = json['46-60'] != null ? ZeroToFifteen.fromJson(json['46-60']) : null;
    five = json['61-75'] != null ? ZeroToFifteen.fromJson(json['61-75']) : null;
    six = json['76-90'] != null ? ZeroToFifteen.fromJson(json['76-90']) : null;
    seven =
        json['91-105'] != null ? ZeroToFifteen.fromJson(json['91-105']) : null;
    eight = json['106-120'] != null
        ? ZeroToFifteen.fromJson(json['106-120'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (one != null) {
      data['0-15'] = one!.toJson();
    }
    if (two != null) {
      data['16-30'] = two!.toJson();
    }
    if (three != null) {
      data['31-45'] = three!.toJson();
    }
    if (four != null) {
      data['46-60'] = four!.toJson();
    }
    if (five != null) {
      data['61-75'] = five!.toJson();
    }
    if (six != null) {
      data['76-90'] = six!.toJson();
    }
    if (seven != null) {
      data['91-105'] = seven!.toJson();
    }
    if (eight != null) {
      data['106-120'] = eight!.toJson();
    }
    return data;
  }
}

class ZeroToFifteen {
  int? total;
  String? percentage;

  ZeroToFifteen({this.total, this.percentage});

  ZeroToFifteen.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['percentage'] = percentage;
    return data;
  }
}

class Biggest {
  Streak? streak;
  Played? wins;
  Wins? loses;
  Goals? goals;

  Biggest({this.streak, this.wins, this.loses, this.goals});

  Biggest.fromJson(Map<String, dynamic> json) {
    streak = json['streak'] != null ? Streak.fromJson(json['streak']) : null;
    wins = json['wins'] != null ? Played.fromJson(json['wins']) : null;
    loses = json['loses'] != null ? Wins.fromJson(json['loses']) : null;
    goals = json['goals'] != null ? Goals.fromJson(json['goals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (streak != null) {
      data['streak'] = streak!.toJson();
    }
    if (wins != null) {
      data['wins'] = wins!.toJson();
    }
    if (loses != null) {
      data['loses'] = loses!.toJson();
    }
    if (goals != null) {
      data['goals'] = goals!.toJson();
    }
    return data;
  }
}

class Streak {
  int? wins;
  int? draws;
  int? loses;

  Streak({this.wins, this.draws, this.loses});

  Streak.fromJson(Map<String, dynamic> json) {
    wins = json['wins'];
    draws = json['draws'];
    loses = json['loses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wins'] = wins;
    data['draws'] = draws;
    data['loses'] = loses;
    return data;
  }
}

class Wins {
  var home;
  var away;
  var total;

  Wins({this.home, this.away, this.total});

  Wins.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['home'] = home;
    data['away'] = away;
    data['total'] = total;

    return data;
  }
}

class Forr {
  int? home;
  int? away;

  Forr({this.home, this.away});

  Forr.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['home'] = home;
    data['away'] = away;
    return data;
  }
}

class Penalty {
  ZeroToFifteen? scored;
  ZeroToFifteen? missed;
  int? total;

  Penalty({this.scored, this.missed, this.total});

  Penalty.fromJson(Map<String, dynamic> json) {
    scored =
        json['scored'] != null ? ZeroToFifteen.fromJson(json['scored']) : null;
    missed =
        json['missed'] != null ? ZeroToFifteen.fromJson(json['missed']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (scored != null) {
      data['scored'] = scored!.toJson();
    }
    if (missed != null) {
      data['missed'] = missed!.toJson();
    }
    data['total'] = total;
    return data;
  }
}

class Lineups {
  String? formation;
  int? played;

  Lineups({this.formation, this.played});

  Lineups.fromJson(Map<String, dynamic> json) {
    formation = json['formation'];
    played = json['played'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formation'] = formation;
    data['played'] = played;
    return data;
  }
}

class Cards {
  Minute? yellow;
  Minute? red;

  Cards({this.yellow, this.red});

  Cards.fromJson(Map<String, dynamic> json) {
    yellow = json['yellow'] != null ? Minute.fromJson(json['yellow']) : null;
    red = json['red'] != null ? Minute.fromJson(json['red']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (yellow != null) {
      data['yellow'] = yellow!.toJson();
    }
    if (red != null) {
      data['red'] = red!.toJson();
    }
    return data;
  }
}
