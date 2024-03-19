import 'dart:io';
 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../core/constants/enums.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  ImagePicker picker = ImagePicker();

  File? imageURl;

 
  int _activeTab = 0;

   

  
  Future<void> clearImage() async {
    imageURl = null;
    setViewState(ViewState.success);
  }


  getUnreadMessages(){

  }

  Future<File> fileFromImageUrl(
    String imageUrl,
  ) async {
    String img = imageUrl;
    final response = await http.get(Uri.parse(img));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final String imageName = imageUrl.split('/').last;
    final file = File('${documentDirectory.path}/$imageName');

    await file.writeAsBytes(response.bodyBytes);

    imageURl = file;
    setViewState(ViewState.success);
    return file;
  }

  loadImage(BuildContext context) async {
    await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
               Padding(
                padding: EdgeInsets.only(
                    left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Text('Select the images source',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                         color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400)),
              ),
              ListTile(
                leading:   Icon(
                  Icons.photo_camera,
                  size: 25.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Camera',
                    style: TextStyle(
                        fontSize: 16,
                        // color: AppColors.lightSecondary,
                        fontWeight: FontWeight.w400)),
                onTap: () async {
                  Navigator.pop(context);

                  final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  imageURl = File(image!.path);
                  setViewState(ViewState.success);
                },
              ),
              ListTile(
                leading:   Icon(
                  Icons.photo,
                  size: 25.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Gallery',
                    style: TextStyle(
                        fontSize: 16,
                        // color: AppColors.lightSecondary,
                        fontWeight: FontWeight.w400)),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  imageURl = File(image!.path);
                  setViewState(ViewState.success);
                },
              ),
            ],
          );
        });
  }


  
  String getCurrentTime(int timestampInSeconds) {
    if (timestampInSeconds == '0') {
      return '';
    }
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);

    String time = formatTimeAgo(date);

    setViewState(ViewState.success);

    return time;
  }

  String formatTimeAgo(DateTime inputDate) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(inputDate);

    if (difference.inDays >= 3) {
      return DateFormat.yMMMd().format(inputDate);
    } else if (difference.inDays >= 1) {
      if (difference.inDays == 1) {
        return 'Yesterday';
      } else {
        return '${difference.inDays} days ago';
      }
    } else if (difference.inHours >= 1) {
      if (difference.inHours == 1) {
        return '1 hour ago';
      } else {
        return '${difference.inHours} hours ago';
      }
    } else if (difference.inMinutes >= 1) {
      if (difference.inMinutes == 1) {
        return '1 minute ago';
      } else {
        return '${difference.inMinutes} minutes ago';
      }
    } else {
      return 'Just now';
    }
  }

  List<Map<String, String>> flutterWaveSupportedCurrency = [
  {'countryCode': 'NG', 'currency': 'NGN'}, // Nigeria
  {'countryCode': 'US', 'currency': 'USD'}, // United States
  {'countryCode': 'ZA', 'currency': 'ZAR'}, // South Africa
  {'countryCode': 'KE', 'currency': 'KES'}, // Kenya
  {'countryCode': 'GH', 'currency': 'GHS'}, // Ghana
  {'countryCode': 'UG', 'currency': 'UGX'}, // Uganda
  {'countryCode': 'TZ', 'currency': 'TZS'}, // Tanzania
  {'countryCode': 'RW', 'currency': 'RWF'}, // Rwanda
];
  File? get imgURl => imageURl;

    
}
