import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class BarcodeScan extends StatefulWidget {
  @override
  _BarcodeScanState createState() => _BarcodeScanState();
}

class _BarcodeScanState extends State<BarcodeScan> {
  File pickedImage;

  bool isImageLoaded = false;
  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  Future decode() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    List barCodes = await barcodeDetector.detectInImage(ourImage);

    for (Barcode readableCode in barCodes) {
      print(readableCode.displayValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          title: Text(
            "Barcode Scanner",
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
                    "Read Barcode",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  onPressed: () {
                    decode();
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
