import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:notesapp2023/api/firebase_auth.dart';
import 'package:notesapp2023/custom_widgets/custom_widgets.dart';
import 'package:notesapp2023/routes.dart';
import 'package:notesapp2023/utilities/dialogs.dart';

import '../../utilities/text_field_validation.dart';

class ForgetPassword extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<ForgetPassword> {

  final formkey=GlobalKey<FormState>();
  TextEditingController phoneController=TextEditingController();
  bool loading=false;
  String? countryCode="+90";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:AppBar(
        backgroundColor: Colors.transparent,
         leading: IconButton(
            onPressed:(){
              Navigator.pop(context);
            },
            icon:Icon(Icons.arrow_back_ios_sharp,color: Colors.indigo,)
        ),

      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: ListView(
          children: [
            Text("45".tr,style:TextStyle(color: Colors.black,fontSize: 18,)),
            SizedBox(height: 30,),

            Form(
              key: formkey,
              child: Column(

                children: [
                  countryPicker(),
                 // CustomTextFeild(hint:"29".tr,label: 'phone',textEditingController: phoneController,type: "phone"),

                ],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: (){

                if(loading)
                  return;

                if(!formkey.currentState!.validate())
                  return null;

                String phone=(countryCode??"")+phoneController.text.trim();

                 if(!GetUtils.isPhoneNumber(phone)||phone.isEmpty)
                {
                  showDialogBox(context,"13".tr,"30".tr,DialogType.ERROR);
                  return null;
                }

                if(formkey.currentState!.validate())
                {
                  setState(() {
                    loading=true;
                  });
                   checkPhone(phone);
                }
              },
              child:loading?Center(child: CircularProgressIndicator()):
              Text("46".tr),
              style:Theme.of(context).elevatedButtonTheme.style ,
            ),

          ],

        ),
      ),
    );
  }


  checkPhone(String phone)async
  {
    MyFirebaseAuth myFirebaseAuth=MyFirebaseAuth();

    if(await myFirebaseAuth.userIsExist(phone)==true)
      {

        await myFirebaseAuth.verifyPhoneNumber({"phone":phone,"type":"resetpassword"},context);


      }
    else{
      setState(() {
        loading=false;
        showDialogBox(context,"13".tr, "52".tr, DialogType.error);
      });
    }
  }


  countryPicker()
  {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: Get.size.width*0.80,
        height: 80,

        child: IntlPhoneField(
          //textAlign: TextAlign.right,
          controller: phoneController,
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

