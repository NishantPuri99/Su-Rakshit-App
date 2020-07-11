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
  String QueryText = 'Your Url Status will be displayed here';
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Paste URL",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: hexToColor("#262626"),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: new Container(
            child: new Center(
                child: new Column(children: [
              new Padding(padding: EdgeInsets.only(top: 100.0)),
              new Text(
                'Enter or Paste the URL in the field below',
                style:
                    new TextStyle(color: hexToColor("#F2A03D"), fontSize: 25.0),
              ),
              new Padding(padding: EdgeInsets.only(top: 10.0)),
              new TextFormField(
                cursorColor: Colors.green,
                cursorRadius: Radius.circular(1),

                onChanged: (value) {
                  url = 'https://virus-total-flask.herokuapp.com/' +
                      value.toString();
                  scanned = true;
                },
                decoration: new InputDecoration(
                    labelText: "Your URL goes here",
                    labelStyle: TextStyle(
                        color: Colors.blue, fontStyle: FontStyle.italic),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide(color: Colors.blue[200], width: 5.0),
                    ),
                    // border: new OutlineInputBorder(
                    //   borderSide: new BorderSide(color: Colors.blueAccent),
                    // ),
                    suffixIcon: GestureDetector(
                        onTap: () async {
                          Data = await Getdata(url);
                          var DecodedData = jsonDecode(Data);
                          setState(() {
                            QueryText = DecodedData['Query'];
                          });
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ))),
                //keyboardType: TextInputType.emailAddress,
                style:
                    new TextStyle(fontFamily: "Poppins", color: Colors.green),
              ),
              SizedBox(height: 10),
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
            ])),
          )),
    );
  }
}

// //AFTER SCAN
