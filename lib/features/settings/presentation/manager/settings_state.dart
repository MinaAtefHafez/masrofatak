abstract class SettingsState {}

final class InitState extends SettingsState {}

final class ChangeLanguageState extends SettingsState {
  final int value;

  ChangeLanguageState(this.value);
}
