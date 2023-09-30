import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp2023/routes.dart';
import 'package:notesapp2023/view/auth/login_page.dart';
import 'package:notesapp2023/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/note/note_controller.dart';
import 'localization/language_getx.dart';
import 'localization/translation.dart';

late SharedPreferences pref;

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  pref = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool? logedin;
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  build(BuildContext context) {
    Get.put(NoteController());
    logedin = pref.getBool("logedin") ?? false;
    LanguageController lang = Get.put(LanguageController());

    bool dataLoaded = false;

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        initialRoute: '/',
        locale: lang.language,
        translations: MyTranslate(),
        theme: lang.appTheme,
        getPages: routes,
        home:FutureBuilder(
                future: Future.delayed(Duration(seconds: 2)),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return splashScreen();
                  else if (snapshot.connectionState == ConnectionState.done) {
                    return logedin==true?Home():LogIn();
                  }
                  return Text('');
                })

    );
  }

  Widget splashScreen() {
    return Container(
        height: 300,
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Lottie.asset("assets/lottie_icons/splash.json",
                width: 400, height: 400)));
  }

}
