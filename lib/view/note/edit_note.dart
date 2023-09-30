import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp2023/api/api.dart';
import 'package:notesapp2023/controller/note/note_controller.dart';
import 'package:notesapp2023/custom_widgets/custom_widgets.dart';
import 'package:notesapp2023/model/note_model.dart';
import 'package:notesapp2023/utilities/animation.dart';
import '../../utilities/dialogs.dart';
import '../../utilities/network_image.dart';
import '../../utilities/image_tools.dart';

class EditNote extends StatefulWidget {
  Note note;

   EditNote({Key? key,required this.note}) : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  final formKey=GlobalKey<FormState>();
  TextEditingController titleController=TextEditingController();
  TextEditingController contentController=TextEditingController();
  bool pressed=false;
  File? file;
  ValueNotifier<File> file_notifier=ValueNotifier(File(''));
  NoteController _controller=Get.find<NoteController>();

@override
  void initState() {
   titleController.text=widget.note.title??"";
   contentController.text=widget.note.content??"";

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
         title: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             IconButton(
               onPressed: (){
                 Navigator.pop(context);
               },
               icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,),
             ),
             Text("12".tr,style: Get.textTheme.titleMedium,),

           ],
         ),
        backgroundColor: Colors.transparent,
        centerTitle: true,

      ),
      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child:Form(
          key: formKey,
          child: ListView(

             children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 200,
                  width: 200,
                   child: ValueListenableBuilder(
                      valueListenable: file_notifier,
                      builder: (context,f,_){
                        if(file!=null)
                          return Image.file(file_notifier.value,width: 200,height: 200,fit: BoxFit.cover,);
                      else if(widget.note.image!=null)
                              return CustomNetworkImage(url:widget.note.image.toString());
                      else    return Image.asset("assets/images/notes.png",height: 200,width: 200,fit: BoxFit.fill,);

                      }
                  ),
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
                                  Text("الكاميرا",style:TextStyle(fontSize: 16,color: Colors.purple,)),

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
                                  Text("الأستديو",style:TextStyle(fontSize: 16,color: Colors.purple,)),

                                ]
                            ),
                            value: 2,)

                        ]
                    )
                )
              ],),
            SizedBox(height: 40),
            CustomTextFeild(textEditingController: titleController, hint: "27".tr,label:"title",),
            SizedBox(height: 30),
            CustomTextFeild(textEditingController: contentController, hint: "28".tr,label: "content",),
            SizedBox(height: 30),
           !pressed?CustomButton(title:"5".tr,height: 60,width: 150, onpressed:() async {

              if(formKey.currentState!.validate())
                {
                  if(file==null && widget.note.image==null)
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

                  await _controller.editNote(context,titleController.text.trim(),contentController.text.trim(),DateTime.now().toString(),widget.note.note_id.toString(),widget.note.image,file).then((value) {
                        print(value);
                        if(value=="faild")
                        setState(() {
                          showDialogBox(context, "13".tr,"server error", DialogType.ERROR);
                          pressed=false;
                        });
                      });

                }

                }
            }):Center(child: CircularProgressIndicator())

          ],),
        ) ,
      ) ,
    );
  }

 }
