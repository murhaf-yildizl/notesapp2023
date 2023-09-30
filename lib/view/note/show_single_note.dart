import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp2023/controller/note/note_controller.dart';
import 'package:notesapp2023/custom_widgets/custom_widgets.dart';
import 'package:notesapp2023/routes.dart';
import 'package:notesapp2023/view/note/edit_note.dart';
import '../../model/note_model.dart';
import '../../utilities/network_image.dart';

class ShowSingleNote extends StatefulWidget {
  late Note note;
   bool loading=false;

   ShowSingleNote({Key? key,required this.note}) : super(key: key);

  @override
  _ShowSingleNoteState createState() => _ShowSingleNoteState();
}

class _ShowSingleNoteState extends State<ShowSingleNote> {
  bool editpressed=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade100,
        toolbarHeight: 50,
        title:Padding(
          padding: const EdgeInsets.all(16),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.black),
          ),
        ) ,
      ),
      body:Container(
        color: Colors.grey.shade100,
        padding: EdgeInsets.all(14),
        child:ListView(
          children: [
           Stack(
             children: [
               drawCard(widget.note),
              ],
           ),

          ],
        ) ,
      ) ,
    );
  }

  Widget drawCard(Note note) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 1,
            blurRadius: 2
           )
        ]
      ),
    height: Get.size.height*0.85,
      child: Card(
          color: Colors.white,
           child:ListView(
             shrinkWrap: true,
             children: [
               Container(
                 width: 250,
                 height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),


                ),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child:note.image!=null?
                CustomNetworkImage(url:note.image.toString()):
                Image.asset("assets/images/notes.png",height: 200,width:double.infinity,fit: BoxFit.fill,),
                  ),
               Padding(
                 padding: const EdgeInsets.all(15),
                 child: SingleChildScrollView(
                     child: Align(
                     alignment: Alignment.center,
                     child: Text(note.title??'',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)))),
               ),
               Padding(
                 padding: const EdgeInsets.all(15),
                 child: SingleChildScrollView(child: Text(note.content??'',style: TextStyle(fontSize: 16),)),
               ),

               Container(height: 50,)
             ],
           )
      ),
    );
  }



}
