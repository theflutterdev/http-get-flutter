//Follow http://instagram.com/theflutterdev
//Website http://theflutterdev.blogspot.com
//Twitter handle http://twitter.com/naikrps

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'HTTP API',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];
  bool isLoading = true;
  Future getData() async { 
    setState(() {
      isLoading = true;
    });
    var res = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/photos"),
    );
    List jsonData = json.decode(res.body);
    setState(() {
      data = jsonData;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP API"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NextPage(loadData: LoadData(title: data[i]['title'], url: data[i]['url']),)));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data[i]['url']),
                    ),
                    title: Text(data[i]['title']),
                  ),
                );
              },
            )),
    );
  }
}



class LoadData{
  String title;
  String url;
  LoadData({this.title, this.url});
}

class NextPage extends StatefulWidget {
  final LoadData loadData;
  NextPage({this.loadData});
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NextPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 70.0,
              backgroundImage: NetworkImage(widget.loadData.url),
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(widget.loadData.title),
          ],
        ),
      ),
    );
  }
}