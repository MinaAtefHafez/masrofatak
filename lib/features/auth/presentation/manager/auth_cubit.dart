import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/features/auth/presentation/manager/auth_states.dart';

import '../../data/repository/auth_repository.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this._authRepo) : super(InitialAuthState());

  final AuthRepository _authRepo;

  Future<void> signUpWithGoogle() async {
    final result = await _authRepo.signUpWithGoogle();
    result.fold((failure) {
      emit(SignUpGoogleError(failure.errMessage));
    }, (authModel) async {
      await saveUserDataSQL(data: authModel.toMap());
      emit(SignUpGoogleSuccess());
    });
  }

  Future<void> saveUserDataSQL({required Map<String, Object?> data}) async {
    await _authRepo.saveUserDataSQL(data: data);
  }

}
