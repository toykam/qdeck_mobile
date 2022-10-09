/// id : "6341f1e06a20a27fc66490ed"
/// name : "name"
/// email : "email@email.com"
/// password : "$2b$10$llQ6ImbLDRrmCkzGJKFs1.hIZ0cMiEcv68eAVVaAKO.FdqPMaLiNS"
/// createdAt : "2022-10-08T21:55:44.838Z"
/// updatedAt : "2022-10-08T21:55:44.838Z"

class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.password, 
      this.createdAt, 
      this.updatedAt,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? name;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}