
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/imageDetail_model.dart';
import '../../widget/imageDetail_list.dart';
import '../../enum.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);
  createState() {
    return AppState();
  }
}
class AppState extends State<DashboardPage> {
  List<ImageDetailModel> images = [];

  void fetchImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    List<ImageDetailModel> myModels = new List.from(
      await getFromUrl(token, Enums.chfmsoli4qGetRecomended, true))
      ..addAll(await getFromUrl(token, Enums.chfmsoli4qGetAll, false));

    print("myModels getAll => " + myModels.length.toString());
    if (mounted && myModels.length > 0) {
      setState(() {
        images = myModels;
      });
    }
  }

  Future<List<ImageDetailModel>> getFromUrl(var token, var url, var isRecomended) async{
    List<ImageDetailModel> myModels = [];
    var response = await http.get(url, headers: {'token': token});
    var rs = json.decode(response.body);
    print("response.statusCode => " + response.statusCode.toString());
    print("url => " + url);
    print("rs => " + rs.toString());
    if (response.statusCode == 200) {
      if (rs != null) {
        if(isRecomended == false)
          myModels = (rs).map((i) => ImageDetailModel.fromJson(i)).toList();
        else
          myModels.add(ImageDetailModel.fromJson(rs));
      }      
    }
    return myModels;
  }

  void initState() {
    super.initState();
    fetchImage();
  }

  Widget build(context) {
    return new Container(
      child: Column(
        children: <Widget>[
          ImageList(images),
        ],
      ),
    );
  }
}