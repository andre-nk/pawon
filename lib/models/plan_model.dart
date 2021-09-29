part of "models.dart";

class PlanModel extends Equatable{
  final String id;
  final Map<String, int> recipes;
  final DateTime dateTime;
  PlanModel({required this.id, required this.recipes, required this.dateTime});

  @override
  List<Object?> get props => [recipes, dateTime];

  factory PlanModel.fromJson(String id, Map<String, dynamic> json){
    return PlanModel(
      id: id,
      recipes: (json["recipes"] as Map<String, dynamic>).cast<String, int>(),
      dateTime: DateTime.parse(json["dateTime"]),
    );
  } 

  Map<String, dynamic> toJson(PlanModel instance){
    return {
      "id": instance.id,
      "recipeID": instance.recipes,
      "amount": instance.dateTime
    };
  }
}