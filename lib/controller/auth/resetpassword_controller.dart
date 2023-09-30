import '../../api/api.dart';
import '../../main.dart';

class ResetPasswordController{


  static Future<dynamic>resetPassword(String password)async
  {

    MyApi api=MyApi(
        {
          "user_id":pref.getString("user_id")!,
          "password":password,

        });

    final result=await api.postRequest(MyApi.resetpassword);



    return result;
  }

}