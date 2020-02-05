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
  bool typing = false;

  void fetchImageSearch(String str) async {
    str = Uri.parse(url+str).toString();
    //str = str.toString().replaceAll('\'', "%27");
    //print("url =>"+str);
    //str = str.toString().replaceAll(" ", "%20");
    print("url =>" + str);
    var response = await get(str);
    var rs = json.decode(response.body);
    //print(rs['Search']);
    if (rs['Response'] == "True") {
      List<ImageModel> myModels = [];
      if (rs['Search'] != null) {
        //print("true");
        myModels =
            (rs['Search'] as List).map((i) => ImageModel.fromJson(i)).toList();
      } else {
        //print("false");
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

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        appBar: AppBar(
          centerTitle: true,
          title: typing
              ? SearchBox(
                  onSearchTappedCallback: (String movieName) {
                    fetchImageSearch(movieName);
                  },
                )
              : Text('omdbapi.com'),
          leading: IconButton(
            icon: Icon(
              typing ? Icons.done : Icons.menu,
            ),
            onPressed: () {
              setState(() {
                typing = !typing;
              });
            },
          ),
        ),
      ),
    );
  }
}

typedef OnSearchTappedCallback = Function(String);

class SearchBox extends StatelessWidget {
  final OnSearchTappedCallback onSearchTappedCallback;
  final TextEditingController searchOnlyByTitleController =
      new TextEditingController();
  final TextEditingController searchByTitleController =
      new TextEditingController();
  final TextEditingController searchByYearController =
      new TextEditingController();

  SearchBox({this.onSearchTappedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchOnlyByTitleController,
              decoration: InputDecoration(
                hintText: "Search by Title for 2019...",
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              String str = searchOnlyByTitleController.text;
              if (str.length > 0) {
                onSearchTappedCallback("&s=$str&y=2019");
                searchOnlyByTitleController.text = "";
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
                                controller: searchByTitleController,
                                decoration: InputDecoration(
                                  hintText: "Search by Title...",
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: searchByYearController,
                                decoration: InputDecoration(
                                  hintText: "Search by Year...",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  String strTitle =
                                      searchByTitleController.text;
                                  String strYear = searchByYearController.text;
                                  String r = "";
                                  if (strTitle.length > 0) {
                                    r += "&s=$strTitle";
                                    searchByTitleController.text = "";
                                  }
                                  if (strYear.length > 0) {
                                    r += "&y=$strYear";
                                    searchByYearController.text = "";
                                  }

                                  if (r.length > 0) {
                                    onSearchTappedCallback(r);
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
