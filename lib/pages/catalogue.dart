import 'package:flutter/material.dart';
import 'package:xkcd_demo/models/comic.dart';
import 'package:xkcd_demo/services/http_service.dart';

class Catalogue extends StatefulWidget {
  @override
  CatalogueState createState() => CatalogueState();
}

class CatalogueState extends State<Catalogue> {
  //CONSTANTS
  static const batchSize = 15;

  //DEPENDENCEIS
  final HttpService httpService = HttpService();
  ScrollController controller = ScrollController(keepScrollOffset: true);

  //STATE VARS
  final _fetchedComics = <Comic>[];
  int _numComics = 0;
  final _savedComics = <Comic>{};

  void _fetchInitData() {
    httpService.getComic().then((res) {
      setState(() {
        _numComics = res.comicNumber;
        _fetchedComics.add(res);
      });
    }).whenComplete(() => _getNextComics());
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      _getNextComics();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
    _fetchInitData();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  Widget _buildList() {
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.all(16.0),
      itemCount: _fetchedComics.isEmpty ? 0 : (_fetchedComics.length * 2) - 1,
      itemBuilder: (context, item) {
        if (item.isOdd) return const Divider();

        final index = item ~/ 2;

        return _buildRow(_fetchedComics[index]);
      },
    );
  }

  Widget _buildRow(Comic comic) {
    final alreadySaved = _savedComics.contains(comic);

    return ListTile(
        title: Text(comic.title + ' | ' + comic.comicNumber.toString(),
            style: const TextStyle(fontSize: 18.0)),
        trailing: IconButton(
            icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null),
            onPressed: () => _pushFavorite(alreadySaved, comic)),
        onTap: () {
          Navigator.of(context).pushNamed(
            '/comic_viewer',
            arguments: comic,
          );
        });
  }

  void _pushFavorite(isSaved, comic) {
    setState(() {
      if (isSaved) {
        _savedComics.remove(comic);
      } else {
        _savedComics.add(comic);
      }
    });
  }

  void _getNextComics() {
    if (_numComics == 0) {
      _fetchInitData();
    }
    var comicsToFetch = <int>[];
    for (int i = _numComics - _fetchedComics.length;
        i > (_numComics - _fetchedComics.length) - batchSize;
        i--) {
      comicsToFetch.add(i);
    }
    httpService.getComicBatch(comicsToFetch).then((res) {
      setState(() {
        _fetchedComics.addAll(res);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('XKCD Comic Viewer'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/favourites',
                  arguments: _savedComics,
                );
              },
            )
          ],
        ),
        body: _buildList());
  }
}
