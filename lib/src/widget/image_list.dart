import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList(this.images);
  Widget build(context) {    
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, int index){
        if(images != null && images.length > 0){
          print("true");
          print(images[index].toJson());
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(20.0),
            child: Image.network(images[index].poster),
          ); 
        }
      }
    );    
  }
}