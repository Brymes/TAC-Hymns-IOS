// main.dart
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hive/hive.dart";

import "../models/hymns_model.dart";
import "hymn_view.dart";

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.isYoruba});

  final bool isYoruba;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Iterable<dynamic> hymns;
  late Iterable<dynamic> allHymns;

  @override
  void initState() {
    Box<Hymn> box = Hive.box("hymnsBox");
    allHymns = box.values;
    hymns = allHymns;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    Iterable<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we"ll display all users
      results = allHymns;
    } else {
      results = hymns
          .where((hymn) =>
              hymn.hymnNo.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      hymns = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BackButton(
                //   key: const ValueKey("ReplyExit"),
                //   onPressed: () {
                //     Provider.of<EmailStore>(
                //       context,
                //       listen: false,
                //     ).onSearchPage = false;
                //   },
                // ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration.collapsed(
                      hintText: "Search hymn",
                    ),
                    onChanged: (value) => _runFilter(value),
                  ),
                ),
                const Icon(Icons.search_outlined)
              ],
            ),
          ),
        ),
        body: hymns.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(
                        title: Text("${hymns.elementAt(index).hymnNo}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HymnScreen(
                                  hymn: hymns.elementAt(index),
                                  isYoruba: widget.isYoruba),
                            ),
                          );
                        },
                      ),
                      childCount: hymns.length,
                    ),
                  )
                ],
              )
            : const Center(
                child: Text(
                  "No results found",
                  style: TextStyle(fontSize: 24),
                ),
              ));
  }
}
