import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';
import '../models/reqres_model.dart';

class ApiProvider {
  Client client = Client();

  Future<ItemModel> fetchMovieList() async {
    final response = await client.get(
        "http://api.themoviedb.org/3/movie/popular?api_key=06e6e2610d947009e916f89dbf71ede4");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<ReqresModel> fetchReqresList() async {
    final response = await client.get("https://reqres.in/api/users?page=2");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ReqresModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
