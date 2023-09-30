import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:notesapp2023/api/firebase_auth.dart';
import 'package:notesapp2023/routes.dart';
import 'package:notesapp2023/utilities/dialogs.dart';
import 'package:notesapp2023/view/auth/resetpassword.dart';

import '../../controller/auth/signup_controller.dart';

class VerifyWidget extends StatelessWidget {
  String? verifyCode, name, phone, password,type;


  VerifyWidget(
      {Key? key, required this.verifyCode, required this.name, required this.phone, required this.password,required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: OtpTextField(

              borderRadius: BorderRadius.circular(15),
              fieldWidth: 45,
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {

              },
              //runs when every textfield is filled
              onSubmit: (String OTBCode) async {
                MyFirebaseAuth myFirebaseAuth=MyFirebaseAuth();
                 var res=await myFirebaseAuth.signinwithcredentials(verifyCode!, OTBCode);

                   if (res['status']=="success")
                     {
                     if (type == "signup") {
                        await myFirebaseAuth.saveUserData({
                      "name": name,
                      "phone": phone,
                      "uid": myFirebaseAuth.auth.currentUser!.uid
                    });

                    var result = await SignupController.signup(
                        name!, password!, phone!);
                    if (result['status'] == "success")
                      {
                        showDialogBox(context,"13".tr,"33".tr,DialogType.SUCCES);
                        Future.delayed(Duration(seconds: 2),(){
                          Get.offNamedUntil(AppRoute.signIn, (route) => false);

                        });

                      }
                    else
                      showDialogBox(
                          context, "13".tr, "31".tr, DialogType.ERROR);
                  }

                    else if (type == "resetpassword")
                {
                  //showDialogBox(context,"13".tr,"33".tr,DialogType.SUCCES);
                  Future.delayed(Duration(milliseconds: 500 ),(){
                    Get.offNamedUntil(AppRoute.resetpassword, (route) => false);

                  });

                }

                }
                 else
                     {
                  showDialogBox(context, "13".tr, "53".tr, DialogType.ERROR);
                }

                       }
          ),
        )
    );
  }

}