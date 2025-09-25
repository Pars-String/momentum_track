import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/features/manage_database/repository/manage_db_repository.dart';

part 'manage_db_state.dart';

class ManageDbCubit extends Cubit<ManageDbState> {
  final ManageDbRepository _repository;
  ManageDbCubit(this._repository) : super(ManageDbInitial());

  void deleteAllData() async {
    emit(ManageDbLoading());

    try {
      await _repository.clearDatabase();
      Future.delayed(Duration(seconds: 2), () => emit(ManageDbSuccess()));
    } catch (_) {
      emit(ManageDbFailure());
    }
  }

  void createBackup() async {
    emit(ManageDbLoading());

    try {
      final isSelected = await _repository.createDatabaseBackup();
      if (isSelected) {
        Future.delayed(Duration(seconds: 2), () => emit(ManageDbSuccess()));
      } else {
        emit(ManageDbInitial());
      }
    } catch (_) {
      emit(ManageDbFailure());
    }
  }

  void recoverData() async {
    emit(ManageDbLoading());

    try {
      final isSelected = await _repository.restoreDatabase();
      if (isSelected) {
        Future.delayed(Duration(seconds: 2), () => emit(ManageDbSuccess()));
      } else {
        emit(ManageDbInitial());
      }
    } catch (_) {
      emit(ManageDbFailure());
    }
  }
}
