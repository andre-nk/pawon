part of "models.dart";

class UserModel extends Equatable{

  final String uid;
  final String name;
  final String email;
  final String password;
  final List<String> plans;
  final List<String> history;
  final List<String> recipes;

  UserModel({
    required this.uid, 
    required this.password,
    required this.name,
    required this.email,
    this.plans = const [],
    this.history = const [],
    this.recipes = const []
  });

  @override
  List<Object?> get props => [uid, password, name, plans, history, recipes];

}