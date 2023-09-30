import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:notesapp2023/controller/auth/signup_controller.dart';
import 'package:notesapp2023/custom_widgets/custom_widgets.dart';
import 'package:notesapp2023/routes.dart';
import 'package:notesapp2023/utilities/dialogs.dart';

import '../../controller/auth/resetpassword_controller.dart';
class ResetPassword extends StatefulWidget {

  @override
  _ResetPsswordState createState() => _ResetPsswordState();
}

class _ResetPsswordState extends State<ResetPassword> {

  final formkey=GlobalKey<FormState>();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  bool loading=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:AppBar
        (
        backgroundColor: Colors.transparent,
        title:Text("48".tr,style:Theme.of(context).textTheme.titleMedium!.copyWith(color:Colors.grey.shade600 )),

      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: ListView(
          children: [
             SizedBox(height: 30,),

            Form(
              key: formkey,
              child: Column(

                children: [
                  CustomTextFeild(hint:"49".tr,label: 'Password',textEditingController: passwordController,type: "password", secure: true,min:8,max:16),
                  SizedBox(height: 25,),
                  CustomTextFeild(hint:"50".tr,label: 'confirm',textEditingController: confirmPasswordController,type: "password", secure: true,min:8,max:16),


                ],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {

                if(loading)
                  return;
                else  if(formkey.currentState!.validate() )
                {
                  if(passwordController.text.trim().compareTo(confirmPasswordController.text.trim())!=0)
                    showDialogBox(context,"13".tr,"51".tr,DialogType.ERROR);

                  else
                    {
                      setState(() {
                      loading=true;

                     });
                    await  ResetPasswordController.resetPassword(passwordController.text.trim()).then((value) {
                      Get.offNamedUntil(AppRoute.signIn, (route) => false);
                    });

                  }

                  //user_login();
                }
              },
              child:loading?Center(child: CircularProgressIndicator()):
              Text("5".tr),
              style:Theme.of(context).elevatedButtonTheme.style ,
            ),

          ],

        ),
      ),
    );
  }

}

