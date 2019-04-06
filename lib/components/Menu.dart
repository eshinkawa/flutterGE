import 'package:flutter/material.dart';
import './MultiContent.dart';

class Menu extends StatelessWidget {
  Widget menuItem(String menuTitle) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
      title: Text(menuTitle,
          style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.w100,
          )),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 90.0,
            width: 390.0,
            margin: EdgeInsets.only(bottom: 5.0),
            child: DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black12))),
            ),
          ),
          menuItem('brasileirão série a'),
          menuItem('time'),
          menuItem('tabelas'),
          menuItem('futebol internacional'),
          menuItem('agenda'),
          menuItem('vai e vem do mercado'),
          menuItem('cartola FC'),
          menuItem('mais esportes'),
          menuItem('eu atleta'),
          menuItem('combate'),
          menuItem('sportv'),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(
                color: Colors.black45,
              ))
        ],
      ),
    );
  }
}
