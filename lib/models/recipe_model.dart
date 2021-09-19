part of "models.dart";

class RecipeModel extends Equatable{
  final String? coverURL;
  final String title;
  final String? description;
  final List<Map<String, String>> ingredients;
  final String? instructionDescription;
  final List<String> instructionSteps;
  final String? servings;
  final String? prepsTime;
  final String? cookTime;

  RecipeModel({
    this.coverURL,
    required this.title,
    this.description,
    required this.ingredients,
    this.instructionDescription,
    required this.instructionSteps,
    this.servings,
    this.prepsTime,
    this.cookTime
  });

  @override
  List<Object?> get props => [coverURL, title, description, ingredients, instructionDescription, instructionDescription, servings, prepsTime, cookTime];

  factory RecipeModel.fromJson(Map<String, dynamic> json){
    return RecipeModel(
      coverURL: json["coverURL"] as String,
      title: json["title"] as String,
      description: json["description"] as String?,
      ingredients: json["ingredients"] as List<Map<String, String>>,
      instructionDescription: json["instructionDescription"] as String?,
      instructionSteps: json["instructionSteps"] as List<String>, 
      servings: json["servings"] as String?,
      prepsTime: json["prepsTime"] as String?,
      cookTime: json["cookTime"] as String?
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
      "cookTime": recipe.cookTime ?? ""
    };
  }
}