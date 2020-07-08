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
  var text = '';
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
                line.text.toString().toLowerCase();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          imageLoaded
              ? Center(
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(blurRadius: 20),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  height: 150,
                  child: Image.file(
                    pickedImage,
                    fit: BoxFit.cover,
                  ),
                ))
              : Container(),
          SizedBox(height: 10.0),
          Center(
            child: FlatButton.icon(
              icon: Icon(
                Icons.photo_camera,
                size: 100,
              ),
              label: Text(''),
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                pickImage();
              },
            ),
          ),
          SizedBox(height: 10.0),
          text == ''
              ? Text('Text will display here')
              : Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        text,
                      ),
                    ),
                  ),
                ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                  child: Text("Scan"),
                  onPressed: () async {
                    Data = await Getdata(url);
                    var DecodedData = jsonDecode(Data);
                    setState(() {
                      QueryText = DecodedData['Query'];
                    });
                  })),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              (scanned == true)
                  ? QueryText
                  : "Your Url Status will be displayed here",
              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
