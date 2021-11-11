import 'package:flutter/material.dart';
import 'package:xkcd_demo/models/comic.dart';
import 'package:xkcd_demo/pages/catalogue.dart';
import 'package:xkcd_demo/pages/comic_viewer.dart';
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
        if (args is Set<Comic>) {
          return MaterialPageRoute(
              builder: (_) => Favourites(savedComics: args));
        }

        return _errorRoute();
      case '/comic_viewer':
        if (args is Comic) {
          return MaterialPageRoute(builder: (_) => ComicViewer(comic: args));
        }

        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
