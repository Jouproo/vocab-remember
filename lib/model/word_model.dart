class WordModel {

  String ? name;
  String ? uId;
  String ? dateTime;
  String ? wordText;
  String ? definitionText;
  bool ? isFavorite ;
  String ? level ;
  String ? session ;

  WordModel({
    this.name,
    this.isFavorite,
    this.uId,
    this.wordText,
    this.dateTime,
    this.definitionText,
    this.level,
    this.session
  });

  WordModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    uId = json['uId'];
    wordText = json['text'];
    definitionText = json['definitionText'];
    dateTime = json['dateTime'];
    isFavorite = json['isFavorite'];
    level = json['level'];
    session = json['session'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uId' : uId,
      'text':wordText,
      'dateTime' : dateTime,
      'definitionText' : definitionText ,
      'isFavorite' : isFavorite ,
      'session': session,
      'level' : level,
    };
  }





}