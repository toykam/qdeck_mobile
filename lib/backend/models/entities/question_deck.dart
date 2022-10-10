/// id : "6342ae33de01e941c32120b0"
/// userId : "6341f1e06a20a27fc66490ed"
/// name : "Governance"
/// createdAt : "2022-10-09T11:19:15.543Z"
/// updatedAt : "2022-10-09T11:19:15.543Z"
/// user : {"name":"name"}

class QuestionDeck {
  QuestionDeck({
      this.id, 
      this.userId, 
      this.name, 
      this.createdAt, 
      this.updatedAt, 
      this.user,});

  QuestionDeck.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? id;
  String? userId;
  String? name;
  String? createdAt;
  String? updatedAt;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['name'] = name;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// name : "name"

class User {
  User({
      this.name,});

  User.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}