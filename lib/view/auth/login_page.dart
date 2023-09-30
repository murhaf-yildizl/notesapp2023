import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp2023/controller/auth/login_controller.dart';
import 'package:notesapp2023/custom_widgets/custom_widgets.dart';
import 'package:notesapp2023/main.dart';
import 'package:notesapp2023/routes.dart';
import 'package:notesapp2023/utilities/text_field_validation.dart';
import '../../controller/note/note_controller.dart';
import '../../utilities/dialogs.dart';


class LogIn extends StatelessWidget {

  final formKey=GlobalKey<FormState>();
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

              InteractiveViewer(
                panEnabled: false, // Set it to false
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.5,
                maxScale: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Lottie.asset("assets/lottie_icons/login.json", height: 200,width: 300,
                    ),
                    countryPicker() ,
                    SizedBox(height: 25),
                    CustomTextFeild(textEditingController:passwordController, hint:"16".tr,secure: true,type: "password",label: "password",min: 8,max: 16,),
                    SizedBox(height:30),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.start ,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: InkWell(
                              onTap:(){
                                String? userId=pref.getString("user_id");
                                print(")))))))))) ${userId}");
                                 if(userId==null)
                                   showDialogBox(context,"13".tr, "54".tr,DialogType.ERROR);
                             else  Get.toNamed(AppRoute.forgetpassword);
                              } ,
                              child: Text('44'.tr,style: TextStyle(color: Colors.blue,fontSize: 16),)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:30),
                    StatefulBuilder(
                        builder:(context,state){

                          return loading?Center(child: CircularProgressIndicator()):CustomButton(title:"7".tr,height: 60,width: 200,
                              onpressed:() async {

                                if(!formKey.currentState!.validate())
                                  return null;

                                String phone    =(countryCode??"")+phoneNumberController.text.trim();
                                String password =passwordController.text.trim();

                                if(!GetUtils.isPhoneNumber(phone)||phone.isEmpty)
                                {
                                  showDialogBox(context,"13".tr,"30".tr,DialogType.ERROR);
                                  return null;
                                }

                                state(() {
                                  loading=true;

                                });

                                await  LoginController.login(phone, password).then((result) async {
                                  if(result['status']=="success")
                                  {
                                    print(result['data']);
                                    pref.setBool("logedin",true);
                                    pref.setString("user_id", result['data']['id'].toString());
                                    pref.setString("username", result['data']['name']);
                                    pref.setString("phone", result['data']['phone']);

                                    Get.find<NoteController>().getNotesList();


                                    bool? seen=pref.getBool("seen");
                                    if(seen ==null || seen==false)
                                      Get.offNamedUntil(AppRoute.languagesetting, (route) => false);
                                    else  {

                                      Get.offNamedUntil(AppRoute.home, (route) => false);
                                    }

                                  }

                                  else
                                  {
                                    state(() {
                                      loading=false;
                                      AwesomeDialog(
                                          dialogType: DialogType.ERROR,
                                          animType: AnimType.SCALE,
                                          context: context,
                                          title: "13".tr ,
                                          body:Padding(
                                            padding:EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                            child:Text(result['status'].toString(),style: TextStyle(fontSize: 18)),

                                          )
                                      ).show();

                                    });
                                  }
                                });

                              });

                        }
                    ),

                    SizedBox(height:10),
                    Text("18".tr,style: TextStyle(fontSize: 16,)),
                    MaterialButton(
                      onPressed:(){
                        Navigator.pushNamed(context, AppRoute.signUp);
                      },
                      child: Padding(
                        padding:EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                        child: Text("9".tr,style: TextStyle(fontSize: 20,),),
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  countryPicker()
  {
      String? lang = Get.locale?.languageCode;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: Get.size.width*0.80,
        height: 80,
        child: IntlPhoneField(
          controller:phoneNumberController ,
           keyboardType: TextInputType.phone,
          validator:(value){

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
            hintTextDirection: TextDirection.rtl,
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

