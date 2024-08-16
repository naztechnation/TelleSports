import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tellesports/common/widgets/custom_button.dart';
import 'package:tellesports/core/utils/size_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/image_view.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Update available',
          style: TextStyle(
            fontWeight: FontWeight.w400,

            // color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                  width: 150,
                  child: (Platform.isAndroid)
                      ? const ImageView.asset(AppImages.playStoreLogo)
                      : const ImageView.asset(
                          AppImages.appleStoreLogo,
                        )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Text(
              'App Update Info!!!',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Text(
              AppStrings.updateInfo,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
            child: Divider(),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    height: 42,
                    text: "No, Close",
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () async {
                      if ((Platform.isAndroid)) {
                        if (await canLaunch(
                            'https://play.google.com/store/apps/details?id=com.tellasport.tellasport')) {
                          await launch(
                              'https://play.google.com/store/apps/details?id=com.tellasport.tellasport');
                        } else {
                          throw 'Could not launch url';
                        }
                      } else {
                        if (await canLaunch(
                            'https://apps.apple.com/us/app/tellasport/id6480112645')) {
                          await launch(
                              'https://apps.apple.com/us/app/tellasport/id6480112645');
                        } else {
                          throw 'Could not launch url';
                        }
                      }
                    },
                    text: 'Update',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
