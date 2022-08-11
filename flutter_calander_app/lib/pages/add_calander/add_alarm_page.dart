import 'dart:io';
import 'package:flutter/material.dart';

class AddAlarmPage extends StatelessWidget {
  const AddAlarmPage(
      {Key? key, required this.calenderImage, required this.calenderName})
      : super(key: key);

  final File? calenderImage;
  final String calenderName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        calenderImage == null ? Container() : Image.file(calenderImage!),
        Text(calenderName)
      ],
    ));
  }
}
