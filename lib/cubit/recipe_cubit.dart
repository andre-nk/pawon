import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawon/models/models.dart';
import 'package:pawon/services/services.dart';
import 'package:uuid/uuid.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(RecipeInitial());

  Future<XFile?> pickRecipeCover(ImageSource source) async {
    try {
      XFile? result = await ImageService().pickImage(source);
      if(result != null){
        emit(RecipeCoverPicked(result));
      }
    } catch (e) {
    }
  }

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
    
    String id = Uuid().v1();
    FirebaseStorage storage = FirebaseStorage.instance;
    String reference = '${FirebaseAuth.instance.currentUser!.uid}/$id';

    try {
      emit(RecipeLoading());
      if(title == ""){
        emit(RecipeFailed("Please type this recipe's title"));
      } else if (ingredients == []){
        emit(RecipeFailed("Please create at least one ingredient"));
      } else if (instructionSteps == []){
        emit(RecipeFailed("Please create at least one instruction step"));
      } else {
        if(cover != null){
          print("A");
          await storage.ref(reference).putFile(File(cover.path));
          String coverURL = await storage.ref(reference).getDownloadURL();
          await RecipeService().createRecipe(
            id: id,
            coverURL: coverURL,
            title: title,
            description: description,
            ingredients: ingredients,
            instructionDescription: instructionDescription,
            instructionSteps: instructionSteps,
            servings: servings,
            prepsTime: prepsTime,
            cookTime: cookTime
          );
          emit(RecipeCreated());
        } else {
          print("B");
          await RecipeService().createRecipe(
            id: id,
            coverURL: "",
            title: title,
            description: description,
            ingredients: ingredients,
            instructionDescription: instructionDescription,
            instructionSteps: instructionSteps,
            servings: servings,
            prepsTime: prepsTime,
            cookTime: cookTime
          );
          emit(RecipeCreated());
        }
      }
    } catch (e) {
      emit(RecipeFailed(e.toString()));
    }
  }
}
