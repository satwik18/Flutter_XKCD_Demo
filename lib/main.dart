import 'package:flutter/material.dart';
import 'package:xkcd_demo/route_generator.dart';

void main() => runApp(XkcdApp());

class XkcdApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
