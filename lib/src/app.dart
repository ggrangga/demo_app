import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'dart:convert';
import 'widget/image_list.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  final url = "http://www.omdbapi.com/?apikey=c4545306";
  List<ImageModel> images = [];

  void fetchImageSearch() async{
    String str = "&s=dark&y=2019";
    var response = await get(url+str);
    List<ImageModel> myModels = (json.decode(response.body)['Search'] as List).map((i) => ImageModel.fromJson(i)).toList();

    print("search");
    //print(myModels.toString());
    print(json.decode(response.body));
    setState(() {
      images = myModels;
    });
  }

  Widget build(context) {
    return  MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: fetchImageSearch,
        ),
        appBar: AppBar(
          title: Text('omdbapi'),
        ),
      ),
    );
  }
}