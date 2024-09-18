class Person {
  final int id;
  final String name;
  final String profilePath;
  final List<KnownFor> knownFor;

  Person({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.knownFor,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    var knownForJson = json['known_for'] as List;
    List<KnownFor> knownForList =
        knownForJson.map((kf) => KnownFor.fromJson(kf)).toList();
    return Person(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] ?? '',
      knownFor: knownForList,
    );
  }
}

class KnownFor {
  final String title;
  final String posterPath;

  KnownFor({
    required this.title,
    required this.posterPath,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) {
    return KnownFor(
      title: json['title'] ?? json['name'],
      posterPath: json['poster_path'] ?? '',
    );
  }
}
