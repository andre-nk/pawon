part of "models.dart";

class PlanModel extends Equatable{
  final List<String> recipeIDs;
  final DateTime dateTime;

  PlanModel({required this.recipeIDs, required this.dateTime});

  @override
  List<Object?> get props => [recipeIDs, dateTime];
}