import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'HomePage.dart';

//main function to built the app
void main() => (runApp(UserType()));

//defining the first page for selecting the type of user
class UserType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//the content of first page which extends too statefulwidget
class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  //creating firebase instance for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creating object for storing signed in account
  final GoogleSignIn googleSignIn = new GoogleSignIn();

//function which handles the sign in
  Future<FirebaseUser> _signIn(BuildContext context) async {
    //sign in with a google account
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    //authenticating the google user
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    //getting all the credential of the authorised user
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    FirebaseUser userDetails = await _auth.signInWithCredential(credential);

    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);
    UserDetails details = new UserDetails(userDetails.photoUrl, providerData,
        userDetails.providerId, userDetails.email, userDetails.displayName,userDetails.uid);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new HomePage(details)));
    return userDetails;
  }

//will login
  Future<bool> login() async {
    // Simulate a future for response after 2 second.
    return await new Future<bool>.delayed(
        new Duration(seconds: 1), () => new Random().nextBool());
  }

  @override
  Widget build(BuildContext context) {
    //userinterface of screen
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/wust.jpg'),
                          fit: BoxFit.fill)),
                )),
//            ButtonTheme(
//                minWidth: 200.0,
//                height: 40.0,
//                buttonColor: Color(0xffffefefef),
//                shape: new RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(30.0)),
//                child: RaisedButton(
//                  onPressed: () {},
//                  child: Text(
//                    "SignIn as Admin",
//                    style: TextStyle(color: Colors.black54),
//                  ),
//                )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ButtonTheme(
                  minWidth: 200.0,
                  height: 40.0,
                  buttonColor: Color(0xffff983028),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: RaisedButton(
                    onPressed: () =>
                        _signIn(context).catchError((e) => print(e)),
//                        () {
//                      Navigator.of(context).pushNamed("/HomePage");
//                    },
                    child: Text(
                      "SignIn",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

//Pass the user details after sign in to next page
class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final String uid;
  final List<ProviderDetails> providerData;
  UserDetails(this.photoUrl, this.providerData, this.providerDetails,
      this.userEmail, this.userName,this.uid);
}

//Providing the providers details
class ProviderDetails {
  final String providerDetails;
  ProviderDetails(this.providerDetails);
}
