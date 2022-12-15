
class Contact{
  final int? id;
  final String name;
  final String number;
  final String? email;
  final String? imgPath;

  Contact({this.id, required this.name,required this.number, this.email,this.imgPath,});

  factory Contact.fromMap(Map<String,dynamic>json)=> Contact(
    id:json['id'],
    name:json['name'],
    number:json['number'],
    email:json['email'],
    imgPath:json['imgPath'],
  );

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'number':number,
      'email':email,
      'imgPath':imgPath,

    };
  }
}