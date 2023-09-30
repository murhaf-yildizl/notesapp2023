import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp2023/routes.dart';

class CheckPhone extends StatelessWidget {
  const CheckPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50,horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle,size: 100,color: Colors.green,),
            SizedBox(height: 10),
            Text("",style: TextStyle( color: Colors.grey.shade600, fontSize: 16)),
            SizedBox(height: 10,),
            Spacer(),
            ElevatedButton(
              onPressed: (){
                Get.offNamedUntil(AppRoute.signIn, (route) => false);
              },
              child:Text('contine'),
              style:Theme.of(context).elevatedButtonTheme.style ,




            )
          ],
        ),
      ),
    );
  }
}
