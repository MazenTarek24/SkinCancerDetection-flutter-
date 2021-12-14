
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_cancer/model/user_model.dart';
import 'package:skin_cancer/modules/register_screen/register_cubit/state.dart';

class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit() : super(initialRegisterState());

  static RegisterCubit get(context) =>BlocProvider.of(context);

  void userRegister({
  required String name,
  required String email,
  required String password,
  })
{
  print("creat users");
  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
  )
  .then((value){
    creteUser(
        uid: value.user?.uid,
        name: name,
        email: email,
        password: password
        //phone: phone,
    );
  }).catchError((onError){
    print(onError.toString());
    emit(errorCreateUserState());
  });
}

  void creteUser({
  required  String? uid,
  required String name,
  required String email,
  required String password,

    //required String phone,
  })
  {
    UserModel model = UserModel(
      name: name,
      email: email,
      uid: uid,
      password: password,
    );
    emit(loadingRegisterState()
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
         .set(model.toMap())
       .then((value){

      emit(successRegisterState());

    }).catchError((onError)
    {
      emit(errorRegisterState());
    });
  }

}