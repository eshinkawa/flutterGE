import 'package:flutter/material.dart';

class RegularCard extends StatelessWidget {
  RegularCard(
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
    var borderTopFirstItem = index == 0 ? 1.3 : 13.0;

    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              top:
                  BorderSide(color: Colors.black12, width: borderTopFirstItem)),
        ),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            margin: data['content']['chapeu']['label'].length > 0
                ? const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0)
                : null,
            child: Text(
              data['content']['chapeu']['label'],
              style: TextStyle(
                fontSize: 15.3,
                color: Color(0xFF000000),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 10.0),
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
            margin: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
            child: Text(
              data['content']['summary'],
              style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFF555555),
                letterSpacing: -0.8,
              ),
            ),
          ),
          Image.network(data['content']['image']['sizes']['M']['url'],
              fit: BoxFit.cover),
          Container(
            margin: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
            child: Text(
              'Há $diff horas — Em ${data['content']['section']}',
              style: TextStyle(fontSize: 11.0, color: Color(0xFF555555)),
            ),
          ),
        ]),
      ),
    );
  }
}
