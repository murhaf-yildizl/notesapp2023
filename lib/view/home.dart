import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp2023/controller/note/note_controller.dart';
import 'package:notesapp2023/main.dart';
import 'package:notesapp2023/routes.dart';
import 'package:notesapp2023/utilities/animation.dart';
import '../../utilities/network_image.dart';
import 'package:notesapp2023/view/note/show_single_note.dart';
import '../addmob/addmob.dart';
import '../api/api.dart';
import '../custom_widgets/custom_widgets.dart';
import '../model/note_model.dart';
import '../utilities/convert_date.dart';
import '../utilities/custom_appbar.dart';

class Home extends StatelessWidget {
    List<Note> notes=[];
    NoteController _controller=Get.find<NoteController>();
    BannerAd? bannerAd;
    InterstitialAd? interstitialAd;
    AdMobService adMobService=AdMobService();

   Home({Key? key}) : super(key: key);

   late BuildContext _context;

  @override
  Widget build(BuildContext context) {
     _context=context;
     createAds();

     return Scaffold(
      drawer: Drawer(

        backgroundColor: Colors.white,
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          curve: Curves.linear,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              SizedBox(height: 60,),
              Image.asset("assets/images/notes.png",height: 150,width: 300,),
              ListTile(
                title:Text("8".tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),) ,
                trailing: IconButton(
                  onPressed:()async{
                    String? userId=pref.getString("user_id");
                     await pref.clear();

                     if(userId!=null)
                       pref.setString("user_id",userId);

                    Get.offNamedUntil(AppRoute.signIn, (route) => false);
                  } ,
                  icon: Icon(Icons.logout,color: Colors.purple,),
                ),
              ),
              ListTile(
                title:Text("6".tr,style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold)) ,
                trailing: IconButton(
                  onPressed:(){
                    Get.toNamed(AppRoute.languagesetting);
                  } ,
                  icon: Icon(Icons.settings,color: Colors.purple,),
                ),
              )
            ],),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(title: "14".tr+(_controller.noteList.length>0? " (${_controller.noteList.length}) ":'')),
            GetBuilder<NoteController>(
               builder: (noteController){
                notes=noteController.noteList;

                 if(notes.length>0)
                  return ListView(
                    physics:NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        child:ListView.builder(
                          physics:ScrollPhysics(),
                          shrinkWrap:true ,
                          itemCount:notes.length,
                          itemBuilder:(context,index){
                            return drawCard(notes[index]);
                          } ,

                        ),
                      ),

                      Container(height: 70,)
                    ],
                  );
               else return Column(
                 children: [
                    Padding(
                     padding: const EdgeInsets.all(16),
                     child: Center(child:Text("no data "),),
                   ),
                 ],
               );
               },

            ),
          ],
        ),
      ),
         bottomNavigationBar: Container(
           width: double.infinity,
           height: 100,
           child:bannerAd==null?Text(''): AdWidget(ad: bannerAd!),

         ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          showInterstitialA(1);

          Get.toNamed(AppRoute.addnote);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: BorderSide(
            //width: 4,color: Colors.green
          )
        ) ,
        backgroundColor: Colors.blueAccent,

        child: Icon(Icons.add,color:Colors.white),
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

  Widget drawCard(Note note) {
    return InkWell(
      onTap:(){

        Navigator.of(_context).push( ScaleAnimation(page:ShowSingleNote(note:note)));
      // Get.toNamed(AppRoute.shownote,arguments: note);
      } ,
      child:Slidable(

        key: const ValueKey(0),
         closeOnScroll: true,
        endActionPane: ActionPane(
          
          extentRatio: 0.50,
          // A motion is a widget used to control how the pane animates.
          motion:   ScrollMotion(),

          children:  [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (n){

                Get.toNamed(AppRoute.editnote,arguments: note);
              },

               //backgroundColor: Colors.red,
              foregroundColor: Colors.purple,
              icon: Icons.edit,
              label: '34'.tr,
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(30),
              onPressed: (p){
                confirmDialog(_context,note);
              },
              //backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.purple,
              icon: Icons.delete,
              label: '35'.tr,

            ),

          ],
        ),

        child: Card(
        color: Colors.grey.shade100,
        borderOnForeground:true ,
        shadowColor: Colors.green,
        margin: EdgeInsets.symmetric(vertical: 6),
        child:Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                     margin: EdgeInsets.all(10),
                     child:note.image!=null?
                     CustomNetworkImage(url:note.image.toString()):
                      Image.asset("assets/images/notes.png",height: 100,width: 100,),
                ),
                Expanded(
                  child: ListTile(
                    title:    Text(note.title??'',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 2,),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(note.content??'',overflow: TextOverflow.ellipsis,maxLines: 2),
                    ),
      ),
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
              child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(getDateTime(note.date),style: Get.theme.textTheme.titleSmall,)),
            )
          ],
        )
      ),

    )
    );
  }

   Future confirmDialog(BuildContext context,Note note)async {
       AwesomeDialog(
         context:context,
         title: "25".tr,
         body: Padding(
           padding: const EdgeInsets.all(15),
           child: Text("22".tr,style:TextStyle(fontSize: 16) ,),
         ),
         btnCancel:CustomButton(
             title:"24".tr,height:50,width:150,onpressed:(){
           Navigator.of(context).pop(false);
         }) ,
         buttonsTextStyle:TextStyle(fontSize: 14,fontWeight: FontWeight.normal) ,
         btnOk:CustomButton(title:"23".tr,height:50,width:150,onpressed: (){
           Navigator.of(context).pop(true);
            _controller.deleteNote(context,note);

         },)
     ).show();


   }

    void showInterstitialA(int num) {
      interstitialAd=adMobService.createinterstitialAd(num);

    }

    void createAds()async {
      bannerAd= adMobService.createBannerAd();

    }
}
