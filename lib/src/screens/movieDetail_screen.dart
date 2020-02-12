import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../routes.dart';
import '../models/image_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final ImageModel imageModel;
  MovieDetailScreen({Key key, @required this.imageModel}) : super(key: key);
  createState() {
    print("MovieDetailScreen =>>");
    return AppState();
  }
}

class AppState extends State<MovieDetailScreen> {
  bool IsRecomended = false;
  ImageModel thisImageModel;
  void initState() {
    super.initState();
    thisImageModel = widget.imageModel;
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Editor"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(),
      drawer: Drawer(),
    );
  }
}