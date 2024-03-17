import 'package:flutter/material.dart';
import 'package:tellesports/core/utils/size_utils.dart';

import 'custom_elevated_button.dart';

class EmptyWidget extends StatelessWidget {
  final void Function()? onRefresh;
  final String title;
  final String btnText;
  final String? description;
  const EmptyWidget(
      {this.title = 'No data',
      this.description,
      this.onRefresh,
      this.btnText = 'Refresh',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const ImageView.svg(AppImages.icEmptyIcon),
              const SizedBox(height: 25),
              Text(title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600)),
              if (description != null) ...[
                const SizedBox(height: 25),
                Text(description!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400))
              ],
              if (onRefresh != null) ...[
                const SizedBox(height: 25),
                CustomElevatedButton(
                    title: 'Authenticating...',
                    onPressed: onRefresh!,
                    text: btnText,
                    buttonTextStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white),
                    margin: EdgeInsets.symmetric(horizontal: 4.h)),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
