import 'package:flutter/material.dart';
import 'package:xkcd_demo/main.dart';
import 'package:xkcd_demo/models/comic.dart';
import 'package:xkcd_demo/pages/catalogue.dart';
import 'package:xkcd_demo/pages/favourites.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Catalogue());
      case '/favourites':
        // Validation of correct data type
        List<dynamic> argsAsList = args as List<dynamic>;
        if (argsAsList.isNotEmpty &&
            argsAsList[0] is Set<Comic> &&
            argsAsList[1] is BuildContext) {
          return MaterialPageRoute(
            builder: (_) => Favourites(argsAsList[0], argsAsList[1]),
          );
        }
        // If args is not of the correct type, return an error page.
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
