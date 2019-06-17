import 'package:flutter/material.dart';

import './RegularCard.dart';
import './TempoReal.dart';
import './VideoCard.dart';

class FeedCard extends StatelessWidget {
  FeedCard(
      {@required this.index,
      @required this.onPressPlayer,
      @required this.onPress,
      @required this.data});

  final index;
  final Function onPressPlayer;
  final Function onPress;
  final data;

  @override
  Widget build(BuildContext context) {
    var regularCard = RegularCard(
      index: index,
      onPress: onPress,
      data: data,
    );

    var tempoRealCard = TempoRealCard(
      index: index,
      onPress: () {},
      data: data,
    );

    var videoCard = VideoCard(
      index: index,
      onPress: onPressPlayer,
      data: data,
    );

    if (data['type'] == 'eventos-esportivos' && data['match'] != null) {
      return tempoRealCard;
    }

    if (data['type'] == 'video') {
      return videoCard;
    }

    return regularCard;
  }
}
