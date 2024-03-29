import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:tellesports/widgets/modals.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? compressedImage;

  try {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      int originalFileSize = imageBytes.length;

      Uint8List uint8List = Uint8List.fromList(imageBytes);

      int compressedFileSize = (originalFileSize / 1024).round();  

      if (compressedFileSize > 150) {
        List<int> compressedBytes = await FlutterImageCompress.compressWithList(
          uint8List,
          minHeight: 1920,
          minWidth: 1080,
          quality: 4,
        );
        compressedImage = File(pickedImage.path)
          ..writeAsBytesSync(compressedBytes);

       } else {
        compressedImage = File(pickedImage.path);
       
      }
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }

  return compressedImage;
}


  
  

Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}

// Future<GiphyGif?> pickGIF(BuildContext context) async {
//   GiphyGif? gif;
//   try {
//     gif = await Giphy.getGif(
//       context: context,
//       apiKey: 'pwXu0t7iuNVm8VO5bgND2NzwCpVH9S0F',
//     );
//   } catch (e) {
//     showSnackBar(context: context, content: e.toString());
//   }
//   return gif;
// }
