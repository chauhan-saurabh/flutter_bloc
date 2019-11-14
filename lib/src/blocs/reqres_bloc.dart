import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/reqres_model.dart';

class ReqresBloc {
  final _repository = Repository();
  final _reqresFetcher = PublishSubject<ReqresModel>();

  Observable<ReqresModel> get allReqres => _reqresFetcher.stream;

  fetchReqresList() async {
    ReqresModel reqresModel = await _repository.fetchReqresList();
    _reqresFetcher.sink.add(reqresModel);
  }

  dispose() {
    _reqresFetcher.close();
  }
}

final reqresBloc = ReqresBloc();
