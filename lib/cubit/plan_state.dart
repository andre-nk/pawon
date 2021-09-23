part of 'plan_cubit.dart';

abstract class PlanState extends Equatable {
  const PlanState();

  @override
  List<Object> get props => [];
}

class PlanInitial extends PlanState {}

class PlanLoading extends PlanState {}

class PlanCreated extends PlanState {}

class PlanLoaded extends PlanState {
  final PlanModel plan;
  PlanLoaded(this.plan);

  @override
  List<Object> get props => [plan];
}

class PlanFailed extends PlanState {
  final String error;
  PlanFailed(this.error);

  @override
  List<Object> get props => [error];
}
