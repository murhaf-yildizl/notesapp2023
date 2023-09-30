import 'package:flutter/material.dart';

ThemeData englishTheme=ThemeData(
colorScheme:ColorScheme.light(
  background: Colors.white,
),
  primaryColor: Colors.indigo,
//scaffoldBackgroundColor:Colors.white,
  sliderTheme: ThemeData.dark().sliderTheme.copyWith(
      valueIndicatorColor: Colors.green,
      valueIndicatorTextStyle: TextStyle(
          backgroundColor: Colors.transparent
      )
  ),
primaryIconTheme: IconThemeData(
color:Colors.black,

),
floatingActionButtonTheme:FloatingActionButtonThemeData(
backgroundColor: Colors.indigo,
foregroundColor: Colors.white
) ,
textTheme: TextTheme(

  displaySmall: TextStyle(
    fontFamily: 'AbyssinicaSIL-Regular',
    fontSize: 16,
    letterSpacing: 2,

  ),
titleMedium: TextStyle(
fontFamily:  'AbyssinicaSIL-Regular',
fontSize: 18,
letterSpacing:1.5,
height:1.5,
fontWeight: FontWeight.bold
),
titleSmall: TextStyle(
fontFamily:  'kufi',
fontSize: 16,
color: Colors.black,
letterSpacing: 1,


),
titleLarge: TextStyle(
fontFamily: 'AbyssinicaSIL-Regular',
fontSize: 16,
letterSpacing: 2,
fontWeight: FontWeight.bold

),



),



appBarTheme:AppBarTheme(
centerTitle:true,
elevation: 0,
toolbarHeight: 90,
backgroundColor: Colors.white,
titleTextStyle:TextStyle(

color:Colors.white,
fontFamily: 'AbyssinicaSIL-Regular',
fontWeight: FontWeight.bold,
letterSpacing:1.5,
fontSize:18,


),
),
tabBarTheme:TabBarTheme(

//indicatorSize: TabBarIndicatorSize.label,
labelPadding: EdgeInsets.all(16),

labelColor:Colors.red,
unselectedLabelColor: Colors.white,
unselectedLabelStyle:TextStyle(
fontSize:16,
fontFamily: 'AbyssinicaSIL-Regular',
letterSpacing: 2
) ,
labelStyle: TextStyle(
letterSpacing: 2,
  fontFamily: 'AbyssinicaSIL-Regular',
)
),
elevatedButtonTheme: ElevatedButtonThemeData(

style:  ElevatedButton.styleFrom(
minimumSize:Size(double.infinity,55) ,


textStyle:TextStyle(

letterSpacing: 2,
fontSize:20,
fontFamily: 'AbyssinicaSIL-Regular',
),

shape:RoundedRectangleBorder(
borderRadius: BorderRadius.circular(50)
),
primary: Colors.indigo.shade800,



)
),

);

ThemeData arabicTheme=ThemeData(
    colorScheme: ColorScheme.light(
        background: Colors.white
    ),
   primaryColor: Colors.indigo,
  sliderTheme: ThemeData.dark().sliderTheme.copyWith(
      valueIndicatorColor: Colors.green,
      valueIndicatorTextStyle: TextStyle(
          backgroundColor: Colors.transparent
      )
  ),
  //scaffoldBackgroundColor:Colors.white,
  primaryIconTheme: IconThemeData(
    color:Colors.black,
    size: 30,

  ),
  floatingActionButtonTheme:FloatingActionButtonThemeData(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white
  ) ,
  textTheme: TextTheme(

    titleMedium: TextStyle(
        fontFamily:  'kufi',
        fontSize: 18,
        letterSpacing:1.5,
        height:1.5,
         color: Colors.black,
        fontWeight: FontWeight.bold
    ),
    titleSmall: TextStyle(
      fontFamily:  'kufi',
      fontSize: 16,
      color: Colors.black,
      letterSpacing: 1,


    ),
    titleLarge: TextStyle(
        fontFamily: 'kufi',
        fontSize: 16,
        letterSpacing: 2,
        fontWeight: FontWeight.bold

    ),
     displaySmall: TextStyle(
        fontFamily: 'kufi',
        fontSize: 16,
        letterSpacing: 2,

    ),



  ),


   appBarTheme:AppBarTheme(
    centerTitle:true,
    elevation: 0,
    toolbarHeight: 90,
    //backgroundColor: Colors.white,
    titleTextStyle:TextStyle(

      color:Colors.black,
      fontFamily: 'kufi',
      fontWeight: FontWeight.bold,
      letterSpacing:1.5,
      fontSize:18,


    ),
  ),
  tabBarTheme:TabBarTheme(

//indicatorSize: TabBarIndicatorSize.label,
      labelPadding: EdgeInsets.all(16),

      labelColor:Colors.red,
      unselectedLabelColor: Colors.white,
      unselectedLabelStyle:TextStyle(
          fontSize:16,
          fontFamily: 'kufi',
          letterSpacing: 2
      ) ,
      labelStyle: TextStyle(
        letterSpacing: 2,
        fontSize:16,
        fontFamily: 'kufi',
      )
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(

      style:  ElevatedButton.styleFrom(
        minimumSize:Size(double.infinity,55) ,


        textStyle:TextStyle(

          letterSpacing: 2,
          fontSize:20,
          fontFamily: 'kufi',
        ),

        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),
        primary: Colors.indigo.shade800,



      )
  ),

);