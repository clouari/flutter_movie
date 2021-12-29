import 'package:flutter/material.dart';
import 'package:flutter_movie/model/new_page.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('clou_ari0630'),
      accountEmail: Text('ekdudekgml35@naver.com'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
            'https://media.istockphoto.com/photos/snowman-picture-id1292222795?b=1&k=20&m=1292222795&s=170667a&w=0&h=59WU1zFxTydh8hk48uo4vpuGv2Lm_9w3d3Ev5TARwR4='),
      ),
      otherAccountsPictures: <Widget>[
        CircleAvatar(
          child: Icon(
            Icons.task_alt_outlined,
          ),
        ),
        CircleAvatar(
            child: Icon(
          Icons.favorite_outlined,
        ))
      ],
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: const Text('Page 1'),
          onTap: () => Navigator.of(context).push(NewPage(1)),
        ),
        ListTile(
          title: const Text('Page2'),
          onTap: () => Navigator.of(context).push(NewPage(2)),
        ),
        ListTile(
          title: const Text('Page3'),
          onTap: () => Navigator.of(context).push(NewPage(3)),
        ),
      ],
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('clouari 연습하기'),
        ),
        body: const Center(
          child: Text('옆으로 쓸면 나오게 하기!'),
        ),
        drawer: Drawer(
          child: drawerItems,
        ));
  }
}
