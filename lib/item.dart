import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final Map map;

  Item({Key key, this.map}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('context'),
      ),
    );
  }
}