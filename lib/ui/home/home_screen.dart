import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movie/data/movie_api.dart';
import 'package:flutter_movie/model/movie.dart';
import 'package:flutter_movie/ui/information/information_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> _movies = [];

  final _api = MovieApi();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showResult('');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showResult(String query) async {
    List<Movie> movies = await _api.fetchMovies(query);
    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('영화 정보 검색기'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              // reset 아이콘 눌렀을 때에는 검색페이지로 다시 돌아오게 함.
            },
            icon: const Icon(
              Icons.settings_backup_restore_outlined,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTextField(),
          Expanded(
            child: _buildGridView(),
          ),
        ],
      ),
    );
  }

  TextField _buildTextField() {
    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        suffix: IconButton(
          onPressed: () {
            _movies = _movies
                .where((e) => e.title.contains(_textEditingController.text))
                .toList();
            setState(() {});
          },
          icon: const Icon(Icons.search),
        ),
        hintText: '검색',
      ),
    );
  }

  GridView _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 5,
        childAspectRatio: 0.5,
      ),
      itemCount: _movies.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformationScreen(
                  movie: _movies[index],
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 10,
                fit: FlexFit.tight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _movies[index].posterPath.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'no image',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Image.network(
                          _movies[index].posterUrl,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: Text(
                    _movies[index].title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        overflow: TextOverflow.fade),
                  ),
                ),
              )
            ],
          ),
        );
        // return Column(
        //   children: [
        //     GestureDetector(
        //       child: Image.network(_movies[index].posterUrl),
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) =>
        //                 InformationScreen(movie: _movies[index]),
        //           ),
        //         );
        //       },
        //     ),
        //     const SizedBox(
        //       height: 10,
        //     ),
        //     Text(
        //       _movies[index].title,
        //       style: const TextStyle(
        //         fontSize: 12,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ],
        // );
      },
    );
  }
}
