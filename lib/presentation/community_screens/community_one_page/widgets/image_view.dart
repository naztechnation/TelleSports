import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/utils/size_utils.dart';

import '../../../../core/app_export.dart';
import '../../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../provider/auth_provider.dart';

class ShowAllImageView extends StatelessWidget {

  const ShowAllImageView( );

  @override
  Widget build(BuildContext context) {
    final groupInfo = Provider.of<AuthProviders>(context, listen: true);

    return  Scaffold(
      appBar: _buildAppBar(context),
        body: SafeArea(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,  
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: groupInfo.groupImageList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _showFullImage(context, groupInfo.groupImageList[index]);
                },
                child: Hero(
                  tag: groupInfo.groupImageList[index], // Unique tag for each image
                  child: Image.network(
                    groupInfo.groupImageList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
     
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Hero(
                tag: imageUrl, // Matching tag for the image
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

   PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 50.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 0.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Community Gallery",
        margin: EdgeInsets.only(
          top: 0.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
    );
  }
}
