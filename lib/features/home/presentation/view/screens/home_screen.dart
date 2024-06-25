import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/gen/app_images.dart';
import 'package:masrofatak/features/home/presentation/manager/home_cubit.dart';
import 'package:masrofatak/features/home/presentation/manager/home_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeCubit = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeCubit.homeScreens[homeCubit.bottomNavIndex],
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeStates>(
        bloc: homeCubit,
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: homeCubit.bottomNavIndex,
            onTap: homeCubit.changeBottomNavIndex,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(homeCubit.bottomNavIndex == 0
                      ? Assets.imagesReportBlack
                      : Assets.imagesReportGrey),
                  label: tr('Report')),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(homeCubit.bottomNavIndex == 1
                      ? Assets.imagesHomeBlack
                      : Assets.imagesHomeGrey),
                  label: tr('Home')),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(homeCubit.bottomNavIndex == 2
                      ? Assets.imagesSettingsBlack
                      : Assets.imagesSettingsGrey),
                  label: tr('Settings')),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {} ,
        child: const Icon(Icons.add),
      ),
    );
  }
}
