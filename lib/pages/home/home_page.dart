import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_item.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';
import 'package:movie_app/pages/home/widgets/nowplaying_list.dart';
import 'package:movie_app/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices apiServices = ApiServices();

  late Future<Result> popular;
  late Future<Result> nowPlaying;
  late Future<Result> upcomingFuture;
  final List<Movie> _favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    popular = apiServices.getPopularMovies();
    nowPlaying = apiServices.getNowPlayingMovies();
    upcomingFuture = apiServices.getUpcomingMovies();
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
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Popular',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<Result>(
                future: popular,
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Upcoming',
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
              const SizedBox(
                height: 20,
              ),
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
                        isFavorite: true, // Sempre verdadeiro na lista de favoritos
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
