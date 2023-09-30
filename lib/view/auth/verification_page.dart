import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:notesapp2023/view/auth/phone_number_verification.dart';


class PhoneVerification extends StatefulWidget {
String? verifyCode,name,phone,password,type;

   PhoneVerification({required this.verifyCode,required this.name,required this.phone,required this.password,required this.type});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<PhoneVerification> {

  final formkey=GlobalKey<FormState>();
  TextEditingController verifyController=TextEditingController();
  bool loading=false;


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:AppBar(
        backgroundColor: Colors.white,
        title:Text("47".tr,style:Theme.of(context).textTheme.titleMedium!.copyWith(color:Colors.grey.shade600 )),

      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            children: [
              Text("32".tr,style:TextStyle(color: Colors.black,fontSize: 16)),
              SizedBox(height: 30,),
              VerifyWidget(verifyCode: widget.verifyCode,name:widget.name,phone: widget.phone,password: widget.password ,type:widget.type )


            ],

          ),
        ),
      ),
    );
  }

}

