import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'components/FeedCard.dart';
import 'components/MultiContent.dart';
import 'components/Menu.dart';
import 'components/BottomNavigation.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  static const platform = const MethodChannel('com.example.feedflutterge');

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

  @override
  ScrollController _scrollController = new ScrollController();
  var isLoading = false;
  var feedList = [];
  var url =
      'http://falkor-cda.bastian.globo.com/feeds/93a4eb4b-8a93-4c09-b080-4ba92a01d142/posts/ssi';

  Future<Null> fetchFeed() async {
    isLoading = true;
    var response = await http.get(url);
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
            controller: _scrollController,
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
