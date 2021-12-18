import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieaplikasi/movie_response.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  Future<MovieResponse> fetchMovieNowPlaying() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=fa01d5f46163b78e18c1547a4719ac4a&sort_by=popularity.desc&page=1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<MovieResponse> fetchMoviePopular() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=fa01d5f46163b78e18c1547a4719ac4a&sort_by=popularity.desc&page=1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  List<Results> _movieNowPlaying = [];
  List<Results> _moviePopular= [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMovieNowPlaying().then((value) {
      if(value.results!=null){
        _movieNowPlaying.addAll(value.results!);
      }
      setState(() {
        
      });
    });
    fetchMoviePopular().then((value) {
      if(value.results!=null){
        _moviePopular.addAll(value.results!);
      }
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Popular"),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: listPopular(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Now Playing"),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _movieNowPlaying.length > 0
                        ? listNowPlaying(MediaQuery.of(context).size.height * 0.5, MediaQuery.of(context).size.width)
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listNowPlaying(double heightCard, double widhtCard) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _movieNowPlaying.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          Results movie = _movieNowPlaying[i];
          double _height = heightCard * 0.5;
          double _widht = widhtCard;
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      height: _height *0.6,
                      width: _widht,
                      child: CachedNetworkImage(
                        imageUrl:
                        'https://image.tmdb.org/t/p/w500/${movie.backdropPath}',
                        fit: BoxFit.cover,
                      )),
                  SizedBox(height: 4.0),
                  Container(
                    width: _widht,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: _widht * 50 / 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${movie.title}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  'Date Release: ${movie.releaseDate}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  movie.voteAverage.toString(),
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 20),
                                ),
                                Text(
                                  '${movie.voteCount} People Vote',
                                  style: TextStyle(fontSize: 8),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
    /*return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: 160.0,
          color: Colors.red,
        ),
        Container(
          width: 160.0,
          color: Colors.blue,
        ),
        Container(
          width: 160.0,
          color: Colors.green,
        ),
        Container(
          width: 160.0,
          color: Colors.yellow,
        ),
        Container(
          width: 160.0,
          color: Colors.orange,
        ),
      ],
    );*/
  }

  Widget listPopular() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _moviePopular.length,
        itemBuilder: (context, i) {
          Results movie = _moviePopular[i];
          double _height = (MediaQuery.of(context).size.height * 0.3) - 10;
          double _widht = (MediaQuery.of(context).size.width * 0.3);
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: _widht,
                      height: _height * 0.7,
                      child: CachedNetworkImage(
                        imageUrl:
                        'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                        fit: BoxFit.cover,
                      )),
                  SizedBox(height: 4.0),
                  Container(
                    width: _widht,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: _widht * 50 / 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${movie.title}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  movie.voteAverage.toString(),
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 20),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
    /*return ListView(
      // This next line does the trick.
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height * 0.6) * 0.5,
          color: Colors.red,
        ),
        Container(
          height: (MediaQuery.of(context).size.height * 0.6) * 0.5,
          color: Colors.blue,
        ),
        Container(
          height: (MediaQuery.of(context).size.height * 0.6) * 0.5,
          color: Colors.green,
        ),
        Container(
          height: (MediaQuery.of(context).size.height * 0.6) * 0.5,
          color: Colors.yellow,
        ),
        Container(
          height: (MediaQuery.of(context).size.height * 0.6) * 0.5,
          color: Colors.orange,
        ),
      ],
    );*/
  }
}
