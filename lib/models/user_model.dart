part of "models.dart";

class UserModel extends Equatable{

  final String uid;
  final String name;
  final String email;
  final String password;
  final String profileURL;
  final List<String> plans;
  final List<String> history;
  final List<String> recipes;

  UserModel({
    required this.uid, 
    required this.name,
    required this.email,
    this.password = "",
    this.profileURL = "",
    this.plans = const [],
    this.history = const [],
    this.recipes = const []
  });

  @override
  List<Object?> get props => [uid, password, name, plans, history, recipes];

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      uid: json["uid"] as String,
      name: json["name"] as String,
      email: json["email"] as String,
      password: json["password"] as String,
      history: json["history"] as List<String>,
      recipes: json["recipes"] as List<String>,
      plans: json["plans"] as List<String>
    );
  } 

  Map<String, dynamic> toJson(UserModel instance){
    return {
      "uid": instance.uid,
      "name": instance.name,
      "email": instance.email,
      "password": instance.password,
      "history": instance.history,
      "recipes": instance.recipes,
      "plans": instance.plans,
    };
  }
}