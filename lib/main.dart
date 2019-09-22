import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'TextRec.dart';
import 'ImgLable.dart';
import 'package:ml_kit_app/FaceDetect.dart';
import 'BarcodeScan.dart';

void main() {
  runApp(new MaterialApp(
    title: "ML Kit App",
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cardTitleText, imagePath, cardBottomText, pageValueFromTap;
  Widget buildCard(cardTitleText, imagePath, cardBottomText, pageValueFromTap) {
    String pageValue = pageValueFromTap;
    return GestureDetector(
      onTap: () {
        if (pageValue == "textrec") {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => TextRec()));
        } else if (pageValue == "imglab") {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => ImgLabel()));
        } else if (pageValue == "facedetect") {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => FaceDetect()));
        } else {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => BarcodeScan()));
        }
      },
      child: Card(
        child: Stack(
          children: <Widget>[
            Center(
                child: Container(
              decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      offset: new Offset(10.0, 5.0),
                      blurRadius: 20.0,
                    )
                  ],
                  gradient: new LinearGradient(
                      colors: [Colors.blue.shade400, Colors.indigo.shade400])),
            )),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(cardTitleText,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                new SizedBox(
                  height: 8.0,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Image.asset(imagePath),
                )),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: new Text(cardBottomText,
                        textAlign: TextAlign.justify,
                        style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          "ML KIT APP",
          style: new TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColorStart: Colors.blue,
        backgroundColorEnd: Colors.indigo,
        centerTitle: true,
        titleSpacing: 8.0,
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(8.0),
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 5.0,
        children: <Widget>[
          buildCard(
              "Text recognition",
              'images/text_recognition@2x.png',
              "Recognize and extract text from images. Text recognition can automate tedious data entry for credit cards, receipts, and business cards. "
                  "With the Cloud-based API, you can also extract text from pictures of documents, which you can use to increase accessibility or translate documents."
                  " Apps can even keep track of real-world objects, such as by reading the numbers on trains.",
              "textrec"),
          buildCard(
              "Barcode scanning",
              'images/barcode_scanning@2x.png',
              "Scan and process barcodes. Barcodes are a convenient way to pass information from the real world to your app. In particular, when using 2D formats such as QR code, you can encode "
                  "structured data such as contact information or WiFi network credentials. Because ML Kit can automatically recognize and parse this data,"
                  " your app can respond intelligently when a user scans a barcode.",
              "barcodescan"),
          buildCard(
              "Image labeling",
              'images/image_classification.png',
              "Identify objects, locations, activities, animal species, products, and more.Image labeling gives you insight into the content of images. When you use the API, "
                  "you get a list of the entities that were recognized: people, things, places, activities, and so on. Each label found comes with a score that indicates the confidence "
                  "the ML model has in its relevance. With this information, "
                  "you can perform tasks such as automatic metadata generation and content moderation.",
              "imglab"),
          buildCard(
              "Face detection",
              'images/face_detection_with_contour@2x.png',
              "Detect faces and facial landmarks, now with Face Contours. With face detection, you can get the information you need to perform tasks like embellishing selfies and portraits,"
                  " or generating avatars from a user's photo. "
                  "Because ML Kit can perform face detection in real time, you can use it in applications like video chat or games that respond to the player's expressions.",
              "facedetect"),
        ],
      ),
    );
  }
}
