import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:async';
import 'dart:io';

class TextRec extends StatefulWidget {
  @override
  _TextRecState createState() => _TextRecState();
}

class _TextRecState extends State<TextRec> {
  File pickedImage;
  bool isImageLoaded = false;
  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
   
    for (TextBlock block in readText.blocks) {
      print(block.text);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          title: Text(
            "Text Recognition",
            style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
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
                    "Read Text",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  onPressed: () {
                    readText();
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
          ],
        ));
  }
}
