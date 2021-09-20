part of 'recipe_cubit.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeCreated extends RecipeState {}

class RecipeCoverPicked extends RecipeState {
  final XFile pickedCover;
  RecipeCoverPicked(this.pickedCover);

  @override
  List<Object> get props => [pickedCover];
}

class RecipeLoaded extends RecipeState {
  final Stream<List<RecipeModel>> recipes;
  RecipeLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RecipeFailed extends RecipeState {
  final String error;
  RecipeFailed(this.error);

  @override
  List<Object> get props => [error];
}