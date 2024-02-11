import 'movie_youtubedb.dart';

class MovieVideoResponse {
    final int id;
    final List<MovieYoutubeDb> results;

    MovieVideoResponse({
        required this.id,
        required this.results,
    });

    factory MovieVideoResponse.fromJson(Map<String, dynamic> json) => MovieVideoResponse(
        id: json["id"],
        results: json["results"]!= null ? List<MovieYoutubeDb>.from(json["results"].map((x) => MovieYoutubeDb.fromJson(x))) : [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}


