class Person {
  final int id;
  final String name;
  final String profilePath;

  Person({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] ?? '', // Caminho da foto do perfil
    );
  }
}

class PeopleResult {
  final int page;
  final List<Person> people;

  PeopleResult({required this.page, required this.people});

  factory PeopleResult.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Person> peopleList = list.map((i) => Person.fromJson(i)).toList();

    return PeopleResult(
      page: json['page'],
      people: peopleList,
    );
  }
}
