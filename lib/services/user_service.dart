part of "services.dart";

class UserService{
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference userReference = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    try {
      userReference.doc(user.uid).set({
        'name': user.name,
        'email': user.email,
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
      );
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> changeDisplayName(String name) async {
    try {
      String id = FirebaseAuth.instance.currentUser!.uid;
      
      await userReference.doc(id).update({
        "name": name
      });

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);

      DocumentSnapshot snapshot = await userReference.doc(id).get();
      return UserModel(
        uid: id,
        name: snapshot["name"],
        email: snapshot["email"],
        profileURL: snapshot["profileURL"],
      );
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> changeProfilePicture(XFile rawImage) async {
    try {
      String id = FirebaseAuth.instance.currentUser!.uid;  

      await storage.ref('$id/profileURL').putFile(File(rawImage.path));
      String profileURL = await storage.ref('$id/profileURL').getDownloadURL();

      await userReference.doc(id).update({
        "profileURL": profileURL
      });
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(profileURL);
      
      DocumentSnapshot snapshot = await userReference.doc(id).get();
      return UserModel(
        uid: id,
        name: snapshot["name"],
        email: snapshot["email"],
        profileURL: snapshot["profileURL"],
      );
    } catch (e) {
      throw e;
    }
  }
}