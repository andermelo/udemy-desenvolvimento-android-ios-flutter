class Post {
  
  int _userId;
  int _id;
  String _title;
  String _body;

  Post(this._userId, this._id, this._title, this._body);

  Map toJson(){
    return {
        "userId": this._userId,
        "id": this._id,
        "title": this._title,
        "body": this._body
      };  
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get body => _body;

  set body(String value) {
    _body = value;
  }

  int get userId => _userId;

  set uderId(int value) {
    _userId = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

}