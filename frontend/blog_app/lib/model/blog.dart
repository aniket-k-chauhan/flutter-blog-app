import 'dart:ffi';

class BlogModel {
  int? id;
  String? title;
  String? description;
  String? author;

  BlogModel({this.id, this.title, this.description, this.author});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['author'] = this.author;
    return data;
  }
}
