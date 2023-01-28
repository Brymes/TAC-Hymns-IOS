import "package:hive_flutter/hive_flutter.dart";

part "hymns_model.g.dart";

@HiveType(typeId: 0)
class Hymn {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? hymnNo;

  @HiveField(2)
  int? category;

  @HiveField(3)
  String? title;

  @HiveField(4)
  String? bibleText;

  @HiveField(5)
  String? english;

  @HiveField(6)
  String? yorubaTitle;

  @HiveField(7)
  String? yorubaBibleText;

  @HiveField(8)
  String? yoruba;

  @HiveField(9)
  String? strectitle;

  @HiveField(10)
  String? stryctitle;

  Hymn(
      {this.id,
      this.hymnNo,
      this.category,
      this.title,
      this.bibleText,
      this.english,
      this.yorubaTitle,
      this.yorubaBibleText,
      this.yoruba,
      this.strectitle,
      this.stryctitle});

  Hymn.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    hymnNo = json["hymnNo"];
    category = json["category"];
    title = json["title"];
    bibleText = json["bibleText"];
    english = json["english"];
    yorubaTitle = json["yorubaTitle"];
    yorubaBibleText = json["yorubaBibleText"];
    yoruba = json["yoruba"];
    strectitle = json["strectitle"];
    stryctitle = json["stryctitle"];
  }
}
