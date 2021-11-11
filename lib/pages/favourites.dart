import 'package:flutter/material.dart';
import 'package:xkcd_demo/models/comic.dart';

class Favourites extends StatelessWidget {
  final Set<Comic> savedComics;

  const Favourites({key, required this.savedComics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = savedComics.map((Comic comic) {
      return ListTile(
          title: Text(comic.title + ' | ' + comic.comicNumber.toString(),
              style: const TextStyle(fontSize: 16.0)),
          onTap: () {
            Navigator.of(context).pushNamed(
              '/comic_viewer',
              arguments: comic,
            );
          });
    });

    return Scaffold(
        appBar: AppBar(title: const Text('Favourites'), centerTitle: true),
        body: ListView(
            children:
                ListTile.divideTiles(context: context, tiles: tiles).toList()));
  }
}
