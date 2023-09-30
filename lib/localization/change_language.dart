import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../routes.dart';
import 'language_getx.dart';


class ChangeLanguage extends StatelessWidget {
  bool? seen;

  ChangeLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    seen=pref.getBool("seen");

       return Scaffold(
       appBar:AppBar(
           backgroundColor: Colors.white,
           title:Text("10".tr,style:Theme.of(context).textTheme.titleMedium!.copyWith(color:Colors.grey.shade600 )),

         ),
       body:SafeArea(

          child:GetBuilder<LanguageController>(
            init: LanguageController(),
            builder:(controller){
               return Container(
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                child: Directionality(
                  textDirection:Get.locale!.languageCode=='ar'?TextDirection.rtl:TextDirection.ltr,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Text("1".tr,style: TextStyle(fontSize: 22,color: Colors.indigo,fontWeight: FontWeight.bold),),
                       SizedBox(height:10 ,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green.shade400,

                        ),
                        width: 200,
                        child: DropdownButton<String>(
                            borderRadius:BorderRadius.circular(20) ,
                            dropdownColor: Colors.green.shade400,
                            value:Get.locale!.languageCode,

                            items:[
                              DropdownMenuItem(
                                  value: 'ar',
                                  child:SizedBox(
                                    child: Text('4'.tr,style: TextStyle(fontSize: 20,color: Colors.white),),
                                  )
                              ),
                              DropdownMenuItem(
                                  value: 'en',
                                  child:Text('3'.tr,style: TextStyle(fontSize: 20,color: Colors.white),)
                              )
                            ],
                            onChanged: (String? val){
                                controller.changeLanguage(val!);

                            }
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        width: 150,
                        child: TextButton(
                            style:Theme.of(context).elevatedButtonTheme.style ,
                            onPressed:()   {

                              if(seen==false|| seen==null) {
                                pref.setBool("seen", true);
                              }
                           Get.offNamedUntil(AppRoute.home,(context)=>false);

                            },

                            child:Text("5".tr,style: TextStyle(fontSize:18,color: Colors.white,fontWeight: FontWeight.normal),)
                        ),
                      )
                    ],),
                ),
              );
            } ,

          )
      ) ,
    );
  }

}


