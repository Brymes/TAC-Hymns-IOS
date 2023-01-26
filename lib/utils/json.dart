import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tac_hymns_ios/models/hymns_model.dart';

Future<Box<Hymn>> readHymns() async {
  // obtain shared preferences
  final prefs = await SharedPreferences.getInstance();
  Box<Hymn> box = await Hive.openBox<Hymn>('hymnsBox');
  print("working");

  final isLoaded = prefs.getBool('loaded') ?? false;

  if (isLoaded == false) {
    final String response =
        await rootBundle.loadString('assets/hymns_202301241052.json');
    final List<dynamic> data = await json.decode(response);
    print("still working");

    for (final hymn in data) {
      box.put(hymn["_id"], Hymn.fromJson(hymn));
    }
    print("done");
    print(box.length);
    await prefs.setBool('loaded', true);
  }

  return box;
}
