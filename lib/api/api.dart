import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class MyApi {

  static String base_url        = "https://notesapp.murhaf.net/";
  static String loginAuth       =  base_url+ "auth/login.php";
  static String signupAuth      =  base_url+ "auth/signup.php";
  static String resetpassword   =  base_url+ "auth/resetpassword.php";
  static String showNotes       =  base_url+ "notes/show.php";
  static String addNotes        =  base_url+ "notes/add.php";
  static String editNotes       =  base_url+ "notes/edit.php";
  static String updateNotes     =  base_url+ "notes/update.php";
  static String deleteNotes     =  base_url+ "notes/delete.php";
  static String storage         =  base_url+ "uploads/";
  static String basicAuth       = "Basic "+base64Encode(
                             utf8.encode("murhaf:Stdstdstd1298") );
 //static String cookie=' __test=7f361d65bcec2343bed68f5179fc8618';

   Map<String,String>_header={
     'authorization':basicAuth,
   //  'cookie':cookie
  };
  Map<String,String>_body={};


  MyApi(this._body);

  Future<dynamic> GetRequest(String url)async {
     try
    {
      final response=await http.get(Uri.parse(url),headers:_header);
      //updateCookie(response);

      switch(response.statusCode)
      {
        case 200:
        case 201:{
          final result=jsonDecode(response.body);
             if(result.length>0)
               return result;
             break;
           }
        case 404:{
          return {
            "status":"url not found 404"
          };
        }
        default :{
          return {
            "status":response.body.toString()
          };
        }
      }

    }
    catch(e)
    {
      return {
        "status":"server error!!"
      };
    }
   }


  Future<dynamic> postRequest(String url)async {
     try
    {
        final response=await http.post(Uri.parse(url),body: _body,headers:_header);
//        updateCookie(response);

      print("${url}  ${response.body}");
      switch(response.statusCode)
      {
        case 200:
        case 201:{
           final result=jsonDecode(response.body);
          if(result.length>0)
            return result;
          break;
        }
        case 404:{
          return {
            "status":"url not found 404"
          };
        }
        default :{
          return {
            "status":response.body.toString()
          };
        }
      }

    }
    catch(e)
    {
      print(e.toString());

      return {
        "status":"server error!!"
      };
    }
  }

  Future<dynamic> postWithFile(String url,File file)async
  {
    var request=await http.MultipartRequest("POST",Uri.parse(url),);
    var length=await file.length();
    var stream=http.ByteStream(file.openRead());
    var multipartFile=http.MultipartFile("file",stream,length,filename: basename(file.path));

    request.headers.addAll(_header);
    request.files.add(multipartFile);
    _body.forEach((key, value) {
      request.fields[key]=value;
    });


    var req=await request.send();


    if(req.statusCode==200)
       return {"status":"success"};
  else return {"status":"faild"};

  }


//
//   void updateCookie(http.Response response)
//   {
//
//     print("response############### ${response.headers}");
//     String? rawCookie=response.headers['set-cookie'];
//     //print("^^^^^^^^^^^^^^^^^  ${rawCookie}");
//
//     if(rawCookie!=null)
//       {
//         int index=rawCookie.indexOf(";");
//            cookie=index==-1?rawCookie:rawCookie.substring(0,index);
//
//            print("COOOKIE= ${cookie}");
//       }
//   }
//
 }