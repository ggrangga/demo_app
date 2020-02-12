import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/image_model.dart';
import '../enum.dart';
import '../routes.dart';
import '../screens/movieDetail_screen.dart';

typedef OnImageListTappedCallback = Function(String);
class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  void addFavorite(ImageModel image) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = "1";
    map["timestamp"] = 1575473859;
    map["title"] = image.title;
    map["year"] = image.year;
    map["poster"] = image.poster;
    map["label"] = image.title;
    map["priority"] = 0;
    map["viewed"] = false;
    map["rating"] = 0;

    /*Map<String, String> header = {'token': token, 'Content-Type': 'application/json'};

    var response = await http.post(
      Enums.chfmsoli4qGetAll, 
      headers: header, 
      body: json.encode(map)
    );
    print(response.statusCode.toString() + " => " + response.reasonPhrase);*/
  }

  ImageList(this.images);
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
              margin: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Image.network(images[index].poster),
                  Text(
                    images[index].title + " (" + images[index].year + ")",
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      heroTag: index,
                      tooltip: 'Add',
                      child: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(imageModel: images[index])));
                      },
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