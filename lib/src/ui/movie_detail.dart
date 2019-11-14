import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String poster_path;
  final String title;
  final String overview;

  DetailScreen(this.poster_path, this.title, this.overview);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Image.network(
              'https://image.tmdb.org/t/p/w185${poster_path}',
              fit: BoxFit.cover,
            ),
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(24),
          ),
          Container(
            child: Text(
              "Description",
              style: TextStyle(fontSize: 20),
            ),
            margin: EdgeInsets.only(left: 24),
            alignment: Alignment.topLeft,
          ),
          Container(
            child: Text(
              overview,
              style: TextStyle(fontSize: 18),
            ),
            margin: EdgeInsets.only(left: 24, top: 10),
            alignment: Alignment.topLeft,
          )
        ],
      ),
    );
  }
}
