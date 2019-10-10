import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
//        alignment: Alignment.,
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)),
                    color: Color(0xffff983028),
                    image: new DecorationImage(
                      image: AssetImage('assets/building.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.all(40.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(152, 48, 40, 0.8),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0, left: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                )
              ])
            ],
          ),
          Center(
            child: Container(
//          height: MediaQuery.of(context).size.height * 0.4,
              height: 300.0,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 5.0),
                        blurRadius: 3,
//                        spreadRadius: 0.2,
                        color: Colors.grey)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Contact",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            fontSize: 22.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.home,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: _openMap,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.0,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _openMap,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Wroclaw University of Science and Technology\n27 Wybrzeże Wyspiańskiego st.\n50-370 Wrocław",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black54, fontSize: 15.0),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black54,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.phone,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: _launchPhone,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Phone",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.0,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _launchPhone,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "+48 71 320 2905",
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(color: Colors.black54, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _launchPhone() async {
    const url = 'tel:+48 71 320 2905';
    if (await canLaunch(url)) {
      await launch(url);
    } else
      throw 'Could not launch $url';
  }
}

_openMap() async {
  const url =
      'https://www.google.com/maps/search/?api=1&query=Wroclaw University of Science and Technology';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
