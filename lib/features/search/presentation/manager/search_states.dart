abstract class SearchStates {}

final class SearchInitial extends SearchStates {}

final class InitSearchMap extends SearchStates {}

final class ChooseItemFromSearchMap extends SearchStates {}


final class FilterSearchListAccordingSearchText extends SearchStates {}


final class ClearSearchList extends SearchStates {}