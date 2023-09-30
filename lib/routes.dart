import 'package:get/get.dart';
import 'package:notesapp2023/utilities/animation.dart';
import 'package:notesapp2023/view/auth/forgetpassword.dart';
import 'package:notesapp2023/view/auth/login_page.dart';
import 'package:notesapp2023/view/auth/resetpassword.dart';
import 'package:notesapp2023/view/auth/signup.dart';
import 'package:notesapp2023/view/auth/verification_page.dart';
import 'package:notesapp2023/view/auth/verification_success.dart';
import 'package:notesapp2023/view/home.dart';
import 'package:notesapp2023/view/note/add_note.dart';
import 'package:notesapp2023/view/note/edit_note.dart';
import 'package:notesapp2023/view/note/show_single_note.dart';
import 'localization/change_language.dart';
import 'model/note_model.dart';


List<GetPage<dynamic>>routes=[
  GetPage(name:AppRoute.home,page:()=>Home()),
  GetPage(name:AppRoute.signIn,page:()=>LogIn()),
  GetPage(name:AppRoute.signUp,page:()=>Signup()),
  GetPage(name:AppRoute.forgetpassword,page:()=>ForgetPassword()),
  GetPage(name:AppRoute.resetpassword,page:()=>ResetPassword()),
  //GetPage(name:AppRoute.emailverify,page:()=>EmailVerification()),
  GetPage(name:AppRoute.checkemail,page:()=>CheckPhone()),
  GetPage(name:AppRoute.languagesetting,page:()=>ChangeLanguage()),
  GetPage(name:AppRoute.addnote,page:()=>AddNote()),
  GetPage(name:AppRoute.shownote,arguments: Note,page:()=>ShowSingleNote(note:Get.arguments),),
  GetPage(name:AppRoute.editnote,arguments: Note ,page:()=>EditNote(note:Get.arguments)),
  GetPage(name:AppRoute.phoneverify,arguments: {'code','name','phone','password','type'} ,page:()=>PhoneVerification(verifyCode:Get.arguments['code'] ,name: Get.arguments['name'],phone: Get.arguments['phone'],password: Get.arguments['password'],type: Get.arguments['type'],)),


];

class AppRoute{

  static const String signIn="/signIn";
  static const String signUp="/signUp";
  static const String signOut="/signOut";
  static const String home="/home";
   static const String forgetpassword="/forgetpassword";
  static const String resetpassword="/resetpassword";
  static const String emailverify="/emailverify";
  static const String phoneverify="/phoneverify";
  static const String checkemail="/checkemail";
  static const String languagesetting="/languagesetting";
  static const String addnote="/addnote";
  static const String editnote="/editnote";
  static const String shownote="/shownote";


}
