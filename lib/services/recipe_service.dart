part of "services.dart";

class RecipeService{
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference recipesReference = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('recipes');

  Future<void> createRecipe({
    required String id,
    String? coverURL,
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
      recipesReference.doc(id).set({
        "coverURL": coverURL,
        "title": title,
        "description": description ?? "",
        "ingredients": ingredients,
        "instructionDescription": instructionDescription ?? "",
        "instructionSteps": instructionSteps,
        "servings": servings ?? "",
        "prepsTime": prepsTime ?? "",
        "cookTime": cookTime ?? "",
        "cookedTime": 0
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateRecipe({
    required String id,
    String? coverURL,
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
      recipesReference.doc(id).update({
        "coverURL": coverURL,
        "title": title,
        "description": description ?? "",
        "ingredients": ingredients,
        "instructionDescription": instructionDescription ?? "",
        "instructionSteps": instructionSteps,
        "servings": servings ?? "",
        "prepsTime": prepsTime ?? "",
        "cookTime": cookTime ?? "",
      });
    } catch (e) {
      throw e;
    }
  }

  Stream<List<RecipeModel>> fetchRecipes(){
    try {
      final snapshot = recipesReference.snapshots().map((recipeList){
        return recipeList.docs.map((recipe){
          return RecipeModel.fromJson(
            recipe.id,
            recipe.data() as Map<String, dynamic>);
          }
        ).toList(); 
      });
      return snapshot;
    } catch (e) {
      throw e;
    }
  }
}