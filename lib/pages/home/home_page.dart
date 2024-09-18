import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/result_people.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_item.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';
import 'package:movie_app/pages/home/widgets/nowplaying_list.dart';
import 'package:movie_app/pages/home/widgets/people_horizontal_list.dart'; // Novo import
import 'package:movie_app/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices apiServices = ApiServices();

  late Future<PeopleResult> popularPeople; 
  late Future<Result> popularMovies;
  late Future<Result> nowPlaying;
  late Future<Result> upcomingFuture; // Future para pessoas populares

  final List<Movie> _favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    popularMovies = apiServices.getPopularMovies();
    nowPlaying = apiServices.getNowPlayingMovies();
    upcomingFuture = apiServices.getUpcomingMovies();
    popularPeople = apiServices
        .getPopularPeople(); // Inicializa o Future das pessoas populares
  }

  void _toggleFavorite(Movie movie) {
    setState(() {
      if (_favoriteMovies.contains(movie)) {
        _favoriteMovies.remove(movie);
      } else {
        _favoriteMovies.add(movie);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seção Now Playing
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Now Playing',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<Result>(
                future: nowPlaying,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return NowPlayingList(
                      result: snapshot.data!,
                      onFavoriteToggle: _toggleFavorite,
                      favoriteMovies: _favoriteMovies,
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 20),

              // Seção Popular Movies
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Popular Movies',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<Result>(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MoviesHorizontalList(
                      result: snapshot.data!,
                      favoriteMovies: _favoriteMovies,
                      onFavoriteToggle: _toggleFavorite,
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 20),

              // Seção Popular People (Nova Seção)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Popular People',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<PeopleResult>(
                future: popularPeople, // Future para pessoas populares
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return PeopleHorizontalList(
                      result: snapshot
                          .data!, // Usa o novo widget para listar pessoas
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Failed to load popular people.',
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }
                  return Center(
                      child:
                          CircularProgressIndicator()); // Mostra um loader enquanto carrega
                },
              ),

              const SizedBox(height: 20),

              // Seção Upcoming Movies
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Upcoming Movies',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<Result>(
                future: upcomingFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MoviesHorizontalList(
                      result: snapshot.data!,
                      favoriteMovies: _favoriteMovies,
                      onFavoriteToggle: _toggleFavorite,
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 20),

              // Seção Favorites
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Favorites',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              if (_favoriteMovies.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _favoriteMovies.length,
                    itemBuilder: (context, index) {
                      final movie = _favoriteMovies[index];
                      return MovieHorizontalItem(
                        movie: movie,
                        isFavorite:
                            true, // Sempre verdadeiro na lista de favoritos
                        onFavoriteToggle: _toggleFavorite,
                      );
                    },
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'No favorites yet.',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
