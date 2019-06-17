import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  VideoCard(
      {@required this.index, @required this.onPress, @required this.data});

  final index;
  final Function onPress;
  final data;

  @override
  Widget build(BuildContext context) {
    var postDate = DateTime.parse(data['created']);
    var today = DateTime.now();
    Duration difference = today.difference(postDate);
    var diff = difference.inHours.toString();
    var borderTopFirstItem = index == 0 ? 0.0 : 13.0;

    return GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Colors.black12, width: borderTopFirstItem)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
              child: Text(
                data['content']['title'],
                style: TextStyle(
                  letterSpacing: -1.0,
                  fontSize: 20.0,
                  color: Color(0xFF3b9c00),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
                constraints: BoxConstraints.expand(
                  height: 200.0,
                ),
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        data['content']['image']['sizes']['M']['url']),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 130.0,
                      bottom: 55.0,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 80.0,
                      ),
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
              child: Text(
                'Há $diff horas — Em ${data['content']['section']}',
                style: TextStyle(fontSize: 11.0, color: Color(0xFF555555)),
              ),
            ),
          ]),
        ));
  }
}
