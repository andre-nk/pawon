part of "models.dart";

class UserModel extends Equatable{

  final String uid;
  final String name;
  final String email;
  final String password;
  final String profileURL;

  UserModel({
    required this.uid, 
    required this.name,
    required this.email,
    this.password = "",
    this.profileURL = "",
  });

  @override
  List<Object?> get props => [uid, password, name, email, profileURL];

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      uid: json["uid"] as String,
      name: json["name"] as String,
      email: json["email"] as String,
      profileURL: json["profileURL"] as String,
      password: json["password"] as String,
    );
  } 

  Map<String, dynamic> toJson(UserModel instance){
    return {
      "uid": instance.uid,
      "name": instance.name,
      "email": instance.email,
      "profileURL": instance.profileURL,
      "password": instance.password,
    };
  }
}