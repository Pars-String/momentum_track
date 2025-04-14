part of 'menu_cubit.dart';

class MenuState extends Equatable {
  final AppPages selectedPage;
  const MenuState({required this.selectedPage});

  @override
  List<Object> get props => [selectedPage];

  MenuState copyWith({AppPages? selectedPage}) {
    return MenuState(selectedPage: selectedPage ?? this.selectedPage);
  }
}
