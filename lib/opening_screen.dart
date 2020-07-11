import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'package:flutter/services.dart';

class OpeningScreen extends StatefulWidget {
  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/front_page.jpg"), fit: BoxFit.cover)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent[400],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        },
        child: Icon(
          Icons.arrow_forward,
        ),
        tooltip: "Enter App",
      ),
    );
  }
}
