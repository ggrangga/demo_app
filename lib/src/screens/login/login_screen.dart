import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../../mixins/validation_mixin.dart';
import '../../enum.dart';
import '../../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  createState(){
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  String token;

  @override
  Widget build(context) {
    return new Scaffold(
      body: Container(
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
      )
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
          Uri uri = Uri.http(Enums.omdbapi, '/', {
            'apikey': token,
            's': 'The Day After Tomorrow'
          });
          var response = await get(uri);
          var rs = json.decode(response.body);
          if (rs['Response'] == "True") {
            Navigator.of(context).pushNamed(Routes.dashboard,
                arguments: 'Go to => Dashboard');
          }
        }        
      },
    );
  }
}