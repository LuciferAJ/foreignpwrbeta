import 'package:flutter/material.dart';

//Creating the applications page
class Applications extends StatefulWidget {
  String AppbarTitle;
  Applications(this.AppbarTitle);
  @override
  _ApplicationsState createState() => _ApplicationsState(AppbarTitle);
}

//Creating the state of application
class _ApplicationsState extends State<Applications> {
  String AppbarTitle;
  _ApplicationsState(this.AppbarTitle);

  //UserInterface for Application page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffff983028),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            AppbarTitle,
            style: TextStyle(color: Colors.black87),
          ),
        ));
  }
}
