import 'dart:convert';

class ItemModel {
  String? by;
  int? descendants;
  int? id;
  bool? deleted;
  bool? dead;
  int? parent;
  List<dynamic>? kids;
  int? score;
  int? time;
  String? title;
  String? type;
  String? url;
  String? text;

  ItemModel(
      {this.by,
      this.descendants,
      this.id,
      this.deleted,
      this.dead,
      this.parent,
      this.kids,
      this.score,
      this.time,
      this.title,
      this.type,
      this.url,
      this.text});

  ItemModel.fromJson(Map<String, dynamic> json) {
    by = json['by'] ?? 'delete';
    descendants = json['descendants'] ?? 0;
    id = json['id'];
    deleted = json['deleted'] ?? false;
    dead = json['dead'] ?? false;
    parent = json['parent'];
    kids = json['kids'] ?? [];
    score = json['score'];
    time = json['time'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    text = json['text'] ?? '';
  }

  ItemModel.fromDb(Map<String, dynamic> json) {
    by = json['by'];
    descendants = json['descendants'];
    id = json['id'];
    deleted = json['deleted'] == 1; // true if one and false if else.
    dead = json['dead'] == 1;
    parent = json['parent'];
    kids = jsonDecode(json['kids']);
    score = json['score'];
    time = json['time'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['descendants'] = this.descendants;
    data['id'] = this.id;
    data['deleted'] = this.deleted;
    data['dead'] = this.dead;
    data['parent'] = this.parent;
    data['kids'] = this.kids;
    data['score'] = this.score;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }

  Map<String, dynamic> toDb() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['descendants'] = this.descendants;
    data['id'] = this.id;
    data['deleted'] = this.deleted == true ? 1 : 0;
    data['dead'] = this.dead == true ? 1 : 0;
    data['parent'] = this.parent;
    data['kids'] = jsonEncode(this.kids);
    data['score'] = this.score;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }
}
