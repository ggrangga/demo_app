import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  createState(){
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  String token;
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Container(margin: EdgeInsets.only(top:250.0)),
            loginFIeld(),
            Container(margin: EdgeInsets.only(bottom: 25.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget loginFIeld(){
    return Container(
      width: 250.0,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Token from omdbapi.com',
        ),
        validator: validateLogin,
        onSaved: (String value) {
          token = value;
        },
      ),
    );
  }
  
  Widget submitButton(){
    return RaisedButton(
      child: Text('Submit!'),
      onPressed: () async{
        if(formKey.currentState.validate()){
          formKey.currentState.save();
          var url = "http://www.omdbapi.com/?s=The%20Day%20After%20Tomorrow&apikey=$token";
          var response = await get(url);
          var rs = json.decode(response.body);
          if (rs['Response'] == "True") {
            print("rs => "+ rs.toString());
          }
        }        
      },
    );
  }
}