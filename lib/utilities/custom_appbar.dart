import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  String? title;
  String?  page;

  CustomAppBar({ Key? key,this.title, this.page}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: ClipPath(
        clipper: CurvedAppBar(),
        child: Container(
          color: Colors.deepPurple.withOpacity(0.8),
          child: AppBar(
            toolbarHeight: 120,
            iconTheme: IconThemeData(
                color: Colors.white,
                size: 40
            ),
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                Text(title??'', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,fontFamily:'AbyssinicaSIL-Regular' ),),
                Spacer(),

              ],
            ),

          ),
        ),
      ),
      preferredSize: const Size.fromHeight(kToolbarHeight + 100),


    );

  }

}


class CurvedAppBar extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    Path path=Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width/4,size.height-40,size.width/2,size.height-20);
    path.quadraticBezierTo(size.width*3/4,size.height,size.width,size.height-20);
    path.lineTo(size.width,0);

    return path;
    // TODO: implement getClip
    throw UnimplementedError();
  }


  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }



}
