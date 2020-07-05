import 'package:flutter/material.dart';
import 'ScanUrlPage.dart';
import 'PasteUrlPage.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Text('How would you like to check the URL ?'),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 10,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            child: Text(
              'Scan URL',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blueAccent,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanUrlPage()));
            },
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            child: Text(
              'Paste URL',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blueAccent,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PasteUrlPage()));
            },
          ),
        ],
      ),
    );
  }
}
