import 'package:flutter/material.dart';

class TempoRealCard extends StatelessWidget {
  TempoRealCard(
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

    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.black12, width: borderTopFirstItem)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          margin: EdgeInsets.fromLTRB(
              data['match']['status'] == 'Em Andamento' ? 24.0 : 0.0,
              data['match']['status'] == 'Em Andamento' ? 24.0 : 0.0,
              data['match']['status'] == 'Em Andamento' ? 244.0 : 0.0,
              0.0),
          child: data['match']['status'] == 'Em Andamento'
              ? Container(
                  child: Text("Tempo Real",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.green),
                  padding: EdgeInsets.all(4.1),
                )
              : Container(
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
        ),
        Container(
          margin: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                    child: Text(
                      data['match'] == null
                          ? ''
                          : data['match']['homeTeam']['shortName'],
                      style: TextStyle(fontSize: 16.0, color: Colors.black45),
                    ),
                  ),
                  Image.network(
                    data['match'] == null
                        ? ''
                        : (data['match']['homeTeam']['crest']),
                    height: 34.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                    child: Text(
                      data['match'] == null
                          ? ''
                          : data['match']['homeTeam']['score'].toString(),
                      style: TextStyle(
                          fontSize: 23.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text(
                      'x',
                      style: TextStyle(fontSize: 15.0, color: Colors.black45),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      data['match'] == null
                          ? ''
                          : data['match']['awayTeam']['score'].toString(),
                      style: TextStyle(
                          fontSize: 23.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.network(
                    data['match'] == null
                        ? ''
                        : (data['match']['awayTeam']['crest']),
                    height: 34.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                    child: Text(
                      data['match'] == null
                          ? ''
                          : data['match']['awayTeam']['shortName'],
                      style: TextStyle(fontSize: 16.0, color: Colors.black45),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(24.0, 6.0, 24.0, 0.0),
            child: Divider(
              color: Colors.black26,
            )),
        Container(
          margin: data['match']['status'] == 'Em Andamento'
              ? null
              : EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 6.0),
          child: data['match']['status'] == 'Em Andamento'
              ? null
              : Text(
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
          margin: data['match']['status'] == 'Em Andamento'
              ? const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0)
              : null,
          child: data['match']['status'] == 'Em Andamento'
              ? Text(
                  '${data['match']['highlights'][0]['time']}" - ${data['match']['highlights'][0]['half']} ${data['match']['highlights'][0]['title']}',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Color(0xFF555555),
                    letterSpacing: -0.8,
                  ),
                )
              : null,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
          child: Text(
            data['match']['highlights'][0]['text'],
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
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
          margin: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
          child: Text(
            data['match']['status'] == 'Em Andamento'
                ? '${data['match']['spectators'].toString()} assistindo'
                : 'Há $diff horas — Em ${data['content']['section']}',
            style: TextStyle(fontSize: 11.0, color: Color(0xFF555555)),
          ),
        ),
      ]),
    );
  }
}
