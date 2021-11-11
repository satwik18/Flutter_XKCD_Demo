import 'package:flutter/material.dart';
import 'package:xkcd_demo/route_generator.dart';

void main() => runApp(XkcdApp());

class XkcdApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
