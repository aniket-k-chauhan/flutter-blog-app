class BlogModel {
  int? id;
  String? title;
  String? description;
  String? authorName;
  String? authorEmail;
  String? updatedAt;

  BlogModel({
    this.id,
    this.title,
    this.description,
    this.authorName,
    this.authorEmail,
    this.updatedAt,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    authorName = json['authorName'];
    authorEmail = json['authorEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['authorName'] = this.authorName;
    data['authorEmail'] = this.authorEmail;
    return data;
  }
}
