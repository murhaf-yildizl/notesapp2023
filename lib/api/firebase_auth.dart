import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp2023/utilities/dialogs.dart';

import '../routes.dart';

class MyFirebaseAuth{

  final FirebaseAuth       _auth    =FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  FirebaseAuth get auth => _auth;

  Future<void> verifyPhoneNumber(Map<String,dynamic>data,BuildContext context)async
  {

    try{
     await _auth.verifyPhoneNumber(

      phoneNumber:data['phone'],
      verificationCompleted: (PhoneAuthCredential credential)async{
        showDialogBox(context, "", "succccccessss",DialogType.success);


      },
      verificationFailed: (FirebaseAuthException e) {
        data={"status":"faild","message":e.toString()};
         showDialogBox(context, "error", e.toString(),DialogType.error);
        // if (e.code == 'invalid-phone-number')
        //result={'status':'faild','error':e.message.toString()};
      },
      codeSent: (String verificationId, int? resendToken)  {
        showDialogBox(context, "success", "sentttt",DialogType.success);

        Get.offNamedUntil(AppRoute.phoneverify, (route) => false,arguments:{'code':verificationId,'name':data['name'],'password':data['password'],'phone':data['phone'],'type':data['type']} );


      },
      codeAutoRetrievalTimeout: (String verificationId) {
       },

      timeout: const Duration(seconds: 60),

    );
    }
    catch (err){
      showDialogBox(context, "error", err.toString(),DialogType.error);

    }

   }

  Future<dynamic> saveUserData(Map<String,dynamic>data) async {

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        DocumentReference userDocRef = _firestore.collection('users').doc(uid);

        await userDocRef.set(data).then((value) {
          return {"status":"success"};
        });

        print('Document created and data inserted successfully.');
      } else {
        return {"status":"faild","message":"user not found"};
      }
    } catch (e) {
      return {"status":"faild","message":e.toString()};
    }
  }

  Future<dynamic> signinwithcredentials(String verifyCode,OTBCode)async
  {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyCode, smsCode: OTBCode);

    try
    {
      await _auth.signInWithCredential(credential);
      if (_auth.currentUser != null)
        return {"status": "success"};
      }
      catch(e){
        return {"status":"faild"};

      }

  }

  FirebaseFirestore get firestore => _firestore;



  Future<bool> userIsExist(String phoneNumber)async {

    CollectionReference usersRef = _firestore.collection('users');
    bool isfound=false;
    Map<String,dynamic>? userData;

    QuerySnapshot querySnapshot = await usersRef.where('phone', isEqualTo: phoneNumber).get();

    if (querySnapshot.size > 0) {
      // Assuming you have a single user document with the given name, you can access it like this
      //userData = querySnapshot.docs[0].data() as Map<String, dynamic>;
      isfound=true;
    }

    return isfound;


  }

}