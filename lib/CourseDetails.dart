import 'package:flutter/material.dart';
import 'Avail_courses.dart';
import 'Faculty Form.dart';
import 'main.dart';

//Page to provide details about faculty
class CourseDetails extends StatefulWidget {
  AvailFieldBach availFieldBach;
  UserDetails userDetails;
  CourseDetails({this.availFieldBach, this.userDetails});
  @override
  _CourseDetailsState createState() =>
      _CourseDetailsState(availFieldBach, userDetails);
}

//Defining the state of the page
class _CourseDetailsState extends State<CourseDetails> {
  AvailFieldBach availFieldBach;
  UserDetails userDetails;
  _CourseDetailsState(this.availFieldBach, this.userDetails);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Column(
            //Dividing the content in two pieces as top content and bottom content and a floating button for applying that faculty
            children: <Widget>[
              topContent(context, availFieldBach),
              bottomContent(context, availFieldBach),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
        new Align(
          alignment: Alignment.bottomCenter,
          child: readButton(context, userDetails,availFieldBach),
        ),
      ]),
    );
  }
}

//Defining the user Interface of Top Content
topContent(context, AvailFieldBach availFieldBach) => Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20.0,
                  offset: new Offset(0.0, 10.0),
                )
              ],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
              image: new DecorationImage(
                image: availFieldBach.image,
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(58, 66, 86, .9),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0)),
          ),
          child: Center(
            child: topContentText(availFieldBach),
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        )
      ],
    );
topContentText(AvailFieldBach availFieldBach) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 150.0),
        Flexible(
          child: Text(
            availFieldBach.courseTitle,
            style: TextStyle(
                color: Colors.white, fontSize: 45.0, letterSpacing: 1.0),
          ),
        ),
      ],
    );
//Defining the User Interface of bottom content
bottomContentText(context, AvailFieldBach availFieldBach) => Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Description",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.0),
          ),
        ),
        Text(
          availFieldBach.courseDescription,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    ));

bottomContent(context, AvailFieldBach availFieldBach) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: <Widget>[
          bottomContentText(context, availFieldBach),
        ],
      ),
    );

//Defining the Floating button to apply for that courses
readButton(BuildContext context, UserDetails userDetails,AvailFieldBach availfieldbach) => Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: RaisedButton(
      onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FacultyForm(userDetails,availfieldbach),
                ))
          },
      color: Color(0xffff983028),
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child:
          Text("APPLY FOR THIS FACULTY", style: TextStyle(color: Colors.white)),
    ));
