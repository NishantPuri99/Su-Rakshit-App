import 'dart:io';
import 'package:flutter/material.dart';

class PasteUrlPage extends StatelessWidget {
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
  String text = "";
  final myController = TextEditingController();
  void changeName(String TE) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (TE == "") {
        text = "The Url Status Will Be Displayed Here";
      } else {
        text = TE;
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          Text('Enter or Paste the URL in the field below'),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200.0,
                child: TextField(
                  controller: myController,
                  decoration: new InputDecoration(hintText: "Type Here"),
                  onChanged: (String str) {
                    text = str;
                  },
                  onSubmitted: (String str) {
                    text = str;
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  changeName(text);
                },
              ),
            ],
          ),
          Text(text == "" ? "" : '$text is OK'),
        ],
      ),
    );
  }
}
