import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/features/home/presentation/manager/home_states.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_details_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/settings_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  int bottomNavIndex = 1;

  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavBar());
  }

  final homeScreens = [
    const HomeDetailsScreen(),
    const HomeDetailsScreen(),
    const SettingsScreen(),
  ];
}
