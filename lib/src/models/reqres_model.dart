class ReqresModel {
  int _page;
  int _per_page;
  int _total;
  int _total_pages;
  List<_Data> _data = [];

  ReqresModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _per_page = parsedJson['per_page'];
    _total = parsedJson['total'];
    _total_pages = parsedJson['total_pages'];
    List<_Data> temp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      _Data datas = _Data(parsedJson['data'][i]);
      temp.add(datas);
    }
    _data = temp;
  }

  List<_Data> get data => _data;

  int get page => _page;

  int get per_page => _per_page;

  int get total => _total;

  int get total_pages => _total_pages;
}

class _Data {
  int _id;
  String _email;
  String _first_name;
  String _last_name;
  String _avatar;

  _Data(result) {
    _id = result['id'];
    _email = result['email'];
    _first_name = result['first_name'];
    _last_name = result['last_name'];
    _avatar = result['avatar'];
  }

  int get id => _id;

  String get email => _email;

  String get first_name => _first_name;

  String get last_name => _last_name;

  String get avatar => _avatar;
}
