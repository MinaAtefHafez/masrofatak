import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/core/helpers/localization_helper/localization_helper.dart';
import 'package:masrofatak/features/settings/presentation/manager/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(InitState());

  int languageRadioValue = LocalizationUtils.isArabic ? 0 : 1;

  void changeLanguage(int value) {
    languageRadioValue = value;
    emit(ChangeLanguageState(value));
  }
}
