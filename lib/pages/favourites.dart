import 'package:flutter/material.dart';
import 'package:xkcd_demo/models/comic.dart';

class Favourites extends StatelessWidget {
  final Set<Comic> _savedComics;
  final BuildContext _context;
  final Iterable<ListTile> _tiles;

  Favourites(this._savedComics, this._context)
      : _tiles = _savedComics.map((Comic comic) {
          return ListTile(
              title: Text(comic.title + ' | ' + comic.comicNumber.toString(),
                  style: TextStyle(fontSize: 16.0)));
        });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Saved Comics')),
        body: ListView(
            children: ListTile.divideTiles(context: _context, tiles: _tiles)
                .toList()));
  }
}
