import 'dart:convert';
import 'dart:io';

class Hymn {
  int? id;

  String? hymnNo;
  int? category;
  String? title;
  String? bibleText;
  String? english;
  String? yorubaTitle;
  String? yorubaBibleText;
  String? yoruba;
  String? strectitle;
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
    id = json['_id'];
    hymnNo = json['hymnNo'];
    category = json['category'];
    title = json['title'];
    bibleText = json['bibleText'];
    english = json['english'];
    yorubaTitle = json['yorubaTitle'];
    yorubaBibleText = json['yorubaBibleText'];
    yoruba = json['yoruba'];
    strectitle = json['strectitle'];
    stryctitle = json['stryctitle'];
  }
}

Future<void> readJson() async {
  final String response = await File("hymns_202301241052.json").readAsString();
  final List<dynamic> data = await json.decode(response);
  // final payload = data["hymns"];
  Hymn dt = Hymn.fromJson(data[0]);
  print(dt);
  print(dt.yoruba);
}

void main() {
  readJson();
}
