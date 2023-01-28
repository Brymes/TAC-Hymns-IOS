import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import "package:tac_hymns_ios/screens/hymn_view.dart";
import 'package:tac_hymns_ios/screens/search.dart';

import '../models/hymns_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late bool isYoruba = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        isYoruba = _tabController.index == 0 ? false : true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
        TODO
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text("Drawer Header"),
              ),
              ListTile(
                title: const Text("Item 1"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Item 2"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),*/
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            SliverOverlapAbsorber(
              // This widget takes the overlapping behavior of the SliverAppBar,
              // and redirects it to the SliverOverlapInjector below. If it is
              // missing, then it is possible for the nested "inner" scroll view
              // below to end up under the SliverAppBar even when the inner
              // scroll view thinks it has not been scrolled.
              // This is not necessary if the "headerSliverBuilder" only builds
              // widgets that do not overlap the next sliver.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                floating: true,
                expandedHeight: 80,
                title: const Text("TAC Hymns IOS"),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(isYoruba: isYoruba),
                        ),
                      );
                    },
                  ),
                ],
                bottom: TabBar(
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(15),
                  tabs: const [
                    Text("ENGLISH VERSION"),
                    Text("YORUBA VERSION"),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            HymnsList(isYoruba: false),
            HymnsList(isYoruba: true),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: "Increment",
        child: Icon(Icons.add),
      ),
    );
  }
}

class HymnsList extends StatefulWidget {
  const HymnsList({Key? key, required this.isYoruba}) : super(key: key);

  final bool isYoruba;

  @override
  State<HymnsList> createState() => _HymnsListState();
}

class _HymnsListState extends State<HymnsList> {
  late Iterable<dynamic> hymns;

  @override
  void initState() {
    super.initState();
    Box<Hymn> box = Hive.box('hymnsBox');
    hymns = box.values;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.5))),
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
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
            ),
            childCount: hymns.length,
          ),
        )
      ],
    );
  }
}
