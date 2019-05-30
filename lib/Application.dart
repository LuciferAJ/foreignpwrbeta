import 'package:flutter/material.dart';

class Application extends StatefulWidget {
  List formList;
  Application(this.formList);
  @override
  _ApplicationState createState() => _ApplicationState(formList);
}

class _ApplicationState extends State<Application> {
  List formList;
  _ApplicationState(this.formList);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Name : "),
//              Text(formList),
            ],
          )
        ],
      ),
    );
  }
}
