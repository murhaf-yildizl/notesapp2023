import 'package:flutter/material.dart';

import '../api/api.dart';

class CustomNetworkImage extends StatelessWidget {
  String url;
    CustomNetworkImage({Key? key,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(MyApi.storage+url,height: 200,width: 200,fit:BoxFit.fill);
  }
}
