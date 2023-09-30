import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp2023/controller/note/note_controller.dart';
import 'package:notesapp2023/custom_widgets/custom_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp2023/utilities/dialogs.dart';
import 'package:notesapp2023/utilities/image_tools.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final formKey=GlobalKey<FormState>();
  TextEditingController titleController=TextEditingController();
  TextEditingController contentController=TextEditingController();
   bool pressed=false;
   File? file;
   ValueNotifier<File> file_notifier=ValueNotifier(File(''));
  NoteController _controller=Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
         title:  Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             IconButton(
               onPressed: (){
                 Navigator.pop(context);
               },
               icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,),
             ),
             Text("11".tr,style: Get.textTheme.titleMedium,),

           ],
         ),
        centerTitle: true,
      ),
      body:Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child:Form(
          key: formKey,
          child: ListView(children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     ValueListenableBuilder(
                         valueListenable: file_notifier,
                         builder: (context,f,_){
                         if(file!=null)
                            return Image.file(file_notifier.value,width: 200,height: 200,fit: BoxFit.fill,);
                       else return Image.asset("assets/images/notes.png",height: 200,width: 200,fit: BoxFit.fill);

                           }
                     )
                      ,

                   Expanded(
                     child: PopupMenuButton(
                       onSelected:(value)async {
                         if (value == 1) {
                          XFile? image=await ImagePicker().pickImage(source:ImageSource.camera);

                          if(image!=null)
                             {
                               file=File(image.path);
                               var bytes= File(image.path).readAsBytesSync();
                                 print(bytes);
                               if(bytes.length>100000)
                               {
                                 file=await ImageTools.compressImage(file) ;


                               }

                               file_notifier.value=file!;

                             }

                         }

                         else if (value == 2) {
                            XFile? image=await ImagePicker().pickImage(source: ImageSource.gallery);

                                if(image!=null)
                             {
                               file=File(image.path);
                               var bytes= File(image.path).readAsBytesSync();
                               print(bytes.length);
                               if(bytes.length>900000)
                               {
                                 file=await ImageTools.compressImage(file) ;


                               }
                           file_notifier.value=file!;




                             }


                         }
                       },

                       icon: Icon(Icons.camera_alt),
                       itemBuilder:(context)=>[
                         PopupMenuItem(
                           child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children:[
                                 IconButton(icon:Icon(Icons.camera_alt,color: Colors.deepPurple,),
                                   onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context){
                                        return Container(
                                            height: 150,
                                            child: Column(children: [],));
                                      }
                                  ) ;
                                   },),
                                 Text("19".tr,style:TextStyle(fontSize: 16,color: Colors.purple,)),

                                 ]
                           ),
                           value: 1,),
                         PopupMenuItem(
                           child:Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children:[
                                 IconButton(icon:Icon(Icons.image_outlined,color: Colors.deepPurple,),
                                   onPressed: () {

                                   },),
                                  Text("20".tr,style:TextStyle(fontSize: 16,color: Colors.purple,)),

                               ]
                           ),
                           value: 2,)

                       ]
                   )
                   )
                   ],),
                 SizedBox(height: 30),
                 CustomTextFeild(textEditingController: titleController, hint: "27".tr,label:"title"),
                 SizedBox(height: 20),
                 CustomTextFeild(textEditingController: contentController, hint: "28".tr,label: "content",),
                 SizedBox(height: 20),
                 !pressed?CustomButton(title:"5".tr,height: 60,width: 150, onpressed:()async{

                   if(file==null)
                     {
                       await showDialogBox(context, "13".tr, "21".tr, DialogType.ERROR);
                       return;
                     }

               else   if(pressed && formKey.currentState!.validate() )
                      return;

              else if(!pressed && formKey.currentState!.validate())
                     {
                       setState(() {
                         pressed=true;

                       });
                     await _controller.addNote(context,titleController.text.trim(),contentController.text.trim(),file!,DateTime.now().toString());
                      }

                 }):Center(child: CircularProgressIndicator())

          ],),
        ) ,
      ) ,
    );
  }

}
