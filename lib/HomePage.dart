import 'package:flutter/material.dart';
import 'package:foreignpwrbeta/Application Forms.dart';
import 'package:foreignpwrbeta/Courses.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Contact Details.dart';
import 'main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Defining the Homepage
class HomePage extends StatefulWidget {
  UserDetails detailsUser;
  HomePage(this.detailsUser);
  @override
  _HomePageState createState() => _HomePageState(detailsUser);
}

//Creating the state of homepage
class _HomePageState extends State<HomePage> {
  UserDetails detailsUser;
  _HomePageState(this.detailsUser);
  @override
  Widget build(BuildContext context) {
    final String userId = detailsUser.providerDetails;
    final GoogleSignIn _gSignIn = GoogleSignIn();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
//returning the UserInterface
    return Scaffold(
      backgroundColor: Color(0xffff983028),
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Stack(children: <Widget>[
          Center(
//            heightFactor: height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//            FOR ADDING EMAIL
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    detailsUser.userEmail,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Text(
                  detailsUser.userName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23.0,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Positioned(
              top: 20,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('assets/wustlogo.png'),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.8,
//                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              )),
//          Positioned(
//            top: 20,
//            right: 0,
//            child: IconButton(
//              padding: const EdgeInsets.all(20.0),
////            alignment: Alignment.bottomRight,
//              icon: Icon(
//                Icons.edit,
//                color: Colors.white,
//              ),
//              onPressed: () {},
//            ),
//          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: Icon(
                    Icons.account_circle,
                    size: 130.0,
                    color: Colors.white,
                  ),
                ),
                Flexible(
//                  fit: FlexFit.loose,
                  flex: 2,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0)),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: _button(
                                    context,
                                    Courses("Courses", detailsUser),
                                    Icons.library_books)),
                            Expanded(
                                flex: 1,
                                child: _button(
                                    context,
                                    Applications(
                                        "Application Forms", detailsUser),
                                    Icons.description)),
                          ],
                        ),
                        Row(
                          children: <Widget>[
//
                            Expanded(
                                flex: 1,
                                child: _button(
                                    context, Contact(), Icons.contact_phone)),
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: Container(
                                    child: FlatButton(
//                  padding: const EdgeInsets.all(10.
// 0),

                                      onPressed: () {
                                        _gSignIn.signOut();
                                        Navigator.pop(context);
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.5),
                                              child: Icon(
                                                FontAwesomeIcons.signOutAlt,
                                                color: Colors.black87,
                                                size: 30.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 3.5),
                                              child: Text(
                                                "SignOut",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15.0),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      splashColor: Colors.white,
                                    ),
                                    margin: EdgeInsets.only(top: 30.0),
                                    height: height / 9,
                                    width: width / 2 - width / 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0)),
                                      gradient: LinearGradient(colors: [
                                        const Color(0xffffff),
                                        const Color(0xffffff)
                                      ]),
                                    ),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ]),
        ]),
      ),
    );
  }
}

//Buttons Template in the bottom section
Widget _button(BuildContext context, Widget pushedName, IconData icon) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
//Userinterface for the creates buttons
  return Center(
    child: Container(
      child: FlatButton(
//                  padding: const EdgeInsets.all(10.
// 0),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pushedName),
          );
        },
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(3.5),
                child: Icon(
                  icon,
                  color: Colors.black87,
                  size: 30.0,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3.5),
                child: Text(
                  pushedName.toString(),
                  style: TextStyle(color: Colors.black87, fontSize: 15.0),
                ),
              ),
            )
          ],
        ),
        splashColor: Colors.white,
      ),
      margin: EdgeInsets.only(top: 30.0),
      height: height / 9,
      width: width / 2 - width / 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        gradient: LinearGradient(
            colors: [const Color(0xffffff), const Color(0xffffff)]),
      ),
    ),
  );
}
