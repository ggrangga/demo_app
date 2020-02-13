import 'package:flutter/material.dart';
import '../models/imageDetail_model.dart';
import '../enum.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ImageList extends StatelessWidget {
  final List<ImageDetailModel> images;
  final bool isRecommended;

  Future<String> deleteFavorite(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, String> header = {'token': token, 'Content-Type': 'application/json'};

    var response = await http.delete(
      Enums.chfmsoli4qGetAll+id, 
      headers: header
    );
    print(response.statusCode.toString() + " => " + response.reasonPhrase);
    return response.statusCode.toString();
  }

  ImageList(this.images, this.isRecommended);
  Widget build(context) {    
    return new Expanded (
      child: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, int index){
          if(images[index].poster != null && images[index].poster.length > 3){
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.only(right: 50.0, left: 50.0, bottom: 10.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          width: 100.0,
                          height: 150.0,
                          child: Image.network(images[index].poster),
                        ),
                        new Expanded(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Container(
                                      margin: const EdgeInsets.only(
                                          top: 12.0, bottom: 10.0),
                                      child: new Text(images[index].title,
                                        style: new TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.only(right: 10.0),
                                    child: new Text(
                                      images[index].priority.toString(),
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              new Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: new Row(
                                  children: <Widget>[
                                    new Text("RELEASED",
                                      style: new TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 11.0,
                                      ),
                                    ),
                                    new Container(
                                        margin: const EdgeInsets.only(left: 5.0),
                                        child: new Text(images[index].year)
                                    ),
                                  ],
                                ),
                              ),
                              isRecommended ?
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 30.0,
                                    height: 30.0,
                                    child: FloatingActionButton(
                                      tooltip: 'Remove',
                                      child: Icon(Icons.remove),
                                      onPressed: () {
                                        deleteFavorite(images[index].id);
                                      },
                                    ),
                                  ),
                                )
                              : new Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ); 
          }
        }
      )
    );    
  }
}