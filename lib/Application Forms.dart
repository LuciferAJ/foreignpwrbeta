import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'Avail_courses.dart';
import 'Application.dart';

//Creating the applications page
class Applications extends StatefulWidget {
  UserDetails detailsUser;
  String AppbarTitle;

  Applications(this.AppbarTitle, this.detailsUser);
  @override
  _ApplicationsState createState() =>
      _ApplicationsState(AppbarTitle, detailsUser);
}

//Creating the state of application
class _ApplicationsState extends State<Applications> {
  StreamSubscription<DocumentSnapshot> subscription;

  String AppbarTitle;
  List documentsList;
  List formData;
  UserDetails userDetails;
  AvailFieldBach availFieldBach;
  _ApplicationsState(this.AppbarTitle, this.userDetails);
  String name, surname, address, email, phoneNo;

  void fetch() {
    DocumentReference _documentReference =
        Firestore.instance.collection("user").document(userDetails.uid);
    _documentReference
        .collection("user")
        .document(userDetails.uid)
        .collection("Form")
        .getDocuments()
        .then((QuerySnapshot docs) {
      documentsList = docs.documents;
      for (int i = 0; i < documentsList.length; i++) {
        setState(() {
          formData.add(documentsList[i].data);
        });
        print(formData);
      }
    });
  }

  void delete() {
    DocumentReference _documentReference =
        Firestore.instance.collection("user").document(userDetails.uid);
    _documentReference
        .collection("user")
        .document(userDetails.uid)
        .collection("Form")
        .document()
        .delete()
        .whenComplete(() {
      print("Deleted");
      setState(() {});
    });
    Navigator.pop(context);
  }

  //UserInterface for Application page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xffff983028),
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
      ),
      body: ListPage(userDetails, availFieldBach),
    );
  }
}

class ListPage extends StatefulWidget {
  AvailFieldBach availFieldBach;
  UserDetails userDetails;
  ListPage(this.userDetails, this.availFieldBach);
  @override
  _ListPageState createState() => _ListPageState(userDetails);
}

class _ListPageState extends State<ListPage> {
  UserDetails userDetails;
  _ListPageState(this.userDetails);
  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot docsSnapShot = await firestore
        .collection("user")
        .document(userDetails.uid)
        .collection("Form")
        .getDocuments();
    return docsSnapShot.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getPosts(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("loading"),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data[index].data['faculty']),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].data["name"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23.0,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ApplicationDetails(
                                          snapshot.data[index], userDetails)));
                            },
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}

class ApplicationDetails extends StatefulWidget {
  final DocumentSnapshot application;
  UserDetails userDetails;

  ApplicationDetails(this.application, this.userDetails);
  @override
  _ApplicationDetailsState createState() => _ApplicationDetailsState();
}

class _ApplicationDetailsState extends State<ApplicationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                onPressed: () {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Delete Data ?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                              "This will parmanently delete all your form"),
                          actions: <Widget>[
                            new FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("Cancel")),
                            new FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("Delete")),
                          ],
                        );
                      });
//                  Navigator.pop(context);
                })
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Application",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: Center(
          child: Container(
            child: Card(
                child: ListTile(
                    title: Center(
                        child: Column(
//                            textDirection: TextDirection.ltr,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Name : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 23.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.application.data['name'] +
                              " " +
                              widget.application.data['surname'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 23.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Address: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.application.data['address'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Email : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.application.data['email'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Phone No : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.application.data['phoneNo'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Applied Faculty : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w400),
                          ),
                          Flexible(
                            child: Text(
                              widget.application.data['faculty'],
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ]),
                  ),
                ])))),
          ),
        ));
  }
}
