part of "services.dart";

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();

  Future<UserModel> signUp({
    required String email,
    required String name,
    required String password
  }) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
        password: password,
        history: [],
        plans: [],
        recipes: []
      );
      _auth.currentUser!.updateDisplayName(name);
      await UserService().createUser(user);
      return user;
    } catch (e){
      throw e;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: userCredential.user!.displayName ?? "",
        password: password,
        history: [],
        plans: [],
        recipes: []
      );
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> signUpWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await _googleAuth.signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken
      );

      UserCredential userCredential = await _auth.signInWithCredential(credentials);
      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email ?? "",
        name: userCredential.user!.displayName ?? "",
        password: "",
        history: [],
        plans: [],
        recipes: []
      );
      
      await UserService().createUser(user);
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOutWithGoogle() async {
    try {
      await _googleAuth.disconnect();
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }
}