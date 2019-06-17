import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:http/http.dart' as http;

import 'components/BottomNavigation.dart';
import 'components/FeedCard.dart';
import 'components/Menu.dart';
import 'components/MultiContent.dart';

class App extends StatefulWidget {
  final String apiEndpoint;
  App({this.apiEndpoint});

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  static const platform = const MethodChannel('com.example.feedflutterge');

  bool isLoading = false;
  var feedList = [];

  Future<Null> showPlayer(data) async {
    var videoId = data['content']['video']['id'];
    await platform.invokeMethod('showPlayer', {"videoId": videoId});
  }

  navigate(context, multicontentData) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MultiContent(data: multicontentData)),
    );
  }

  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<Null> fetchFeed() async {
    isLoading = true;
    var response = await http.get(widget.apiEndpoint);
    var result = json.decode(response.body);
    var feedItems = result['items'];
    setState(() {
      isLoading = false;
      this.feedList = feedItems;
    });
  }

  @override
  void initState() {
    super.initState();
    this.fetchFeed();
    this.changeStatusColor(Color(0xFF3b9c00));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: Scaffold(
        drawer: Menu(),
        bottomNavigationBar: BottomNavigation(),
        body: RefreshIndicator(
          color: Colors.green,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 44.0,
                floating: true,
                pinned: false,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.blueGrey),
                elevation: 11.0,
                title: Image.asset(
                  'large-ge.png',
                  height: 34.0,
                ),
                centerTitle: true,
                actions: <Widget>[
                  Icon(Icons.search),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => FeedCard(
                          index: index,
                          onPressPlayer: () => showPlayer(this.feedList[index]),
                          onPress: () =>
                              navigate(context, this.feedList[index]),
                          data: this.feedList[index],
                        ),
                    childCount: this.feedList.length),
              )
            ],
          ),
          onRefresh: fetchFeed,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
