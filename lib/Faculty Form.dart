import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/services.dart';
//import 'package:file_picker/file_picker.dart';

//class FireStore extends StatelessWidget {
////  FireStore({this.auth, this.onSignedOut});
////  final BaseAuth auth;
////  final VoidCallback onSignedOut;
//
////  void _signOut() async {
////    try {
////      await auth.signOut();
////      onSignedOut();
////    } catch (e) {
////      print(e);
////    }
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//        appBar: new AppBar(title: new Text('Welcome'), actions: <Widget>[
////          new FlatButton(
////              child: new Text('Logout',
////                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
////              onPressed: _signOut)
//        ]),
//        body: new StreamBuilder(
//          stream: Firestore.instance.collection('books').snapshots(),
//          builder:
//              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//            if (!snapshot.hasData) return CircularProgressIndicator();
//            return new GridView.count(
//              crossAxisCount: 2,
//              childAspectRatio: 1.0,
//              padding: const EdgeInsets.all(4.0),
//              mainAxisSpacing: 4.0,
//              crossAxisSpacing: 4.0,
//              children:
//                  snapshot.data.documents.map((DocumentSnapshot document) {
//                return new ListTile(
//                  title: new Text(document['title']),
//                  subtitle: new Text(document['author']),
//                );
//              }).toList(),
//            );
//          },
//        ),
//        floatingActionButton: new FloatingActionButton(
//            elevation: 0.0,
//            child: new Icon(Icons.add),
//            backgroundColor: new Color(0xFFE57373),
//            onPressed: () {
//              Navigator.push(
//                context,
//                new MaterialPageRoute(
//                    builder: (context) => new UploadFormField()),
//              );
//            }));
//  }
//}
//
//// UPLOAD TO FIRESTORE
//
//class UploadFormField extends StatefulWidget {
//  @override
//  _UploadFormFieldState createState() => _UploadFormFieldState();
//}
//
//class _UploadFormFieldState extends State<UploadFormField> {
//  GlobalKey<FormState> _key = GlobalKey();
//  bool _validate = false;
//  String title, author;
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Upload'),
//        ),
//        body: new SingleChildScrollView(
//          child: new Container(
//            margin: new EdgeInsets.all(15.0),
//            child: new Form(
//              key: _key,
//              autovalidate: _validate,
//              child: FormUI(),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget FormUI() {
//    return new Column(
//      children: <Widget>[
//        new TextFormField(
//            decoration: new InputDecoration(hintText: 'Title'),
//            validator: validateTitle,
//            onSaved: (String val) {
//              title = val;
//            }),
//        new TextFormField(
//            decoration: new InputDecoration(hintText: 'Author'),
//            validator: validateAuthor,
//            onSaved: (String val) {
//              author = val;
//            }),
//        new SizedBox(height: 15.0),
//        new RaisedButton(
//          onPressed: _sendToServer,
//          child: new Text('Upload'),
//        )
//      ],
//    );
//  }
//
//  String validateTitle(String value) {
//    String patttern = r'(^[a-zA-Z ]*$)';
//    RegExp regExp = new RegExp(patttern);
//    if (value.length == 0) {
//      return "Title is Required";
//    } else if (!regExp.hasMatch(value)) {
//      return "Title must be a-z and A-Z";
//    }
//    return null;
//  }
//
//  String validateAuthor(String value) {
//    String patttern = r'(^[a-zA-Z ]*$)';
//    RegExp regExp = new RegExp(patttern);
//    if (value.length == 0) {
//      return "Author is Required";
//    } else if (!regExp.hasMatch(value)) {
//      return "Author must be a-z and A-Z";
//    }
//    return null;
//  }
//
//  _sendToServer() {
//    if (_key.currentState.validate()) {
//      //No error in validator
//      _key.currentState.save();
//      Firestore.instance.runTransaction((Transaction transaction) async {
//        CollectionReference reference = Firestore.instance.collection('books');
//
//        await reference.add({"Title": "$title", "Author": "$author"});
//      });
//    } else {
//      // validation error
//      setState(() {
//        _validate = true;
//      });
//    }
//  }
//}
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
  final myController = TextEditingController();
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

//  void _openFileExplorer() async {
//    if (_pickingType != FileType.ANY || _hasValidMime) {
//      try {
//        if (_multiPick) {
//          _path = null;
//          _paths = await FilePicker.getMultiFilePath(
//              type: _pickingType, fileExtension: _extension);
//        } else {
//          _paths = null;
//          _path = await FilePicker.getFilePath(
//              type: _pickingType, fileExtension: _extension);
//        }
//      } on PlatformException catch (e) {
//        print("Unsupported operation" + e.toString());
//      }
//      if (!mounted) return;
//
//      setState(() {
//        _fileName = _path != null
//            ? _path.split('/').last
//            : _paths != null ? _paths.keys.toString() : '...';
//      });
//    }
//  }
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: myController,
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
                controller: myController,
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
                controller: myController,
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
                controller: myController,
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
                controller: myController,
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

                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(content: Text(myController.text));
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
