import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp2023/api/firebase_auth.dart';
import 'package:notesapp2023/custom_widgets/custom_widgets.dart';
import 'package:notesapp2023/routes.dart';
import 'package:notesapp2023/utilities/dialogs.dart';

import '../../utilities/text_field_validation.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final formKey=GlobalKey<FormState>();
  TextEditingController usernameController=TextEditingController();
  TextEditingController phoneNumberController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool loading=false;
  String? countryCode="+90";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
        child: Form(
          key:formKey ,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Lottie.asset("assets/lottie_icons/login.json", height: 200,width: 300,
                  ),
                  CustomTextFeild(textEditingController:usernameController,type: "username", hint:"17".tr,min:3,max:30,label: "username",),
                  SizedBox(height: 15),
                  countryPicker(),
                  SizedBox(height: 15),
                  CustomTextFeild(textEditingController:passwordController, hint:"16".tr,secure: true,type:"password",min:8,max:30,label: "password",),
                  SizedBox(height:20),
                  loading?Center(child: CircularProgressIndicator()):CustomButton(
                      title:"43".tr,height: 60,width: 200,
                      onpressed:() async {

                        if(!formKey.currentState!.validate())
                          return ;

                        String phone    =(countryCode??"")+phoneNumberController.text.trim();

                        if(!GetUtils.isPhoneNumber(phone)||phone.isEmpty)
                        {
                          showDialogBox(context,"13".tr,"30".tr,DialogType.ERROR);
                          return null;
                        }


                        setState(() {
                          loading=true;

                        });
                       // await SignupController.phoneNumberAuth(phoneNumberController.text.trim()).then((value){
                          String name=usernameController.text.trim();
                          String password=passwordController.text.trim();
                          MyFirebaseAuth myAuth=MyFirebaseAuth();


                             if(await myAuth.userIsExist(phone)==true)
                               {

                                 setState(() {
                                   loading=false;
                                 });
                                 showDialogBox(context,"13".tr,"42".tr, DialogType.error);

                                      }
                            else{
                               await myAuth.verifyPhoneNumber({"name":name,"phone":phone,"password":password,"type":"signup"},context).then((value) {
                                  setState(() {
                                   loading=false;
                                 });
                               });

                             }
                         }),
                  SizedBox(height:10),
                  Text("18".tr,style: TextStyle(fontSize: 16,)),
                  MaterialButton(
                    onPressed:(){
                      Navigator.pushReplacementNamed(context,AppRoute.signIn);
                    },
                    child: Text("7".tr,style: TextStyle(fontSize: 20,),),
                  )

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  countryPicker()
  {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: Get.size.width*0.80,
        height: 80,

        child: IntlPhoneField(

          controller: phoneNumberController,
          keyboardType: TextInputType.phone,
          validator:(value){
            print(")))))))))))");
            print(value);
          },
          onChanged: (val){
            validation("phone",val.toString(),6,12);
          }
          ,
          initialCountryCode: "TR",
          showDropdownIcon: true,
          onCountryChanged: (country){
            countryCode=("+")+country.dialCode;
          },
          dropdownTextStyle:TextStyle(fontWeight: FontWeight.bold) ,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: 14) ,
            labelText: "45".tr,
            labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.red
              ),

            ),
          ),

        ),
      ),
    );

  }
}
