import 'package:flutter/material.dart';
import 'package:xkcd_demo/models/comic.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ComicViewer extends StatelessWidget {
  final Comic comic;

  const ComicViewer({key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(comic.title), centerTitle: true),
        body: Center(
            child: PinchZoom(child: Image.network(comic.img), maxScale: 3.0)));
  }
}
