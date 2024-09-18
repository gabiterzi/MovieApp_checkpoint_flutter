class ResultVideos {
  final List<Video> results;

  ResultVideos({required this.results});

  factory ResultVideos.fromJson(Map<String, dynamic> json) {
    return ResultVideos(
      results: List<Video>.from(json["results"].map((x) => Video.fromJson(x))),
    );
  }
}

class Video {
  final String key;
  final String name;

  Video({required this.key, required this.name});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      key: json["key"],
      name: json["name"],
    );
  }
}
