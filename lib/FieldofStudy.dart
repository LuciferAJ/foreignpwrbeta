import 'package:flutter/material.dart';
import 'package:foreignpwrbeta/CourseDetails.dart';
import 'Avail_courses.dart';

//FieldofStudy Page
//Will display all the available faculty of the courses
class FieldofStudy extends StatefulWidget {
  AvailCourses courses;
  FieldofStudy({this.courses});

  @override
  _FieldofStudyState createState() => _FieldofStudyState(courses);
}

//state of the Page
class _FieldofStudyState extends State<FieldofStudy> {
  //Storing all the faculty in a List
  List fields;
  AvailCourses courses;
  _FieldofStudyState(this.courses);
  @override

  //Initialising all the page with the faculty available
  void initState() {
    fields = getAvailFields(courses);
    super.initState();
  }

//UserInteraface for the Field Of study page
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
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.courses.CourseLevel,
          style: TextStyle(color: Colors.black87),
        ),
      ),
      backgroundColor: Color(0xffff983028),
      body: makeBody(context, fields),
    );
  }
}

//Storing all the Faculty in an container
makeBody(context, fields) => Container(
//  color: Colors.black26,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: fields.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(context, fields[index]);
        },
      ),
    );
//Displaying all the faculties  as card view
makeCard(context, AvailFieldBach fields) => new GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CourseDetails(
                    availFieldBach: fields,
                  )));
    },
    child: Card(
      elevation: 8.0,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),

//  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Center(
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Opacity(
                  opacity: 0.85,
                  child: new Image(
                    image: fields.image,
                    fit: BoxFit.fitWidth,

                    height: MediaQuery.of(context).size.height / 3.3,
                    width: MediaQuery.of(context).size.width,

//            color: Colors.grey,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 0.02,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    fields.courseTitle,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));

//Defining all the Card of Faculty with their values
List getAvailFields(AvailCourses courses) {
  if (courses.courseNo == 1) {
    return [
      AvailFieldBach(
          courseTitle: 'Computer Science',
          image: AssetImage('assets/cse.jpg'),
          courseDescription:
              "The programme emphasizes practical aspects of Computer Engineering and can be adapted to the student’s interest. The final effect of studies is obtaining of first level competences - knowledge, skills and qualifications in accordance with “Teaching Standards” in the field of Computer Science. They obtain the basic knowledge of mathematics and physics, general computer science areas, such as: operating systems, algorithms and data structures, languages and programming techniques, digital and analog technique, computers architecture, project management as well as ethical and legal aspects of computer science. Students who finished study will be able to: implement and deploy effective, reliable, safe and meeting users requirements informatics systems; comprehend, evaluate and deploy different solutions used in scope of computer systems; maintain, install, administrate and deploy tools and problem oriented informatics systems, develop system documentation. "),
      AvailFieldBach(
          courseTitle: 'Electronic and Computer Engineering',
          image: AssetImage('assets/ee.jpg'),
          courseDescription:
              "The program of study of the Electronic and Computer Engineering (ECE) contains all important needs and demands of the modern labor market for modern electronics. This direction combines the knowledge of traditional electronics and information technology, industrial automation and robotics. "),
      AvailFieldBach(
          courseTitle: 'Mechanical Engineering',
          image: AssetImage('assets/mech.jpg'),
          courseDescription:
              "This programme prepares the graduates for creative engineering work in machine design, machine operation and manufacturing processes. Student will be familiar with fundamental methods, techniques, tools and materials used for solving engineering tasks in the field of Mechanical Engineering. A student acquires a directional specialty by studying mechanics, machines theory, principles of machine design, thermodynamics, computer aided engineering techniques and manufacturing technologies. The programme gives reliable ground to take a job in any segment of industry and services where designing, producing or maintaining machines and equipment is essential for a business.")
    ];
  } else if (courses.courseNo == 2) {
    return [
      AvailFieldBach(
          courseTitle: 'Computer Engineering',
          image: AssetImage('assets/compeng.jpg'),
          courseDescription:
              "The final effect of studies at the Master level is obtaining knowledge, skills and qualifications in accordance with “Teaching Standards” in the field of Computer Science. Students receive extended knowledge in the area of specialization. Students who finished study will be able to: use various methods and techniques for problem interpreting, formulate and solve specific problems related to computer science, become team work leaders Additionally they will have obtained fluent and creative knowledge application in the area of specialization, which means mathematical models designing, problems formulating and solving, problem oriented informatics system analysis and testing."),
      AvailFieldBach(
          courseTitle: 'Applied Mathematics',
          image: AssetImage(
            'assets/appliedmath.jpg',
          ),
          courseDescription:
              'The programme (offered by the Faculty of Pure and Applied Mathematics in cooperation with the Hugo Steinhaus Center) is based on educational standards of the European Consortium for Mathematics in Industry (ECMI) that is confirmed by the status of ECMI Teaching Center Wroclaw University of Science and Technology obtained in 2014. The curriculum is oriented towards real life applications and industrial problems in educational style and contents. The goal of the studies is the real world applied mathematics education of specialists who are well prepared not only for work in the international financial institutions or enterprises but also for any situation in which the creative thinking is needed. The graduates have no problems with finding good jobs in the finance and insurance or industrial sectors in Poland and abroad. The MS diploma offers an opportunity to continue education at Ph.D. studies.'),
      AvailFieldBach(
          courseTitle: 'Environment Quality Management',
          image: AssetImage('assets/environment.png'),
          courseDescription:
              'ENVIRONMENTAL QUALITY MANAGEMENT specialization enables the graduates obtain the knowledge in environmental engineering and gain experience in technology of the protection of the environment. Moreover the graduates will be prepared for solving problems in sustainable development and technology and gaining information from the literature and other sources.'),
    ];
  }
}
