part of "services.dart";

class RecipeService{
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference recipesReference = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('recipes');

  Future<void> createRecipe({
    XFile? cover,
    required String title,
    String? description,
    required List<Map<String, String>> ingredients,
    String? instructionDescription,
    required List<String> instructionSteps,
    String? servings,
    String? prepsTime,
    String? cookTime
  }) async {
    try {
      recipesReference.doc().set({
        "coverURL": cover,
        "title": title,
        "description": description ?? "",
        "ingredients": ingredients,
        "instructionDescription": instructionDescription ?? "",
        "instructionSteps": instructionSteps,
        "servings": servings ?? "",
        "prepsTime": prepsTime ?? "",
        "cookTime": cookTime ?? ""
      });
    } catch (e) {
      throw e;
    }
  }
}