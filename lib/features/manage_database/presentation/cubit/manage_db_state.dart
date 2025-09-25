part of 'manage_db_cubit.dart';

sealed class ManageDbState extends Equatable {
  const ManageDbState();

  @override
  List<Object> get props => [];
}

final class ManageDbInitial extends ManageDbState {}

final class ManageDbLoading extends ManageDbState {}

final class ManageDbSuccess extends ManageDbState {}

final class ManageDbFailure extends ManageDbState {}
