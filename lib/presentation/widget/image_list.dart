import 'package:flutter/material.dart';
import 'package:demo_app/domain/omdb/entities/image_model.dart';
import 'package:demo_app/presentation/pages/home/search/movieDetail_screen.dart';

typedef OnImageListTappedCallback = Function(String);
class ImageList extends StatelessWidget {
  final List<ImageModel> images;

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