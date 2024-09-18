import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_item.dart';

class MoviesHorizontalList extends StatelessWidget {
  final Result result;
  final List<Movie> favoriteMovies;
  final void Function(Movie movie) onFavoriteToggle;

  const MoviesHorizontalList({
    Key? key,
    required this.result,
    required this.favoriteMovies,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: result.movies.length,
        itemBuilder: (context, index) {
          final movie = result.movies[index];
          final isFavorite = favoriteMovies.contains(movie);

          return MovieHorizontalItem(
            movie: movie,
            isFavorite: isFavorite,
            onFavoriteToggle: onFavoriteToggle,
          );
        },
      ),
    );
  }
}
