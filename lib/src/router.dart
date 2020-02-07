import 'package:flutter/material.dart';
import 'routes.dart';
import 'screens/home/home_page.dart';
import 'screens/dashboard/dashboard_page.dart';
import 'screens/login/login_screen.dart';
import 'screens/search_screen.dart';
import 'screens/not_found_page.dart';

abstract class Router {
  static Map<String, WidgetBuilder> routes = {
    Routes.home: (BuildContext context) => HomePage(),
    Routes.dashboard: (BuildContext context) => HomePage(page: HomePageOptions.dashboard,),
    Routes.login: (BuildContext context) => LoginScreen(),
    Routes.search: (BuildContext context) => SearchScreen(),  
  };

  ///   settings/profile/edit/?title=Matrix&year=2010

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    if (pathElements[0] != '') {
      return null;
    } else if (pathElements[1] == Routes.favoriteDetailsPath) {
      return MaterialPageRoute(
        builder: (context) {
          return DashboardPage();
        },
      );
    }
    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) {
          return NotFoundPage();
        },
      );
  }

}