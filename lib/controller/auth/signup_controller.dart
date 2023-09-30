import 'package:firebase_auth/firebase_auth.dart';
import '../../api/api.dart';

class SignupController{

  static Future<dynamic>signup(String username,String password,String phone)async
  {

    MyApi api=MyApi(
        {
          "username":username,
          "password":password,
          "phone":phone

        });

       final result=await api.postRequest(MyApi.signupAuth);

               return result;
  }


}
