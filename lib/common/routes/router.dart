import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:demo_app/presentation/pages/home/home/home_page.dart';
import 'package:demo_app/presentation/pages/home/dashboard/dashboard_page.dart';
import 'package:demo_app/presentation/pages/login/login_screen.dart';
import 'package:demo_app/presentation/pages/home/search/search_screen.dart';
import 'package:demo_app/presentation/pages/home/not_found_page.dart';
import 'package:demo_app/presentation/pages/home/favorite/favorite_screen.dart';
import 'package:demo_app/presentation/pages/home/setting/setting_screen.dart';
import 'package:demo_app/presentation/pages/home/search/movieDetail_screen.dart';

abstract class Router {
  static Map<String, WidgetBuilder> routes = {
    Routes.home: (BuildContext context) => HomePage(),
    Routes.dashboard: (BuildContext context) => HomePage(page: HomePageOptions.dashboard,),
    Routes.login: (BuildContext context) => LoginScreen(),
    Routes.search: (BuildContext context) => SearchScreen(),
    Routes.favoriteList: (BuildContext context) => FavoriteScreen(),  
    Routes.settings: (BuildContext context) => SettingScreen(),
    Routes.movieDetail: (BuildContext context) => MovieDetailScreen(),  
  };

  ///   settings/profile/edit/?title=Matrix&year=2010

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print("settings => " + settings.toString() + "|");
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