import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class FaceDetect extends StatefulWidget {
  @override
  _FaceDetectState createState() => _FaceDetectState();
}

class _FaceDetectState extends State<FaceDetect> {
    File pickedImage;

  bool isImageLoaded = false;
  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          "Face Detection",
          style: new TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColorStart: Colors.blue,
        backgroundColorEnd: Colors.indigo,
        centerTitle: true,
        titleSpacing: 8.0,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: 50.0,
                child: new RaisedButton(
                  textColor: Colors.white,
                  color: Colors.indigo,
                  elevation: 12.0,
                  splashColor: Colors.indigo,
                  child: Text(
                    "Pick an Image",
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    pickImage();
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
            isImageLoaded
                ? Center(
                    child: Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(pickedImage),
                                fit: BoxFit.cover))),
                  )
                : Container(),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: 50.0,
                child: new RaisedButton(
                  textColor: Colors.white,
                  color: Colors.indigo,
                  elevation: 12.0,
                  splashColor: Colors.indigo,
                  child: Text(
                    "Detect face",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  onPressed: () {
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
          ],
        )
      
    );
  }
}