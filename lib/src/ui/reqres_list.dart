import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/blocs/reqres_bloc.dart';
import 'package:flutter_bloc/src/models/reqres_model.dart';

class ReqresList extends StatefulWidget {
  @override
  ReqresListState createState() => ReqresListState();
}

class ReqresListState extends State<ReqresList> {
  @override
  void initState() {
    reqresBloc.fetchReqresList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reqres List'),
        ),
        body: StreamBuilder(
            stream: reqresBloc.allReqres,
            builder: (context, AsyncSnapshot<ReqresModel> snapshot) {
              if (snapshot.hasData) {
                return buildView(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

Widget buildView(AsyncSnapshot<ReqresModel> snapshot) {
  print(snapshot.data.toString());
  return (ListView.builder(
      itemCount: snapshot.data.data.length,
      itemBuilder: (BuildContext context, int index) {
        final item = snapshot.data.data[index];
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      item.avatar,
                      height: 150,
                    ),
                    // alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 10, left: 24),
                  ),
                  Container(
                    child: Text(
                      '${item.first_name} ${item.last_name}',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }));
}
