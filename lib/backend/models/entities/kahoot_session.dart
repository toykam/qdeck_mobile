/// id : "6341f4edef779d1b6e627773"
/// kahootId : "6341f2016a20a27fc66490ee"
/// userId : "6341f1e06a20a27fc66490ed"
/// code : "365155"
/// status : "Waiting"
/// createdAt : "2022-10-08T22:08:45.414Z"
/// updatedAt : "2022-10-08T22:08:45.414Z"

class KahootSession {
  KahootSession({
      this.id, 
      this.kahootId, 
      this.userId, 
      this.code, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  KahootSession.fromJson(dynamic json) {
    id = json['id'];
    kahootId = json['kahootId'];
    userId = json['userId'];
    code = json['code'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? kahootId;
  String? userId;
  String? code;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['kahootId'] = kahootId;
    map['userId'] = userId;
    map['code'] = code;
    map['status'] = status;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}