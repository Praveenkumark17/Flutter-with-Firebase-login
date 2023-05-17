import 'package:flutter/material.dart';
import 'package:dungen/models/dungen.dart';

class DungenTail extends StatelessWidget {

  final Dungen dungener;
  DungenTail({required this.dungener});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255),
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.green[dungener.strength],
          ),
          title: Text(dungener.name),
          subtitle: Text('Takes ${dungener.sugures} suger(s)'),
        ),
      ),
    );
  }
}
