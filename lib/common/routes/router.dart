import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:demo_app/common/routes/routes.dart';
import 'package:demo_app/presentation/pages/home/home/home_page.dart';
import 'package:demo_app/presentation/pages/home/dashboard/dashboard_page.dart';
import 'package:demo_app/presentation/pages/login/login_screen.dart';
import 'package:demo_app/presentation/pages/home/search/search_screen.dart';
import 'package:demo_app/presentation/pages/home/not_found_page.dart';
import 'package:demo_app/presentation/pages/home/favorite/favorite_screen.dart';
import 'package:demo_app/presentation/pages/home/setting/setting_screen.dart';
import 'package:demo_app/presentation/pages/home/search/movieDetail_screen.dart';
import 'package:demo_app/presentation/pages/splash/splash_page.dart';

abstract class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _buildSplashRoute(settings);
      /*case Routes.home:
        return _buildHomeRoute(settings);
      case Routes.dashboard:
        return _buildDashboardRoute(settings);
      case Routes.search:
        return _buildSearchRoute(settings);
      case Routes.favoriteList:
        return _buildFavoriteRoute(settings);
      case Routes.settings:
        return _buildSettingsRoute(settings);*/
    }

    /*final uri = Uri.parse(settings.name);
    final List<String> pathElements = uri.path.split('/');
    if (pathElements[1] == Routes.favoriteDetailsPath) {
      final id = pathElements[2];
      return _buildFavoriteDetailsRoute(settings, id: id);
    }*/
    return null;
  }

  static Route _buildSplashRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => SplashPage(),
    );
  }


  
}