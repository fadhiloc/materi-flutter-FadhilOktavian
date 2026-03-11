import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  List favourites = [];

  void loadFavourites() async {

    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('favourite_movies');

    if (data != null) {
      setState(() {
        favourites = jsonDecode(data);
      });
    }

  }

  @override
  void initState() {
    super.initState();
    loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Favorite Movies"),
      ),

      body: favourites.isEmpty
          ? const Center(
              child: Text("No Favorite Movies"),
            )
          : ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {

                final movie = favourites[index];

                return ListTile(
                  leading: Image.network(
                    "https://image.tmdb.org/t/p/w500${movie["poster"]}",
                    width: 50,
                    fit: BoxFit.cover,
                  ),

                  title: Text(movie["title"]),

                );
              },
            ),
    );
  }
}