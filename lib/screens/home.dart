import "package:flutter/material.dart";
import "package:tac_hymns_ios/screens/hymn_view.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.hymnCount});

  final int hymnCount;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void switchLang(bool isYoruba) => yorubaState = isYoruba;

  late bool yorubaState;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const SliverAppBar(
                  title: Text("TAC Hymns IOS"),
                  bottom: TabBar(
                    labelPadding: EdgeInsets.all(15),
                    tabs: [
                      Text("ENGLISH VERSION"),
                      Text("YORUBA VERSION"),
                    ],
                  ),
                  floating: true,
                  expandedHeight: 80,
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              HymnsList(hymnCount: widget.hymnCount, isYoruba: false),
              HymnsList(hymnCount: widget.hymnCount, isYoruba: true),
            ],
          ),
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          tooltip: "Increment",
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HymnsList extends StatelessWidget {
  const HymnsList({super.key, required this.hymnCount, required this.isYoruba});

  final int hymnCount;
  final bool isYoruba;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text("${index + 1}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HymnScreen(hymnNo: index + 1, isYoruba: isYoruba),
                  ),
                );
              },
            ),
            childCount: hymnCount,
          ),
        )
      ],
    );
  }
}
