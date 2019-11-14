import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/ui/plugin_test.dart';
import 'package:flutter_bloc/src/ui/reqres_list.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';
import './movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieList> {
  @override
  initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  goToDetail(context, data) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DetailScreen(data.poster_path, data.title, data.overview)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Popular Movies'),
        ),
        body: StreamBuilder(
          stream: bloc.allMovies,
          builder: (context, AsyncSnapshot<ItemModel> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        drawer: drawer(context));
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: GestureDetector(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    goToDetail(context, snapshot.data.results[index]);
                  }));
        });
  }

  drawer(context) {
    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 240,
          color: Colors.deepOrangeAccent,
        ),
        Container(
          child: GestureDetector(
            child: Text(
              "TEST REGRES",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReqresList()),
              );
            },
          ),
          height: 40,
          margin: EdgeInsets.all(24),
        ),
        Container(
          child: GestureDetector(
            child: Text(
              "TEST PLUGINS",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PluginTest()),
              );
            },
          ),
          height: 40,
          margin: EdgeInsets.all(24),
        )
      ],
    ) // Populate the Drawer in the next step.
        );
  }
}
