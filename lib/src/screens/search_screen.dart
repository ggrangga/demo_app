import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import '../models/image_model.dart';
import 'dart:convert';
import '../widget/image_list.dart';
import '../enum.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);
  createState() {
    return AppState();
  }
}

class AppState extends State<SearchScreen> {
  int counter = 0;
  List<ImageModel> images = [];
  bool typing = false;

  void fetchImageSearch(String str) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var map = new Map<String, dynamic>();
    str.substring(1).split("&").toList().forEach((value) => map[value.split("=")[0]] = value.split("=")[1]); 
    Uri uri = Uri.http(Enums.omdbapi, '/', {
      'apikey': token,
      ...map
    });
    print("url =>" + uri.toString());
    var response = await get(uri);
    var rs = json.decode(response.body);
    if (rs['Response'] == "True") {
      List<ImageModel> myModels = [];
      if (rs['Search'] != null) {
        myModels = (rs['Search'] as List).map((i) => ImageModel.fromJson(i)).toList();
      } else {
        myModels[0] = ImageModel.fromJson(rs);
      }
      print("myModels => " + myModels.length.toString());
      if (mounted) {
        setState(() {
          images = myModels;
        });
      }
    }
  }

  void initState() {
    super.initState();
    fetchImageSearch("&s=dark&y=2019");
  }

  /*String Function() getDataFromSharedPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    setState(() {
      token = token;
    });
    return token;
  }*/

  Widget build(context) {
    return new Container(
      child: Column(
        children: <Widget>[
          SearchBoxPage(
            onSearchTappedCallback: (String movieName) {
              fetchImageSearch(movieName);
            },
          ),
          ImageList(images),
        ],
      ),
    );
  }
}

class SearchBoxPage extends StatefulWidget{
  final OnSearchTappedCallback onSearchTappedCallback;

  SearchBoxPage({this.onSearchTappedCallback});

  @override
  SearchBoxState createState()=> SearchBoxState();
}

typedef OnSearchTappedCallback = Function(String);
class SearchBoxState extends State<SearchBoxPage> {
  String textfieldOnlyTitleValue = "";
  String textfieldTitleValue = "";
  String dropdownYearValue = "2020";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(20.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: new TextField(
                decoration: InputDecoration(
                hintText: "Search by Title for 2019...",
              ),
              onChanged: (value) {
                setState(() {
                  textfieldOnlyTitleValue = value; 
                });
              },
            )
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              if (textfieldOnlyTitleValue.length > 0) {
                widget.onSearchTappedCallback("&s=$textfieldOnlyTitleValue&y=2019");
                setState(() {
                  textfieldOnlyTitleValue = "";
                });
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add_to_queue,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    textfieldTitleValue = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Search by Title...",
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                              value: dropdownYearValue,
                              items: <String>['2017', '2018', '2019', '2020'].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                print("dropdownYearValue " + value);
                                setState(() => dropdownYearValue = value);
                              },
                            ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  String r = "";
                                  if (textfieldTitleValue.length > 0) 
                                    r += "&s=$textfieldTitleValue";
                                  
                                  if (dropdownYearValue.length > 0) 
                                    r += "&y=$dropdownYearValue";
                                  

                                  if (r.length > 0) {
                                    widget.onSearchTappedCallback(r);
                                    setState(() {
                                      textfieldTitleValue = "";
                                      dropdownYearValue = "2020";
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}