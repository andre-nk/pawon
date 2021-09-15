part of "services.dart";

class UserService{
  CollectionReference userReference = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    try {
      userReference.doc(user.uid).set({
        'name': user.name,
        'email': user.email,
        'history': user.history,
        'plans': user.plans,
        'recipes': user.recipes
      });
    } catch (e) {
      throw e;
    }
  }
}