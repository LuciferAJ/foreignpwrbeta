import 'package:flutter/material.dart';

class AvailCourses {
  String CourseLevel;
  String Difficulty;
  IconData iconData;
  int courseNo;
  AvailCourses(
      {this.CourseLevel, this.Difficulty, this.iconData, this.courseNo});
}

class AvailFieldBach {
  String courseTitle;
  AssetImage image;
  String courseDescription;
  AvailFieldBach({this.courseTitle, this.image, this.courseDescription});
}
