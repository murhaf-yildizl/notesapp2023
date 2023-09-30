import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../api/api.dart';
import '../../main.dart';
import '../../model/note_model.dart';
import '../../utilities/dialogs.dart';

class NoteController extends GetxController{

    List<Note>_noteList=[];

  List<Note> get noteList => _noteList;

  @override
  Future<void> onInit() async {
   await getNotesList();
     update();

    // TODO: implement onInit
    super.onInit();
  }

   Future getNotesList() async {
     _noteList=[];
    var result=await getNotesApi();

    if(result['status']=="success")
       result['data'].forEach((element) {
        _noteList.add(Note.fromJson(element));
    });
     update();
   }

    Future<dynamic> getNotesApi()async {

    String? userId=pref.getString("user_id").toString();
         print("USER ID= ${userId}");

    if(userId!=null)
    {
     MyApi api=MyApi(

        {
          "user_id":userId
        }
    );

      final  result = await api.postRequest(MyApi.showNotes);

      return result;
           
  }

  }

    Future addNote(BuildContext context,String title,String content,File file,String date )async {
    Map<String,String>body={};

      body={
      "title":title,
      "content":content,
      "date":date,
      "user_id":pref.getString("user_id")!

    };
      MyApi api = MyApi(body);
     final result= await api.postWithFile(MyApi.addNotes,file);

    if(result['status']=="success")
    {
      showDialogBox(context, "success", "41".tr, DialogType.SUCCES);
      Future.delayed(Duration(seconds: 3)).then((value) async {
        await getNotesList();
        Get.offNamedUntil("home", (route) => false);
      });
    }

    else  showDialogBox(context, "faild", result['status'].toString(), DialogType.ERROR);


  }


    Future<dynamic> editNote(BuildContext context,String title,String content,String date,String note_id,String? note_image,File? file)async {
    Map<String,String>body={};

  body=
    {
      "title":title,
      "content":content,
      "date":date,
      "note_id":note_id,
      "old_file":note_image!,
      "user_id":pref.getString("user_id")!

    } ;

     MyApi api = MyApi( body);

    final result;

      if(file!=null)
        result= await api.postWithFile(MyApi.editNotes,file);
   else result= await api.postRequest(MyApi.editNotes);

    if(result['status']=="success")
     {
       showDialogBox(context, "success", "40".tr, DialogType.SUCCES);
       Future.delayed(Duration(seconds: 3)).then((value) async {
        await getNotesList();
         Get.offNamedUntil("home", (route) => false);
       });

     }

   else return "faild";


  }


    void deleteNote(BuildContext context,Note note)async {
      MyApi api=MyApi(
          {
        "note_id":note.note_id.toString(),
         "file":note.image!,
      });
print(note.note_id);

      final result=await api.postRequest(MyApi.deleteNotes);

      if(result['status']=="success")

        showDialogBox(context, "success", "39".tr, DialogType.SUCCES).then((value) async {
         await getNotesList();
          Get.offNamedUntil("home", (route) => false);

        });
      else  showDialogBox(context, "faild", result['status'].toString(), DialogType.ERROR);
    }


}