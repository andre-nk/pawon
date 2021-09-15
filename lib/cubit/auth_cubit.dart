import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pawon/models/models.dart';
import 'package:pawon/services/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
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
      } else if(password.length <= 6){
        emit(AuthFailed("Your password must be more than 6 characters"));
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
      } else if(password.length <= 6){
        emit(AuthFailed("Your password must be more than 6 characters"));
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
}
