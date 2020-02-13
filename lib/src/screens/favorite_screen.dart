import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/imageDetail_model.dart';
import '../widget/imageDetail_list.dart';
import '../enum.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);
  createState() {
    return AppState();
  }
}

class AppState extends State<FavoriteScreen> {
  List<ImageDetailModel> images = [];

  void fetchImageFavoriteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await http.get(Enums.chfmsoli4qGetAll, headers: {'token': token});
    var rs = json.decode(response.body);
    if (response.statusCode == 200) {
      List<ImageDetailModel> myModels = [];
      if (rs != null) {
        myModels = (rs as List).map((i) => ImageDetailModel.fromJson(i)).toList();
      }
      print("myModels getAll => " + myModels.length.toString());
      
      if (mounted && myModels.length > 0) {
        setState(() {
          images = myModels;
        });
      }
    }
  }

  void initState() {
    super.initState();
    fetchImageFavoriteAll();
  }

  Widget build(context) {
    return new Container(
      child: Column(
        children: <Widget>[
          ImageList(images, true),
        ],
      ),
    );
  }
}