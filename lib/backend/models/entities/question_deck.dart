/// id : "6341f2016a20a27fc66490ee"
/// userId : "6341f1e06a20a27fc66490ed"
/// name : "Kahoot"
/// createdAt : "2022-10-08T21:56:17.468Z"
/// updatedAt : "2022-10-08T21:56:17.468Z"

class QuestionDeck {
  QuestionDeck({
      this.id, 
      this.userId, 
      this.name, 
      this.createdAt, 
      this.updatedAt,});

  QuestionDeck.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? userId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['name'] = name;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}