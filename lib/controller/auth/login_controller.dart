import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/api.dart';

class LoginController {

  static Future <dynamic>login(String phone,String password)async
  {
    MyApi api=MyApi(

        {
          "phone":phone,
          "password":password,

        });


      final result = await api.postRequest(MyApi.loginAuth);
         return result;

    }





}
