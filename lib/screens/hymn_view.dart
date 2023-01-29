import "package:flutter/material.dart";
import "package:flutter_html/flutter_html.dart";
import "package:tac_hymns_ios/models/hymns_model.dart";

class HymnScreen extends StatelessWidget {
  const HymnScreen({super.key, required this.hymn, required this.isYoruba});

  final Hymn hymn;
  final bool isYoruba;

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
                            "${hymn.hymnNo}. ${isYoruba ? hymn.yorubaBibleText! : hymn.bibleText!}",
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
                              isYoruba
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
                title:
                    Html(data: isYoruba ? hymn.yoruba : hymn.english, style: {
                  //FIXME Messy and Jank Fix with the styling, Had to edit the JSON to have uniform rendering
                  "html": Style(
                    fontSize: FontSize.xLarge,
                    fontFamily: "Bookman Old Style",
                  ),
                }),
              ),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
