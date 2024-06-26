import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_states.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(InitialState());
}
