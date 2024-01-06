import 'package:flutter/material.dart';
import 'package:tellesports/widgets/image_view.dart';

import '../res/app_images.dart';

class LoadingPage extends StatelessWidget {
  final int length;
  const LoadingPage({this.length = 5, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            color:Colors.white,),
        child: Align(child: ImageView.asset(AppImages.appLogo, height: 50,)),
      ),
    );
    
    }}