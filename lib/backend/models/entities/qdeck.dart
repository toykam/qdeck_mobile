import 'package:khoot/backend/models/entities/question_model.dart';

/// id : "6341f2016a20a27fc66490ee"
/// userId : "6341f1e06a20a27fc66490ed"
/// name : "Kahoot"
/// createdAt : "2022-10-08T21:56:17.468Z"
/// updatedAt : "2022-10-08T21:56:17.468Z"
/// questions : [{"id":"6341f2146a20a27fc66490ef","kahootId":"6341f2016a20a27fc66490ee","question":"Hello how are you?","option1":"yes","option2":"no","option3":"maybe","option4":"lol","answer":"lol","questionType":"YesNo","questionTime":10,"createdAt":"2022-10-08T21:56:36.714Z","updatedAt":"2022-10-08T21:56:36.714Z"}]

class Qdeck {
  Qdeck({
      this.id, 
      this.userId, 
      this.name, 
      this.createdAt, 
      this.updatedAt, 
      this.questions,});

  Qdeck.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions?.add(QuestionModel.fromJson(v));
      });
    }
  }
  String? id;
  String? userId;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<QuestionModel>? questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['name'] = name;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    if (questions != null) {
      map['questions'] = questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
