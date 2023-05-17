import 'package:dungen/models/dungen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dungen_tail.dart';

class DungenList extends StatefulWidget {
  const DungenList({super.key});

  @override
  State<DungenList> createState() => _DungenListState();
}

class _DungenListState extends State<DungenList> {
  @override
  Widget build(BuildContext context) {
    final dungens = Provider.of<List<Dungen?>?>(context) ?? [];
    return ListView.builder(
        itemCount: dungens.length,
        itemBuilder: (context, index) {
          final dungen = dungens.elementAt(index);
          if (dungen != null) {
            return DungenTail(dungener: dungen);
          }
        });
  }
}
