import 'package:bloc/bloc.dart';
import 'package:pawon/models/models.dart';


class RecipePickerCubit extends Cubit<List<String>> {
  RecipePickerCubit() : super([]);

  void selectRecipe(RecipeModel model){
    if(!isSelected(model)){
      state.add(model.id);
    } else {
      state.remove(model.id);
    }

    print(state);
    emit(state);
  }

  bool isSelected(RecipeModel model){
    int index = state.indexOf(model.id);
    if(index == -1){
      print("Not Selected");
      return false;
    } else {
      print("Selected");
      return true;
    }
  }
}
