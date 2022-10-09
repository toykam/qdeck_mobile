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
        questions?.add(Questions.fromJson(v));
      });
    }
  }
  String? id;
  String? userId;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Questions>? questions;

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

/// id : "6341f2146a20a27fc66490ef"
/// kahootId : "6341f2016a20a27fc66490ee"
/// question : "Hello how are you?"
/// option1 : "yes"
/// option2 : "no"
/// option3 : "maybe"
/// option4 : "lol"
/// answer : "lol"
/// questionType : "YesNo"
/// questionTime : 10
/// createdAt : "2022-10-08T21:56:36.714Z"
/// updatedAt : "2022-10-08T21:56:36.714Z"

class Questions {
  Questions({
      this.id, 
      this.kahootId, 
      this.question, 
      this.option1, 
      this.option2, 
      this.option3, 
      this.option4, 
      this.answer, 
      this.questionType, 
      this.questionTime, 
      this.createdAt, 
      this.updatedAt,});

  Questions.fromJson(dynamic json) {
    id = json['id'];
    kahootId = json['kahootId'];
    question = json['question'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
    answer = json['answer'];
    questionType = json['questionType'];
    questionTime = json['questionTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? kahootId;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? answer;
  String? questionType;
  num? questionTime;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['kahootId'] = kahootId;
    map['question'] = question;
    map['option1'] = option1;
    map['option2'] = option2;
    map['option3'] = option3;
    map['option4'] = option4;
    map['answer'] = answer;
    map['questionType'] = questionType;
    map['questionTime'] = questionTime;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}