import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../../mixins/validation_mixin.dart';
import '../../enum.dart';
import '../../routes.dart';
import '../../blocs/bloc.dart';
import '../../blocs/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  createState(){
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  bool isValid = true;
  /*@override
  initState() {
    super.initState();

    bloc.loginSuccess.listen((loginResult) {

    });
  }*/

  @override
  Widget build(context) {
    final bloc = Provider.of(context);
    return new Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              Container(margin: EdgeInsets.only(bottom: 125.0)),
              nameFIeld(bloc),
              loginFIeld(bloc),
              Container(margin: EdgeInsets.only(bottom: 25.0)),
              submitButton(bloc),
            ],
          ),
        ),
      )
    );
  }

  Widget nameFIeld(Bloc bloc){
    return StreamBuilder(
      stream: bloc.name,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: bloc.changeName,
          decoration: InputDecoration(
            hintText: 'Fill your name!',
          ),
        );
      },
    );
  }

  Widget loginFIeld(Bloc bloc){
    return StreamBuilder(
      stream: bloc.token,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: bloc.changeToken,
          decoration: InputDecoration(
            hintText: 'Token from omdbapi.com',
            errorText: isValid ? snapshot.error : "Incorrect token!",
          ),
        );
      },
    );
  }
  
  Widget submitButton(Bloc bloc){
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Submit!'),
          onPressed: snapshot.hasData ? () async {
            isValid = await bloc.submitLogin();
           
            if(isValid){
              SharedPreferences prefs = await SharedPreferences.getInstance();
              bloc.token.listen((value) {
                prefs.setString('token', value);
              });
                        
              Navigator.of(context).pushNamed(Routes.dashboard,
                    arguments: 'Go to => Dashboard');
            }else
               setState(() {isValid = isValid;});
            
          } : null,
        );
      },
    );
  }
}