part of "models.dart";

class RecipeModel extends Equatable{
  final String id;
  final String? coverURL;
  final String title;
  final String? description;
  final List<Map<String, dynamic>> ingredients;
  final String? instructionDescription;
  final List<String> instructionSteps;
  final String? servings;
  final String? prepsTime;
  final String? cookTime;
  final int? cookedTime;

  RecipeModel({
    required this.id,
    this.coverURL,
    required this.title,
    this.description,
    required this.ingredients,
    this.instructionDescription,
    required this.instructionSteps,
    this.cookedTime,
    this.servings,
    this.prepsTime,
    this.cookTime
  });

  @override
  List<Object?> get props => [id, coverURL, title, description, ingredients, instructionDescription, instructionDescription, servings, prepsTime, cookTime, cookedTime];

  factory RecipeModel.fromJson(String id, Map<String, dynamic> json){
    return RecipeModel(
      id: id,
      coverURL: json["coverURL"] as String,
      title: json["title"] as String,
      description: json["description"] as String?,
      ingredients: (json["ingredients"] as List<dynamic>).cast<Map<String, dynamic>>(),
      instructionDescription: json["instructionDescription"] as String?,
      instructionSteps: (json["instructionSteps"] as List<dynamic>).cast<String>(), 
      servings: json["servings"] as String?,
      prepsTime: json["prepsTime"] as String?,
      cookTime: json["cookTime"] as String?,
      cookedTime: json["cookedTime"] as int?
    );
  }

  Map<String, dynamic> toJson(RecipeModel recipe){
    return {
      "coverURL": recipe.coverURL,
      "title": recipe.title,
      "description": recipe.description ?? "",
      "ingredients": recipe.ingredients,
      "instructionDescription": recipe.instructionDescription ?? "",
      "instructionSteps": recipe.instructionSteps,
      "servings": recipe.servings ?? "",
      "prepsTime": recipe.prepsTime ?? "",
      "cookTime": recipe.cookTime ?? "",
      "cookedTime": recipe.cookedTime ?? 0,
    };
  }
}