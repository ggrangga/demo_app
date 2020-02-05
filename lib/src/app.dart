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
          title: typing ? SearchBox() : Text('omdbapi.com'),
          leading: IconButton(
            icon: Icon(typing ? Icons.done : Icons.menu,),
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
class SearchBox extends StatelessWidget {
  TextEditingController searchOnlyByTitleController = new TextEditingController();
  TextEditingController searchByTitleController = new TextEditingController();
  TextEditingController searchByYearController = new TextEditingController();
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
                hintText: "Search by Title...",
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
              if(str.length > 0){
                //fetchImageSearch("&s=$str");
                searchOnlyByTitleController.text = "";
                print("Search on front! &s=$str");
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
                                String strTitle = searchByTitleController.text;
                                String strYear = searchByYearController.text;
                                String r = "";
                                if(strTitle.length > 0){
                                  r += "&s=$strTitle";
                                  searchByTitleController.text = "";
                                }
                                if(strYear.length > 0){
                                  r += "&s=$strYear";
                                  searchByYearController.text = "";
                                }
                                
                                //fetchImageSearch(r);
                                print("Search on front! $r");
                                Navigator.pop(context);
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