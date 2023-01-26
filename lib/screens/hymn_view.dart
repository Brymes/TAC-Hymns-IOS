import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive/hive.dart';
import 'package:tac_hymns_ios/models/hymns_model.dart';

class HymnScreen extends StatefulWidget {
  const HymnScreen({super.key, required this.hymnNo, required this.isYoruba});

  final int hymnNo;
  final bool isYoruba;

  @override
  State<HymnScreen> createState() => _HymnScreenState();
}

class _HymnScreenState extends State<HymnScreen> {
  late Hymn hymn;

  @override
  void initState() {
    super.initState();
    Box<Hymn> box = Hive.box('hymnsBox');
    hymn = box.get(widget.hymnNo) ?? Hymn();
    print("#" * 100);
    print(widget.hymnNo);
    print(box.length);
    print(hymn.title);
    print("#" * 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // Add the app bar and list of items as slivers in the next steps.
        slivers: [
          // Add the app bar to the CustomScrollView.
          const SliverAppBar(
            // Provide a standard title.
            title: Text("Hymn View"),
            // Allows the user to reveal the app bar if they begin scrolling
            // back up the list of items.
            floating: true,
            // Display a placeholder widget to visualize the shrinking size.
            flexibleSpace: Placeholder(),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Html(
                data: widget.isYoruba ? hymn.yoruba : hymn.english,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
