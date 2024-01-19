import 'package:flutter/material.dart';

import '../core/app_export.dart';
import 'custom_icon_button.dart';

class LoadingPage extends StatefulWidget {
  final int length;

  const LoadingPage({this.length = 5, Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            height: 98.adaptSize,
            width: 98.adaptSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: CustomIconButton(
                height: 98.adaptSize,
                width: 98.adaptSize,
                padding: EdgeInsets.all(5.h),
                decoration: IconButtonStyleHelper.fillPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgLightBulb,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
