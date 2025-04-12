import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/constant/app_pages.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuState(selectedPage: AppPages.projects));

  void changePage(AppPages page) {
    emit(state.copyWith(selectedPage: page));
  }
}
