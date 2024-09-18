import 'package:flutter/material.dart';
import 'package:movie_app/models/result_people.dart'; // Certifique-se de importar o modelo correto

class PeopleHorizontalList extends StatelessWidget {
  final PeopleResult result; // Alterado para usar PeopleResult

  const PeopleHorizontalList({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            result.people.length, // Acessa a lista de pessoas do PeopleResult
        itemBuilder: (context, index) {
          final person = result.people[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${person.profilePath}', // Imagem de perfil
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  person.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
