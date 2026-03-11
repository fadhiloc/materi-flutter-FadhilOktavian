import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Detail"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Judul + tombol favorite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () async {

                      final prefs = await SharedPreferences.getInstance();

                      List favourites = [];

                      final data = prefs.getString('favourite_movies');

                      if (data != null) {
                        favourites = jsonDecode(data);
                      }

                      favourites.add({
                        "id": movie.id,
                        "title": movie.title,
                        "poster": movie.backdropPath
                      });

                      prefs.setString('favourite_movies', jsonEncode(favourites));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Movie added to favourite"),
                        ),
                      );
                    },
                  )
                ],
              ),

              const SizedBox(height: 10),

              // Poster movie
              Image.network(
                'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 20),

              const Text(
                'Overview:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(movie.overview),

              const SizedBox(height: 20),

              Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.blue),
                  const SizedBox(width: 10),

                  const Text(
                    'Release Date:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Text(movie.releaseDate),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 10),

                  const Text(
                    'Rating:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Text(movie.voteAverage.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}