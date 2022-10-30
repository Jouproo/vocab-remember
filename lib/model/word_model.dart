class WordModel {

  String ? name;
  String ? uId;
  String ? image;
  String ? dateTime;
  String ? wordText;
  String ? definitionText;
  String ? postImage;
  bool ? isFavorite ;

  WordModel({
    this.name,
    this.isFavorite,
    this.image,
    this.uId,
    this.wordText,
    this.dateTime,
    this.postImage,
    this.definitionText
  });

  WordModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    wordText = json['text'];
    definitionText = json['definitionText'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    isFavorite = json['isFavorite'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uId' : uId,
      'image':image ,
      'text':wordText,
      'dateTime' : dateTime,
      'postImage':postImage ,
      'definitionText' : definitionText ,
      'isFavorite' : isFavorite ,
    };
  }





}