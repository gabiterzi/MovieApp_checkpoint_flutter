import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/result_people.dart';
import 'package:movie_app/models/result_videos.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {
  // Obtém filmes mais bem avaliados
  Future<Result> getTopRatedMovies() async {
    var endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load top-rated movies');
  }

  // Obtém filmes em exibição atualmente
  Future<Result> getNowPlayingMovies() async {
    var endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  // Obtém filmes que estão por vir
  Future<Result> getUpcomingMovies() async {
    var endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }

  // Obtém detalhes de um filme específico pelo ID
  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    final endPoint = 'movie/$movieId';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load movie details');
  }

  // Obtém recomendações de filmes com base no ID do filme
  Future<Result> getMovieRecommendations(int movieId) async {
    final endPoint = 'movie/$movieId/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load movie recommendations');
  }

  // Pesquisa filmes pelo nome
  Future<Result> getSearchedMovie(String searchText) async {
    final endPoint = 'search/movie?query=$searchText';
    final url = '$baseUrl$endPoint';

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc'
    });

    if (response.statusCode == 200) {
      final movies = Result.fromJson(jsonDecode(response.body));
      return movies;
    }
    throw Exception('failed to load search results');
  }

  // Obtém filmes populares
  Future<Result> getPopularMovies() async {
    const endPoint = 'movie/popular';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load popular movies');
  }

  // Obtém vídeos de um filme específico
  Future<ResultVideos> getMovieVideos(int movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=YOUR_API_KEY'));

    if (response.statusCode == 200) {
      return ResultVideos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load videos');
    }
  }

  // Novo método: Obtém pessoas populares
  Future<PeopleResult> getPopularPeople() async {
    const endPoint = 'person/popular';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return PeopleResult.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load popular people');
  }
}
