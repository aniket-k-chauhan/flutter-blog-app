class UserModel {
  String? name;
  String? email;
  List<String>? skills;
  List<String>? projects;
  List<String>? achievements;

  UserModel(
      {this.name, this.email, this.skills, this.projects, this.achievements});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    skills = json['skills']?.cast<String>();
    projects = json['projects']?.cast<String>();
    achievements = json['achievements']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['skills'] = skills;
    data['projects'] = projects;
    data['achievements'] = achievements;
    return data;
  }
}
