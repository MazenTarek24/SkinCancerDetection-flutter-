
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_cancer/model/user_model.dart';
import 'package:skin_cancer/modules/login_screen/login_cubit/state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(initialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  })
  {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      print(value.user?.email);
      emit(successLoginState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(errorLoginState());
    });
  }
}