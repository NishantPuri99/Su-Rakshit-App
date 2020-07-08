import 'dart:io';
import 'package:flutter/material.dart';
import 'api.dart';
import 'dart:convert';

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
  String url;
  bool scanned = false;
  var Data;
  String QueryText = 'Query';
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                url = 'https://virus-total-flask.herokuapp.com/' +
                    value.toString();
                scanned = true;
              },
              decoration: InputDecoration(
                  hintText: 'Search Anything Here',
                  suffixIcon: GestureDetector(
                      onTap: () async {
                        Data = await Getdata(url);
                        var DecodedData = jsonDecode(Data);
                        setState(() {
                          QueryText = DecodedData['Query'];
                        });
                      },
                      child: Icon(Icons.search))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              (scanned == true)
                  ? QueryText
                  : "Your Url Status will be displayed here",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
