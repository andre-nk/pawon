import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawon/models/models.dart';
import 'package:pawon/services/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with HydratedMixin {
  AuthCubit() : super(AuthInitial());

  void signUp({required String name, required String email, required String password}) async {
    try {
      emit(AuthLoading());

      if (name.isEmpty){
        emit(AuthFailed("Please enter you name firstly"));
      } else if(email.indexOf("@") < 0 || email.isEmpty){
        emit(AuthFailed("Please enter a proper e-mail address"));
      } else if(password.length == 0){
        emit(AuthFailed("Please enter your password before sign up"));
      } else if(password.length < 6){
        emit(AuthFailed("Your password must be more than 5 characters"));
      } else {  
        UserModel user = await AuthService().signUp(email: email, name: name, password: password);
        emit(AuthSuccess(user));
      }

    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());

      if(email.indexOf("@") < 0 || email.isEmpty){
        emit(AuthFailed("Please enter a proper e-mail address"));
      } else if(password.length == 0){
        emit(AuthFailed("Please enter your password to log in"));
      } else if(password.length < 6){
        emit(AuthFailed("Your password must be more than 5 characters"));
      } else {
        UserModel user = await AuthService().signIn(email: email, password: password);
        emit(AuthSuccess(user));
      }

    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signInWithGoogle() async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signUpWithGoogle();
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(NotAuthenticated());
    } catch (e){
      emit(AuthFailed(e.toString()));
    }
  }

  void signOutWithGoogle() async {
    try {
      emit(AuthLoading());
      await AuthService().signOutWithGoogle();
      emit(NotAuthenticated());
    } catch (e){
      emit(AuthFailed(e.toString()));
    }
  }

  void resetPassword(String email) async {
    try {
      emit(AuthLoading());

      if(email.indexOf("@") < 0 || email.isEmpty){
        emit(AuthFailed("Please enter a proper e-mail address"));
      } else {
        await AuthService().resetPassword(email);
        emit(PasswordResetSent());
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getUserById(String id) async {
    try {
      emit(AuthLoading());
      UserModel user = await UserService().getUserById(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void changeDisplayName(String name) async {
    try {
      emit(AuthLoading());
      UserModel user = await UserService().changeDisplayName(name);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void changeProfilePicture(ImageSource source) async {
    try {
      emit(AuthLoading());
      XFile? _result = await ImageService().pickImage(source);
      if(_result != null){
        UserModel user = await UserService().changeProfilePicture(_result);
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailed("You've cancel the image picking process"));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      if(json["status"] != null){
        return NotAuthenticated();
      } else {
        final userModel = UserModel.fromJson(json);
        return AuthSuccess(userModel);
      }
    } catch (e) {
      return AuthFailed(e.toString());
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if(state is AuthSuccess){
      return state.user.toJson(state.user);
    } else if (state is NotAuthenticated) {
      return {
        "status": "Not Authenticated"
      };
    } else {
      return {
        "status": null
      };
    }
  }
}
