import 'package:flutter/material.dart';
import 'package:foreignpwrbeta/FieldofStudy.dart';
import 'package:line_icons/line_icons.dart';
import 'Avail_courses.dart';
import 'main.dart';

//Courses Page which imports object from HomePage
class Courses extends StatefulWidget {
  String AppbarTitle;
  UserDetails userDetails;
  //Constructors
  Courses(this.AppbarTitle, this.userDetails);
  @override
  _CoursesState createState() => _CoursesState(AppbarTitle, userDetails);
}

//State of Courses Page
class _CoursesState extends State<Courses> {
  //Store the all Courses in List View Object
  List courses;
  UserDetails userDetails;

  @override
  void initState() {
    courses = getAvailCourses();
    super.initState();
  }

  String AppbarTitle;
  _CoursesState(this.AppbarTitle, this.userDetails);
//UserInterface for Courses Page
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
        ),
        body: CourseType(courses, context, userDetails));
  }
}

// Defining how the courses object are displayed on the page
CourseType(courses, context, UserDetails userDetails) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(courses[index], context, userDetails);
        },
      ),
    );

//Making the Cards inside the container to present each course
Card makeCard(AvailCourses courses, context, UserDetails userDetails) => Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: makeListTile(courses, context, userDetails),
      ),
    );

//This will Present that in List View
ListTile makeListTile(courses, context, UserDetails userDetails) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.black26))),
        child: Icon(
          courses.iconData,
          color: Colors.black26,
          size: 25.0,
        ),
      ),
      title: Text(
        courses.CourseLevel,
        style: TextStyle(
            color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Icon(Icons.linear_scale, color: Colors.redAccent),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(courses.Difficulty,
                style: TextStyle(color: Colors.redAccent)),
          )
        ],
      ),
      trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.black26, size: 30.0),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FieldofStudy(courses: courses, userDetails: userDetails)));
      },
    );

//Defining all the Courses Information
List getAvailCourses() {
  return [
    AvailCourses(
        CourseLevel: 'Bachelor\'s Degree',
        Difficulty: 'Basic',
        iconData: LineIcons.certificate,
        courseNo: 1),
    AvailCourses(
        CourseLevel: 'Master\'s Degree',
        Difficulty: 'Intermediate',
        iconData: LineIcons.mortar_board,
        courseNo: 2),
    //If Someone wants to also include PhD degree Uncomment this
//    AvailCourses(
//        CourseLevel: 'PhD',
//        Difficulty: 'Advanced',
//        iconData: LineIcons.black_tie,
//        courseNo: 3)
  ];
}
