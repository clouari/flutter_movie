import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://media.istockphoto.com/photos/snowman-picture-id1292222795?b=1&k=20&m=1292222795&s=170667a&w=0&h=59WU1zFxTydh8hk48uo4vpuGv2Lm_9w3d3Ev5TARwR4='),
                  radius: 40.0,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('ToDo'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Drawer 연습하기'),
      ),
      body: const Center(
        child: Text('강의보고 연습 해 보기'),
      ),
    );
  }
}
