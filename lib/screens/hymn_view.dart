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
        slivers: [
          const SliverAppBar(
            title: Text("Hymn View"),
            floating: true,
            expandedHeight: 60,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Text(
                            "${hymn.id}. ${widget.isYoruba ? hymn.yorubaBibleText! : hymn.bibleText!}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // you can opt to remove the shrink
                        SizedBox(
                          child: Text(
                              widget.isYoruba
                                  ? hymn.yorubaBibleText!
                                  : hymn.bibleText!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 16)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Html(
                  data: widget.isYoruba ? hymn.yoruba : hymn.english,
                ),
              ),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
