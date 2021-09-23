import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pawon/models/models.dart';
import 'package:pawon/services/services.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  PlanCubit() : super(PlanInitial());

  Future<void> createPlan({
    required List<String> recipes,
    required DateTime dateTime
  }) async {
    try {
      emit(PlanLoading());
      if(recipes == []){
        emit(PlanFailed("Please choose at least one recipe"));
      }
      await PlanService().createPlan(recipes: recipes, dateTime: dateTime);
      emit(PlanCreated());
    } catch (e) {
      emit(PlanFailed(e.toString()));
    }
  }

  Future<void> updatePlan({
    required List<String> recipes,
    required DateTime dateTime
  }) async {
    try {
      emit(PlanLoading());
      if(recipes == []){
        emit(PlanFailed("Please choose at least one recipe"));
      }
      await PlanService().updatePlan(recipes: recipes, dateTime: dateTime);
      emit(PlanCreated());
    } catch (e) {
      emit(PlanFailed(e.toString()));
    }
  }
}
