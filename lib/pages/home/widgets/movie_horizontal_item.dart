import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieHorizontalItem extends StatefulWidget {
  const MovieHorizontalItem({
    super.key,
    required this.movie,
    required this.onFavoriteToggle,
    this.isFavorite = false,
  });

  final Movie movie;
  final void Function(Movie movie) onFavoriteToggle;
  final bool isFavorite;

  @override
  _MovieHorizontalItemState createState() => _MovieHorizontalItemState();
}

class _MovieHorizontalItemState extends State<MovieHorizontalItem> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 140,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('$imageUrl${widget.movie.posterPath}'),
            ),
          ),
        ),
        Positioned(
          left: 15,
          right: 15,
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.movie.title,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.movie.releaseDate?.year.toString() ?? '',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.voteAverage.toInt().toString(),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
              size: 24,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              widget.onFavoriteToggle(widget.movie);
            },
          ),
        ),
      ],
    );
  }
}
