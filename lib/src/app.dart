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

  void fetchImageSearch(String str) async{
    var response = await get(url+str);
    List<ImageModel> myModels = (json.decode(response.body)['Search'] as List).map((i) => ImageModel.fromJson(i)).toList();

    setState(() {
      images = myModels;
    });
  }

  void initState() {
    super.initState();
    fetchImageSearch("&s=dark&y=2019");
  }

  Widget build(context) {
    return  MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        /*floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: fetchImageSearch,
        ),*/
        appBar: AppBar(
          centerTitle: true,
          title: Text('omdbapi.com'),
        ),
      ),
    );
  }
}