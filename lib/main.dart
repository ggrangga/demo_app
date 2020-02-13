import 'package:flutter/material.dart';
import 'src/screens/login/login_screen.dart';

import 'src/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Home Navigation',
        routes: Router.routes,
        //onGenerateRoute: Router.onGenerateRoute,
        //onUnknownRoute: Router.onUnknownRoute,
        home: LoginScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepPurple,
        ),
    );
  }
}