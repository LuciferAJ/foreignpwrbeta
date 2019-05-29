import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

import 'package:flutter/services.dart';

class FacultyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Faculty Form",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(child: FacultyFormBody()),
    );
  }
}

class FacultyFormBody extends StatefulWidget {
  @override
  _FacultyFormBodyState createState() => _FacultyFormBodyState();
}

class _FacultyFormBodyState extends State<FacultyFormBody>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;
//  TextEditingController _controller = new TextEditingController();

  FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final surname = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final phoneNo = TextEditingController();

  @override
  void initState() {
    super.initState();
    TextEditingController _controllerfile = new TextEditingController();
    _controller = AnimationController(
        vsync: this, duration: new Duration(milliseconds: 300));
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller);
    _animation.addListener(() {
      setState(() {});
      _controller.addListener(() => _extension = _controllerfile.text);
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  String _filePath;

  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.CUSTOM);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState(() {
        this._filePath = filePath;
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  final GoogleSignIn _gSignIn = GoogleSignIn();
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    name.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void submit() {
    Map<String, String> data = <String, String>{
      "name": name.text,
      "surname": surname.text,
      "phoneNo": phoneNo.text,
      "address": address.text,
      "email": email.text,
    };

    DocumentReference _documentReference = Firestore.instance
        .collection(email.text.substring(0, email.text.indexOf("@")))
        .document(name.text);
    _documentReference.setData(data).whenComplete(() {
      print("Submitted");
    }).catchError((e) => print(e));
  }
//  String generateId {
//  String id=email.toString().substring(0,email.toString().indexOf("@"));
//  return id;
//}

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _gSignIn = GoogleSignIn();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Name",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(
                focusNode: _focusNode,
                controller: name,
                autofocus: true,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
            ),
            Text(
              "Surname",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(
                controller: surname,
                autofocus: true,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
            ),
            Text(
              "Address",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(
                controller: address,
                autofocus: true,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
            ),
            Text(
              "Email",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(
                controller: email,
                autofocus: true,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
            ),
            Text(
              "Phone No.",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(
                controller: phoneNo,
                keyboardType: TextInputType.numberWithOptions(),
                autofocus: true,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: getFilePath,
                child: Icon(Icons.attach_file),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, we want to show a Snackbar
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Processing Data'),
                      duration: Duration(seconds: 2),
                    ));
                    submit();
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(content: Text(name.text));
                        });
                  }
                },
                child: Text('Submit'),
              ),
            ),
            SizedBox(height: _animation.value),
          ],
        ),
      ),
    );
  }
}

class FormAttributes {
  final GoogleSignIn _gSignIn = GoogleSignIn();
  TextEditingController name, surname, address, email, phoneNo;
  FormAttributes(name, surname, this.address, this.email, this.phoneNo);
  Map<String, dynamic> toJson() => {
        'title': _gSignIn.toString(),
        'name': name,
        'surname': surname,
        'address': address,
        'email': email,
        'phoneNo': phoneNo
      };
}
