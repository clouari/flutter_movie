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
      appBar: AppBar(
        title: const Text('영화 정보 검색기'),
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
        return Column(
          children: [
            GestureDetector(
              child: Image.network(_movies[index].posterUrl),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        InformationScreen(movie: _movies[index]),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              _movies[index].title,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
