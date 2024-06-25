import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:masrofatak/core/helpers/sqflite_helper/sqflite_helper.dart';
import 'package:masrofatak/core/helpers/sqflite_helper/sqflite_keys.dart';
import 'package:masrofatak/features/auth/data/models/auth_model.dart';

import '../../../../core/failures/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> signUpWithGoogle();
  Future<void> saveUserDataSQL({required Map<String, Object?> data});
}

class AuthRepoImpl implements AuthRepository {
  @override
  Future<Either<Failure, AuthModel>> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      return Right(AuthModel.fromUserCredintials(user));
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.code));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> saveUserDataSQL({required Map<String, Object?> data}) async {
    SqfliteHelper.insert(data: data, tableName: SqfliteKeys.userTable);
  }
}
