import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/movie_youtube.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_youtubedb.dart';

const String urlBaseImagen = "https://image.tmdb.org/t/p/w500";

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDB movieMovieDB) => Movie(
        adult: movieMovieDB.adult,
        backdropPath: (movieMovieDB.backdropPath) != ''
            ? (urlBaseImagen + movieMovieDB.backdropPath)
            : 'https://eticketsolutions.com/demo/themes/e-ticket/img/movie.jpg',
        genreIds: movieMovieDB.genreIds.map((e) => e.toString()).toList(),
        id: movieMovieDB.id,
        originalLanguage: movieMovieDB.originalLanguage,
        originalTitle: movieMovieDB.originalTitle,
        overview: movieMovieDB.overview,
        popularity: movieMovieDB.popularity,
        posterPath: (movieMovieDB.posterPath != '')
            ? (urlBaseImagen + movieMovieDB.posterPath)
            : 'no-poster',
        releaseDate: movieMovieDB.releaseDate,
        title: movieMovieDB.title,
        video: movieMovieDB.video,
        voteAverage: movieMovieDB.voteAverage,
        voteCount: movieMovieDB.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movieMovieDB) => Movie(
        adult: movieMovieDB.adult,
        backdropPath: (movieMovieDB.backdropPath) != ''
            ? (urlBaseImagen + movieMovieDB.backdropPath)
            : 'https://eticketsolutions.com/demo/themes/e-ticket/img/movie.jpg',
        genreIds: movieMovieDB.genres.map((e) => e.name).toList(),
        id: movieMovieDB.id,
        originalLanguage: movieMovieDB.originalLanguage,
        originalTitle: movieMovieDB.originalTitle,
        overview: movieMovieDB.overview,
        popularity: movieMovieDB.popularity,
        posterPath: (movieMovieDB.posterPath != '')
            ? (urlBaseImagen + movieMovieDB.posterPath)
            : 'no-poster',
        releaseDate: movieMovieDB.releaseDate,
        title: movieMovieDB.title,
        video: movieMovieDB.video,
        voteAverage: movieMovieDB.voteAverage,
        voteCount: movieMovieDB.voteCount,
      );

  static MovieYoutube movieYoutubeDbToEntity(MovieYoutubeDb movieYoutubeDb) =>
      MovieYoutube(
        key: movieYoutubeDb.key,
        site: movieYoutubeDb.site,
        publishedAt: movieYoutubeDb.publishedAt,
      );
}
