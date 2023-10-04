class ContactModel {
  String? email;
  String? title;
  String? description;

  ContactModel({this.email, this.title, this.description});

  ContactModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
