import 'dart:async';
import 'package:flutter_bloc/src/models/reqres_model.dart';

import 'api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<ItemModel> fetchAllMovies() => apiProvider.fetchMovieList();

  Future<ReqresModel> fetchReqresList() => apiProvider.fetchReqresList();
}
