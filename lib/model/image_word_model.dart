
class ImageWordModel {

  String ? name;
  String ? uId;
  String ? dateTime;
  String ? definitionText;
  String ? level ;
  String ? session ;
  String ? wId;
  String ? image;
  String ? wordImage;

  ImageWordModel({
    this.name,
    this.uId,
    this.dateTime,
    this.definitionText,
    this.level,
    this.session,
    this.wId,
    this.image,
    this.wordImage
  });

  ImageWordModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    uId = json['uId'];
    wId = json['wId'];
    definitionText = json['definitionText'];
    dateTime = json['dateTime'];
    level = json['level'];
    session = json['session'];
    image = json['image'];
    wordImage = json['wordImage'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uId' : uId,
      'dateTime' : dateTime,
      'definitionText' : definitionText ,
      'session': session,
      'level' : level,
      'wId':wId,
      'image':image,
      'wordImage':wordImage
    };
  }







}