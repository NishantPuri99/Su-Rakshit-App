import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'api.dart';
import 'dart:convert';

class ScanUrlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File pickedImage;
  String text = '';
  String url;
  bool scanned = false;
  var Data;

  String QueryText = 'Your Url Status will be displayed here';

  bool imageLoaded = false;

  Future pickImage() async {
    // ignore: deprecated_member_use
    var awaitImage = await ImagePicker.pickImage(
        source: ImageSource.camera); //Use Image Picker to Open Camera

    setState(() {
      pickedImage = awaitImage; //Image gets loaded
      imageLoaded = true;
    });
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    //Firebase ML Vision
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        print(line.text);
        //for (TextElement word in line.elements) {

        RegExp regExp = new RegExp(
          r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$",
        );
        if (regExp.hasMatch(line.text)) {
          print("I FOUND THE STRING");
          setState(() {
            text = line.text + ' ';
            url = 'https://virus-total-flask.herokuapp.com/' +
                text.toString().toLowerCase();
            scanned = true;
            //Virus Total API, we add it here API(line.text)
            //ML Model(line.text),
          });
          break;
        }
      }
    }
    textRecognizer.close();
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan URL",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: hexToColor("#262626"),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          imageLoaded
              ? Center(
                  child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  height: 150,
                  child: Image.file(
                    pickedImage,
                    fit: BoxFit.cover,
                  ),
                ))
              : Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/img.gif'),
                  ),
                ),
          SizedBox(height: 10.0),
          Container(
            height: 50.0,
            child: RaisedButton(
              onPressed: () async {
                pickImage();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Click here to take a picture of URL",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 10.0)),
          Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            // color: Colors.blue,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Text(
              text == '' ? 'Your URL will display here' : text,
              style: new TextStyle(
                  color: Colors.amber,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 50.0,
            child: RaisedButton(
              onPressed: () async {
                Data = await Getdata(url);
                print(Data);
                var DecodedData = jsonDecode(Data);
                print(DecodedData);
                setState(() {
                  QueryText = DecodedData['Query'];
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 100.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Scan URL",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              (scanned == true)
                  ? QueryText
                  : "Your Url Status will be displayed here",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }
}
