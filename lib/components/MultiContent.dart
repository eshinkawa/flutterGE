import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class MultiContent extends StatefulWidget {
  MultiContent({@required this.data});
  final data;
  @override
  MultiContentState createState() => new MultiContentState();
}

class MultiContentState extends State<MultiContent> {
  @override
  var content = {};
  var url =
      'http://falkor-cda.bastian.globo.com/feeds/93a4eb4b-8a93-4c09-b080-4ba92a01d142/posts/ssi';

  String baseRawUrl = 'http://globoesporte.globo.com/globo/raw/';

  Future<Null> fetchFeed(url) async {
    var response = await http.get(url);
    var result = json.decode(response.body);
    var content = result;
    setState(() {
      this.content = content;
    });
    print(content);
  }

  changeStatusColor(Color color) async {
    await FlutterStatusbarcolor.setStatusBarColor(color);
  }

  @override
  void initState() {
    super.initState();
    this.changeStatusColor(Color(0xFF3b9c00));
    var pageUrl = baseRawUrl + widget.data['content']['url'];
    this.fetchFeed(pageUrl);
  }

  listOfBlocks() {
    var blocks = widget.data['resource']['bodyData']['blocks'];
    List<Widget> widgets = blocks.map((item) => Text(item)).toList();
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: Scaffold(
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
                leading: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left, size: 35.0),
                    onPressed: () {
                      Navigator.pop(context, true);
                    }),
                title: Text(content['header']['editoria']['label'],
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.5,
                      height: 0.9,
                      color: Colors.black87,
                    )),
                centerTitle: true,
                actions: <Widget>[
                  Icon(Icons.share),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 28.0),
                            child: Text(
                              content['resource']['title'],
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -1.8,
                                  height: 0.9),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 28.0),
                            child: Text(
                              content['resource']['subtitle'],
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -1.0,
                                  height: 0.9),
                            ),
                          ),
                          ListView.builder(
                            itemCount: content['resource']['bodyData']['blocks']
                                .length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(content['resource']['bodyData']
                                    ['blocks'][index]['text']),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          onRefresh: () {},
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
