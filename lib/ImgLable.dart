import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class ImgLabel extends StatefulWidget {
  @override
  _ImgLabelState createState() => _ImgLabelState();
}

class _ImgLabelState extends State<ImgLabel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File pickedImage;

  bool isImageLoaded = false;
  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  Future<void> detectLabels() async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(pickedImage);
    final ImageLabeler labelDetector = FirebaseVision.instance.imageLabeler();
    final List<ImageLabel> labels =
        await labelDetector.processImage(visionImage);
    for (ImageLabel label in labels) {
      final String text = label.text;
      print(text);
      //final String entityId = label.entityId;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(text),
        duration: new Duration(seconds: 2),
        backgroundColor: Colors.green,
      ));
      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: Text(entityId),
      //   duration: new Duration(seconds: 2),
      //   backgroundColor: Colors.grey,
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          "Image Labelling",
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
                  "Detect Labes",
                  style: new TextStyle(fontSize: 16.0),
                ),
                onPressed: () {
                  detectLabels();
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
