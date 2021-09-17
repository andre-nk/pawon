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
        'recipes': user.recipes,
        'profileURL': user.profileURL != "" ? user.profileURL : ""
      });
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await userReference.doc(id).get();
      return UserModel(
        uid: id,
        password: "",
        name: snapshot["name"],
        email: snapshot["email"],
        profileURL: snapshot["profileURL"],
        recipes: snapshot["recipes"].cast<String>(),
        plans: snapshot["plans"].cast<String>(),
        history: snapshot["history"].cast<String>()
      );
    } catch (e) {
      throw e;
    }
  }
}